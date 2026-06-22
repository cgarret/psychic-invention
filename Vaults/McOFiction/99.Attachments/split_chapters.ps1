[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$SourceFile = "Shades of Silence - Fractured mosaic.md",

    [Parameter(Mandatory = $false)]
    [string]$DestDir = "Notes",

    [Parameter(Mandatory = $false)]
    [string]$BookTitle = "Shades of Silence - Fractured mosaic",

    [Parameter(Mandatory = $false)]
    [ValidateRange(1, 10)]
    [int]$ChapterNumberPadding = 2,

    [Parameter(Mandatory = $false)]
    [ValidateRange(1, 10)]
    [int]$ParagraphNumberPadding = 2,

    [Parameter(Mandatory = $false)]
    [Alias('ChapterHeader', 'HeaderPattern')]
    [string]$ChapterHeaderPattern = '(?mi)^(?:#{1,6}\s+)?\*{0,3}\s*(?:Chapter|Capitolo)\s+(\d+)\s*[:\.-]?\s*(.*?)\s*\*{0,3}\s*$',

    [Parameter(Mandatory = $false)]
    [Alias('SplitPattern')]
    [string]$ChapterSplitPattern = '(?mi)(?=^(?:#{1,6}\s+)?\*{0,3}\s*(?:Chapter|Capitolo)\s+\d+\b)',

    [Parameter(Mandatory = $false)]
    [switch]$NoIndex,

    [Parameter(Mandatory = $false)]
    [string]$ChapterLevel = "02",

    [Parameter(Mandatory = $false)]
    [string]$ChapterModule = "CH",

    [Parameter(Mandatory = $false)]
    [datetime]$NamingDate = (Get-Date),

    [Parameter(Mandatory = $false)]
    [ValidateRange(0, 999)]
    [int]$RevisionNumber = 0,

    [Parameter(Mandatory = $false)]
    [string]$SourceDocumentTitle = "Shades of Silence - Fractured mosaic",

    [Parameter(Mandatory = $false)]
    [string]$IncludeFrontmatter = "true",

    [Parameter(Mandatory = $false)]
    [string[]]$FrontmatterTags = @("imported", "chapter", "mcofiction")
,
    [Parameter(Mandatory = $false)]
    [string]$AutoConvertWord = "true",

    [Parameter(Mandatory = $false)]
    [string]$PandocCommand = "pandoc",

    [Parameter(Mandatory = $false)]
    [string]$ConvertedMarkdownDirectory = "",

    [Parameter(Mandatory = $false)]
    [string]$KeepConvertedMarkdown = "false",

    [Parameter(Mandatory = $false)]
    [string]$EnablePostProcessing = "true",

    [Parameter(Mandatory = $false)]
    [string]$UseChapterTemplate = "true",

    [Parameter(Mandatory = $false)]
    [string]$ChapterTemplatePath = ""
)

function New-ParagraphSections {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Body,

        [Parameter(Mandatory = $true)]
        [int]$ParagraphNumberPadding
    )

    $sections = @()
    $paragraphs = $Body -split '(?m)^\s*\n'
    $pCount = 1

    foreach ($p in $paragraphs) {
        $cleanedP = $p.Trim()
        if ($cleanedP -match '^\^[a-zA-Z0-9]+$') { continue }
        if ($cleanedP -eq "") { continue }

        $cleanedP = $cleanedP -replace '\s*\^[a-zA-Z0-9]+$', ''
        $sections += ""
        $sections += "## Paragraph $($pCount.ToString().PadLeft($ParagraphNumberPadding, '0'))"
        $sections += $cleanedP
        $pCount++
    }

    return $sections
}

function Convert-ToYamlDoubleQuoted {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Value
    )

    return '"' + ($Value -replace '"', '\\"') + '"'
}

function Convert-ToBooleanValue {
    param(
        [Parameter(Mandatory = $false)]
        [string]$Value,

        [Parameter(Mandatory = $false)]
        [bool]$DefaultValue = $false
    )

    if ([string]::IsNullOrWhiteSpace($Value)) {
        return $DefaultValue
    }

    switch -Regex ($Value.Trim().ToLowerInvariant()) {
        '^(1|true|yes|y|on|\$true)$' { return $true }
        '^(0|false|no|n|off|\$false)$' { return $false }
        default { return $DefaultValue }
    }
}

function New-ChapterFrontmatter {
    param(
        [Parameter(Mandatory = $true)]
        [string]$ChapterTitle,

        [Parameter(Mandatory = $true)]
        [string]$BookTitle,

        [Parameter(Mandatory = $true)]
        [string]$DocumentTitle,

        [Parameter(Mandatory = $true)]
        [string]$ChapterNumberPadded,

        [Parameter(Mandatory = $true)]
        [string]$ChapterShortTitle,

        [Parameter(Mandatory = $true)]
        [string]$ChapterNode,

        [Parameter(Mandatory = $true)]
        [string]$Level,

        [Parameter(Mandatory = $true)]
        [string]$Module,

        [Parameter(Mandatory = $true)]
        [int]$Revision,

        [Parameter(Mandatory = $true)]
        [datetime]$ImportedAt,

        [Parameter(Mandatory = $true)]
        [string[]]$Tags
    )

    $lines = @(
        "---",
        "title: $(Convert-ToYamlDoubleQuoted -Value $ChapterTitle)",
        "book: $(Convert-ToYamlDoubleQuoted -Value $BookTitle)",
        "source_document: $(Convert-ToYamlDoubleQuoted -Value $DocumentTitle)",
        "chapter_number: $([int]$ChapterNumberPadded)",
        "chapter_number_padded: $(Convert-ToYamlDoubleQuoted -Value $ChapterNumberPadded)",
        "chapter_short_title: $(Convert-ToYamlDoubleQuoted -Value $ChapterShortTitle)",
        "node: $(Convert-ToYamlDoubleQuoted -Value $ChapterNode)",
        "level: $(Convert-ToYamlDoubleQuoted -Value $Level)",
        "module: $(Convert-ToYamlDoubleQuoted -Value $Module)",
        "revision: $Revision",
        "imported_at: $(Convert-ToYamlDoubleQuoted -Value ($ImportedAt.ToString('s')))"
    )

    if ($Tags.Count -gt 0) {
        $lines += "tags:"
        foreach ($tag in $Tags) {
            if (-not [string]::IsNullOrWhiteSpace($tag)) {
                $lines += "  - $(Convert-ToYamlDoubleQuoted -Value $tag)"
            }
        }
    }

    $lines += "---"
    return $lines
}

function Convert-ToChapterShortTitle {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RawTitle
    )

    $tokenMatches = [regex]::Matches($RawTitle, '[A-Za-z0-9]+')
    if ($tokenMatches.Count -eq 0) {
        return 'Untitled'
    }

    $parts = foreach ($match in $tokenMatches) {
        $token = $match.Value
        if ($token.Length -eq 1) {
            $token.ToUpperInvariant()
        }
        else {
            $token.Substring(0, 1).ToUpperInvariant() + $token.Substring(1).ToLowerInvariant()
        }
    }

    return ($parts -join '')
}

function Get-NextChapterRevisionNumber {
    param(
        [Parameter(Mandatory = $true)]
        [string]$DestinationDirectory,

        [Parameter(Mandatory = $true)]
        [string]$Level,

        [Parameter(Mandatory = $true)]
        [string]$Module,

        [Parameter(Mandatory = $true)]
        [string]$ShortTitle,

        [Parameter(Mandatory = $true)]
        [datetime]$Date,

        [Parameter(Mandatory = $true)]
        [ValidateRange(0, 999)]
        [int]$MinimumRevision
    )

    if (-not (Test-Path -LiteralPath $DestinationDirectory)) {
        return $MinimumRevision
    }

    $datePart = $Date.ToString('yyyy-MM-dd')
    $basePrefix = "${Level}_${Module}_${ShortTitle}_${datePart}_r"
    $revisionPattern = '^' + [regex]::Escape($basePrefix) + '(\d{2,3})\.md$'
    $maxRevision = -1

    $existingFiles = Get-ChildItem -LiteralPath $DestinationDirectory -File -Filter '*.md'
    foreach ($file in $existingFiles) {
        if ($file.Name -match $revisionPattern) {
            $foundRevision = [int]$matches[1]
            if ($foundRevision -gt $maxRevision) {
                $maxRevision = $foundRevision
            }
        }
    }

    if ($maxRevision -ge 0) {
        return [Math]::Max(($maxRevision + 1), $MinimumRevision)
    }

    return $MinimumRevision
}

function New-ChapterFileNodeName {
    param(
        [Parameter(Mandatory = $true)]
        [string]$ShortTitle,

        [Parameter(Mandatory = $true)]
        [string]$Level,

        [Parameter(Mandatory = $true)]
        [string]$Module,

        [Parameter(Mandatory = $true)]
        [datetime]$Date,

        [Parameter(Mandatory = $true)]
        [ValidateRange(0, 999)]
        [int]$RevisionNumber
    )

    $datePart = $Date.ToString('yyyy-MM-dd')
    $revPart = 'r{0:D2}' -f $RevisionNumber

    return "${Level}_${Module}_${ShortTitle}_${datePart}_${revPart}"
}

function Build-DefaultChapterContent {
    param(
        [Parameter(Mandatory = $true)]
        [bool]$IncludeFrontmatter,

        [Parameter(Mandatory = $true)]
        [string]$ChapterTitle,

        [Parameter(Mandatory = $true)]
        [string]$BookTitle,

        [Parameter(Mandatory = $true)]
        [string]$SourceDocumentTitle,

        [Parameter(Mandatory = $true)]
        [string]$ChapterNumberPadded,

        [Parameter(Mandatory = $true)]
        [string]$ChapterShortTitle,

        [Parameter(Mandatory = $true)]
        [string]$ChapterNode,

        [Parameter(Mandatory = $true)]
        [string]$ChapterLevel,

        [Parameter(Mandatory = $true)]
        [string]$ChapterModule,

        [Parameter(Mandatory = $true)]
        [int]$Revision,

        [Parameter(Mandatory = $true)]
        [string[]]$FrontmatterTags,

        [Parameter(Mandatory = $true)]
        [string[]]$ParagraphLines
    )

    $newContent = @()
    if ($IncludeFrontmatter) {
        $newContent += New-ChapterFrontmatter -ChapterTitle $ChapterTitle -BookTitle $BookTitle -DocumentTitle $SourceDocumentTitle -ChapterNumberPadded $ChapterNumberPadded -ChapterShortTitle $ChapterShortTitle -ChapterNode $ChapterNode -Level $ChapterLevel -Module $ChapterModule -Revision $Revision -ImportedAt (Get-Date) -Tags $FrontmatterTags
        $newContent += ""
    }

    $newContent += "# $ChapterTitle"
    $newContent += $ParagraphLines
    return $newContent
}

function Invoke-ChapterPostProcessing {
    param(
        [Parameter(Mandatory = $false)]
        [object]$Lines
    )

    if ($null -eq $Lines) {
        return @()
    }

    $inputLines = @()
    if ($Lines -is [string]) {
        $inputLines = $Lines -split "\r?\n"
    }
    else {
        $inputLines = @($Lines)
    }

    $processed = @()
    $lastWasBlank = $false

    foreach ($line in $inputLines) {
        $cleanLine = ($line -replace '\s+$', '')
        $isBlank = [string]::IsNullOrWhiteSpace($cleanLine)

        if ($isBlank -and $lastWasBlank) {
            continue
        }

        $processed += $cleanLine
        $lastWasBlank = $isBlank
    }

    return $processed
}

function New-ChapterContentFromTemplate {
    param(
        [Parameter(Mandatory = $true)]
        [string]$TemplatePath,

        [Parameter(Mandatory = $true)]
        [hashtable]$Tokens
    )

    $templateText = [System.IO.File]::ReadAllText($TemplatePath)
    foreach ($key in $Tokens.Keys) {
        $templateText = $templateText.Replace("{{$key}}", [string]$Tokens[$key])
    }

    return ($templateText -split "\r?\n")
}

function Resolve-TemplatePath {
    param(
        [Parameter(Mandatory = $false)]
        [string]$TemplatePath = ""
    )

    if ([string]::IsNullOrWhiteSpace($TemplatePath)) {
        return $null
    }

    if ([System.IO.Path]::IsPathRooted($TemplatePath)) {
        return $TemplatePath
    }

    return (Join-Path (Get-Location).Path $TemplatePath)
}

function Convert-WordDocumentToMarkdown {
    param(
        [Parameter(Mandatory = $true)]
        [string]$WordFilePath,

        [Parameter(Mandatory = $true)]
        [string]$OutputMarkdownPath,

        [Parameter(Mandatory = $true)]
        [string]$PandocExecutable
    )

    $pandocCommandInfo = Get-Command -Name $PandocExecutable -ErrorAction SilentlyContinue
    if (-not $pandocCommandInfo) {
        throw "Pandoc non trovato. Installa pandoc o configura -PandocCommand con un percorso valido."
    }

    $pandocPath = $pandocCommandInfo.Source
    $pandocArgs = @(
        '--from', 'docx',
        '--to', 'gfm',
        '--wrap', 'none',
        '--output', $OutputMarkdownPath,
        $WordFilePath
    )

    & $pandocPath @pandocArgs
    if ($LASTEXITCODE -ne 0) {
        throw "Conversione Word->Markdown fallita (codice $LASTEXITCODE)."
    }

    if (-not (Test-Path -LiteralPath $OutputMarkdownPath)) {
        throw "Pandoc non ha generato il file markdown atteso: $OutputMarkdownPath"
    }
}

function Resolve-SourceMarkdownPath {
    param(
        [Parameter(Mandatory = $true)]
        [string]$SourcePath,

        [Parameter(Mandatory = $true)]
        [string]$DestinationDirectory,

        [Parameter(Mandatory = $true)]
        [bool]$AllowAutoConversion,

        [Parameter(Mandatory = $true)]
        [string]$PandocExecutable,

        [Parameter(Mandatory = $false)]
        [string]$ConvertedDirectory = ""
    )

    $ext = [System.IO.Path]::GetExtension($SourcePath).ToLowerInvariant()
    if ($ext -eq '.md') {
        return @{
            MarkdownPath = $SourcePath
            IsTemporary  = $false
        }
    }

    if ($ext -ne '.docx') {
        throw "Estensione sorgente non supportata: $ext. Usa .md o .docx."
    }

    if (-not $AllowAutoConversion) {
        throw "Input .docx rilevato ma conversione automatica disattivata. Attiva -AutoConvertWord."
    }

    $targetDirectory = $ConvertedDirectory
    if ([string]::IsNullOrWhiteSpace($targetDirectory)) {
        $targetDirectory = Join-Path $DestinationDirectory '.converted'
    }
    elseif (-not [System.IO.Path]::IsPathRooted($targetDirectory)) {
        $targetDirectory = Join-Path (Get-Location).Path $targetDirectory
    }

    if (-not (Test-Path -LiteralPath $targetDirectory)) {
        New-Item -ItemType Directory -Path $targetDirectory -Force | Out-Null
    }

    $safeBaseName = [regex]::Replace([System.IO.Path]::GetFileNameWithoutExtension($SourcePath), '[^A-Za-z0-9_-]', '_')
    if ([string]::IsNullOrWhiteSpace($safeBaseName)) {
        $safeBaseName = 'document'
    }

    $stamp = (Get-Date).ToString('yyyyMMdd-HHmmss')
    $tempMarkdownPath = Join-Path $targetDirectory ("${safeBaseName}_${stamp}.md")

    Convert-WordDocumentToMarkdown -WordFilePath $SourcePath -OutputMarkdownPath $tempMarkdownPath -PandocExecutable $PandocExecutable

    return @{
        MarkdownPath = $tempMarkdownPath
        IsTemporary  = $true
    }
}

if (-not (Test-Path -LiteralPath $SourceFile)) {
    throw "Source file not found: $SourceFile"
}

if (-not (Test-Path -LiteralPath $DestDir)) {
    New-Item -ItemType Directory -Path $DestDir -Force | Out-Null
}

$autoConvertWordFlag = Convert-ToBooleanValue -Value $AutoConvertWord -DefaultValue $true
$includeFrontmatterFlag = Convert-ToBooleanValue -Value $IncludeFrontmatter -DefaultValue $true
$keepConvertedMarkdownFlag = Convert-ToBooleanValue -Value $KeepConvertedMarkdown -DefaultValue $false
$enablePostProcessingFlag = Convert-ToBooleanValue -Value $EnablePostProcessing -DefaultValue $true
$useChapterTemplateFlag = Convert-ToBooleanValue -Value $UseChapterTemplate -DefaultValue $true
$resolvedSourceInputPath = (Resolve-Path -LiteralPath $SourceFile).Path
$resolvedSourcePath = $null
$convertedTempPath = $null

# Default template profile: fast drafting minimal.
if ($useChapterTemplateFlag -and [string]::IsNullOrWhiteSpace($ChapterTemplatePath)) {
    $ChapterTemplatePath = Join-Path (Split-Path -Parent $PSScriptRoot) 'Vaults\McOFiction\Templates\Chapter Template - Fast Drafting Minimal.md'
}

$resolvedTemplatePath = Resolve-TemplatePath -TemplatePath $ChapterTemplatePath

if (-not $useChapterTemplateFlag) {
    $resolvedTemplatePath = $null
}

if ($useChapterTemplateFlag -and $resolvedTemplatePath -and -not (Test-Path -LiteralPath $resolvedTemplatePath)) {
    Write-Warning "Template capitolo non trovato: $resolvedTemplatePath. Uso layout standard."
    $resolvedTemplatePath = $null
}

$sourceResolution = Resolve-SourceMarkdownPath -SourcePath $resolvedSourceInputPath -DestinationDirectory $DestDir -AllowAutoConversion $autoConvertWordFlag -PandocExecutable $PandocCommand -ConvertedDirectory $ConvertedMarkdownDirectory
$resolvedSourcePath = $sourceResolution.MarkdownPath
if ($sourceResolution.IsTemporary) {
    $convertedTempPath = $resolvedSourcePath
}

try {
    $content = [System.IO.File]::ReadAllText($resolvedSourcePath)
    $chapters = $content -split $ChapterSplitPattern
    $chapterFiles = @()

    foreach ($chunk in $chapters) {
        if ($chunk -match $ChapterHeaderPattern) {
            $chapNumRaw = $matches[1]
            $chapNum = $chapNumRaw.PadLeft($ChapterNumberPadding, '0')
            $rawTitleRaw = $matches[2].Trim()
            $shortTitle = Convert-ToChapterShortTitle -RawTitle $rawTitleRaw
            $effectiveRevision = Get-NextChapterRevisionNumber -DestinationDirectory $DestDir -Level $ChapterLevel -Module $ChapterModule -ShortTitle $shortTitle -Date $NamingDate -MinimumRevision $RevisionNumber
            $chapterNodeName = New-ChapterFileNodeName -ShortTitle $shortTitle -Level $ChapterLevel -Module $ChapterModule -Date $NamingDate -RevisionNumber $effectiveRevision
            $fileName = "$chapterNodeName.md"
            $filePath = Join-Path $DestDir $fileName

            $lines = $chunk -split "\r?\n"
            if ($lines.Count -gt 1) {
                $body = ($lines[1..($lines.Count - 1)] -join "`n").Trim()
            }
            else {
                $body = ""
            }

            $paragraphLines = New-ParagraphSections -Body $body -ParagraphNumberPadding $ParagraphNumberPadding

            if ($resolvedTemplatePath) {
                $frontmatterLines = @()
                if ($includeFrontmatterFlag) {
                    $frontmatterLines = New-ChapterFrontmatter -ChapterTitle "Chapter ${chapNumRaw}: ${rawTitleRaw}" -BookTitle $BookTitle -DocumentTitle $SourceDocumentTitle -ChapterNumberPadded $chapNum -ChapterShortTitle $shortTitle -ChapterNode $chapterNodeName -Level $ChapterLevel -Module $ChapterModule -Revision $effectiveRevision -ImportedAt (Get-Date) -Tags $FrontmatterTags
                }

                $tokenMap = @{
                    'FRONTMATTER'          = ($frontmatterLines -join "`n")
                    'TITLE'                = "Chapter ${chapNumRaw}: ${rawTitleRaw}"
                    'CHAPTER_HEADING'      = "# Chapter ${chapNumRaw}: ${rawTitleRaw}"
                    'CHAPTER_NUMBER'       = [string]([int]$chapNumRaw)
                    'CHAPTER_NUMBER_PADDED'= $chapNum
                    'RAW_TITLE'            = $rawTitleRaw
                    'SHORT_TITLE'          = $shortTitle
                    'BOOK_TITLE'           = $BookTitle
                    'SOURCE_DOCUMENT'      = $SourceDocumentTitle
                    'NODE'                 = $chapterNodeName
                    'LEVEL'                = $ChapterLevel
                    'MODULE'               = $ChapterModule
                    'REVISION'             = [string]$effectiveRevision
                    'BODY'                 = ($paragraphLines -join "`n")
                }

                $newContent = New-ChapterContentFromTemplate -TemplatePath $resolvedTemplatePath -Tokens $tokenMap
            }
            else {
                $newContent = Build-DefaultChapterContent -IncludeFrontmatter $includeFrontmatterFlag -ChapterTitle "Chapter ${chapNumRaw}: ${rawTitleRaw}" -BookTitle $BookTitle -SourceDocumentTitle $SourceDocumentTitle -ChapterNumberPadded $chapNum -ChapterShortTitle $shortTitle -ChapterNode $chapterNodeName -ChapterLevel $ChapterLevel -ChapterModule $ChapterModule -Revision $effectiveRevision -FrontmatterTags $FrontmatterTags -ParagraphLines $paragraphLines
            }

            if ($enablePostProcessingFlag) {
                $newContent = Invoke-ChapterPostProcessing -Lines $newContent
            }

            [System.IO.File]::WriteAllLines($filePath, $newContent)
            $chapterFiles += $fileName
        }
    }

    if (-not $NoIndex) {
        $indexContent = @("# $BookTitle - Index", "", "Source: [[$SourceFile]]", "")
        foreach ($f in $chapterFiles) {
            $indexContent += "- [[$f]]"
        }

        [System.IO.File]::WriteAllLines((Join-Path $DestDir "$BookTitle - Index.md"), $indexContent)
    }

    Get-ChildItem -LiteralPath $DestDir | Select-Object -ExpandProperty Name
}
finally {
    if ($convertedTempPath -and -not $keepConvertedMarkdownFlag -and (Test-Path -LiteralPath $convertedTempPath)) {
        Remove-Item -LiteralPath $convertedTempPath -Force -ErrorAction SilentlyContinue
    }
}
