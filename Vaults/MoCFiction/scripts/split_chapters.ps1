[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [string]$SourceFile = "assets/Shades of Silence - Fractured mosaic.docx",

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
    [string]$SplitParagraphs = "false",

    [Parameter(Mandatory = $false)]
    [switch]$SplitParagraphsForEditingTemplates,

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
    [string]$MoveConvertedChaptersToVault = "false",

    [Parameter(Mandatory = $false)]
    [string]$VaultChapterDestination = "Notes/02_CH",

    [Parameter(Mandatory = $false)]
    [string]$EnablePostProcessing = "true",

    [Parameter(Mandatory = $false)]
    [string]$UseChapterTemplate = "true",

    [Parameter(Mandatory = $false)]
    [string]$ChapterTemplatePath = ""
,
    [Parameter(Mandatory = $false)]
    [string]$DefaultsFile = "scripts/split_chapters.defaults.json"
)

function Resolve-DefaultsFilePath {
    param(
        [Parameter(Mandatory = $false)]
        [string]$DefaultsPath = ""
    )

    if ([string]::IsNullOrWhiteSpace($DefaultsPath)) {
        return $null
    }

    $rawDefaultsPath = $DefaultsPath.Trim()
    $workspaceRoot = (Get-Location).Path
    $repoRoot = (Split-Path -Parent $PSScriptRoot)
    $candidatePaths = @()

    if ([System.IO.Path]::IsPathRooted($rawDefaultsPath)) {
        $candidatePaths += $rawDefaultsPath
    }
    else {
        $candidatePaths += (Join-Path $workspaceRoot $rawDefaultsPath)
        $candidatePaths += (Join-Path $repoRoot $rawDefaultsPath)
        $candidatePaths += (Join-Path $PSScriptRoot $rawDefaultsPath)
    }

    $uniqueCandidates = $candidatePaths | Select-Object -Unique
    foreach ($candidatePath in $uniqueCandidates) {
        if (Test-Path -LiteralPath $candidatePath) {
            return (Resolve-Path -LiteralPath $candidatePath).Path
        }
    }

    return $uniqueCandidates[0]
}

function Get-DefaultsMap {
    param(
        [Parameter(Mandatory = $false)]
        [string]$DefaultsPath = ""
    )

    $resolvedDefaultsPath = Resolve-DefaultsFilePath -DefaultsPath $DefaultsPath
    if ([string]::IsNullOrWhiteSpace($resolvedDefaultsPath) -or -not (Test-Path -LiteralPath $resolvedDefaultsPath)) {
        return $null
    }

    try {
        $rawJson = [System.IO.File]::ReadAllText($resolvedDefaultsPath)
        if ([string]::IsNullOrWhiteSpace($rawJson)) {
            return $null
        }

        return ($rawJson | ConvertFrom-Json -AsHashtable)
    }
    catch {
        throw "Defaults file non valido: $resolvedDefaultsPath. Errore: $($_.Exception.Message)"
    }
}

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

    $rawTemplatePath = $TemplatePath.Trim()
    $candidatePaths = @()

    if ([System.IO.Path]::IsPathRooted($rawTemplatePath)) {
        $candidatePaths += $rawTemplatePath
    }
    else {
        $candidatePaths += (Join-Path (Get-Location).Path $rawTemplatePath)
        $candidatePaths += (Join-Path (Split-Path -Parent $PSScriptRoot) $rawTemplatePath)
    }

    $expandedCandidates = @()
    foreach ($candidatePath in $candidatePaths) {
        if ([string]::IsNullOrWhiteSpace($candidatePath)) {
            continue
        }

        $expandedCandidates += $candidatePath

        # Backward compatibility: support legacy paths containing Notes/Templates.
        if ($candidatePath -match '[\\/]Notes[\\/]Templates[\\/]') {
            $expandedCandidates += ($candidatePath -replace '([\\/])Notes([\\/])Templates([\\/])', '$1Templates$3')
        }
    }

    $uniqueCandidates = $expandedCandidates | Select-Object -Unique
    foreach ($candidatePath in $uniqueCandidates) {
        if (Test-Path -LiteralPath $candidatePath) {
            return (Resolve-Path -LiteralPath $candidatePath).Path
        }
    }

    return $uniqueCandidates[0]
}

function Resolve-SourcePath {
    param(
        [Parameter(Mandatory = $false)]
        [string]$SourcePath = ""
    )

    if ([string]::IsNullOrWhiteSpace($SourcePath)) {
        return $null
    }

    $rawSourcePath = $SourcePath.Trim()
    $workspaceRoot = (Get-Location).Path
    $repoRoot = (Split-Path -Parent $PSScriptRoot)
    $candidatePaths = @()

    if ([System.IO.Path]::IsPathRooted($rawSourcePath)) {
        $candidatePaths += $rawSourcePath
    }
    else {
        $candidatePaths += (Join-Path $workspaceRoot $rawSourcePath)
        $candidatePaths += (Join-Path $repoRoot $rawSourcePath)
    }

    if ($rawSourcePath.StartsWith('\') -or $rawSourcePath.StartsWith('/')) {
        $relativeSourcePath = $rawSourcePath.TrimStart('\', '/')
        $candidatePaths += (Join-Path $workspaceRoot $relativeSourcePath)
        $candidatePaths += (Join-Path $repoRoot $relativeSourcePath)
    }

    $uniqueCandidates = $candidatePaths | Select-Object -Unique
    foreach ($candidatePath in $uniqueCandidates) {
        if (Test-Path -LiteralPath $candidatePath) {
            return (Resolve-Path -LiteralPath $candidatePath).Path
        }
    }

    return $uniqueCandidates[0]
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
        $targetDirectory = Join-Path ([System.IO.Path]::GetTempPath()) 'split_chapters'
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

function Move-ChaptersFromConvertedDirectoryToVault {
    param(
        [Parameter(Mandatory = $true)]
        [AllowEmptyCollection()]
        [string[]]$ChapterFilePaths,

        [Parameter(Mandatory = $true)]
        [bool]$EnableMove,

        [Parameter(Mandatory = $true)]
        [string]$TargetDirectory
    )

    if (-not $EnableMove) {
        return @{
            MovedCount            = 0
            DestinationDirectory  = $null
            MovedFileNames        = @()
        }
    }

    if ($null -eq $ChapterFilePaths -or $ChapterFilePaths.Count -eq 0) {
        return @{
            MovedCount            = 0
            DestinationDirectory  = $null
            MovedFileNames        = @()
        }
    }

    if ([string]::IsNullOrWhiteSpace($TargetDirectory)) {
        throw "VaultChapterDestination non valido. Specifica una cartella di destinazione."
    }

    $resolvedTargetDirectory = $TargetDirectory
    if (-not [System.IO.Path]::IsPathRooted($resolvedTargetDirectory)) {
        $resolvedTargetDirectory = Join-Path (Get-Location).Path $resolvedTargetDirectory
    }

    if (-not (Test-Path -LiteralPath $resolvedTargetDirectory)) {
        New-Item -ItemType Directory -Path $resolvedTargetDirectory -Force | Out-Null
    }

    $movedFileNames = @()
    foreach ($chapterPath in $ChapterFilePaths) {
        if ([string]::IsNullOrWhiteSpace($chapterPath)) {
            continue
        }

        if (-not (Test-Path -LiteralPath $chapterPath)) {
            continue
        }

        $parentDir = Split-Path -Parent $chapterPath
        $parentLeaf = Split-Path -Leaf $parentDir
        if (@('.converted', 'converted', '_converted') -notcontains $parentLeaf) {
            continue
        }

        $targetPath = Join-Path $resolvedTargetDirectory ([System.IO.Path]::GetFileName($chapterPath))
        Move-Item -LiteralPath $chapterPath -Destination $targetPath -Force
        $movedFileNames += ([System.IO.Path]::GetFileName($targetPath))
    }

    return @{
        MovedCount            = $movedFileNames.Count
        DestinationDirectory  = $resolvedTargetDirectory
        MovedFileNames        = $movedFileNames
    }
}

$defaultsMap = Get-DefaultsMap -DefaultsPath $DefaultsFile
if ($defaultsMap) {
    if (-not $PSBoundParameters.ContainsKey('SourceFile') -and $defaultsMap.ContainsKey('SourceFile')) {
        $SourceFile = [string]$defaultsMap['SourceFile']
    }

    if (-not $PSBoundParameters.ContainsKey('DestDir') -and $defaultsMap.ContainsKey('DestDir')) {
        $DestDir = [string]$defaultsMap['DestDir']
    }

    if (-not $PSBoundParameters.ContainsKey('BookTitle') -and $defaultsMap.ContainsKey('BookTitle')) {
        $BookTitle = [string]$defaultsMap['BookTitle']
    }

    if (-not $PSBoundParameters.ContainsKey('ChapterNumberPadding') -and $defaultsMap.ContainsKey('ChapterNumberPadding')) {
        $ChapterNumberPadding = [int]$defaultsMap['ChapterNumberPadding']
    }

    if (-not $PSBoundParameters.ContainsKey('ParagraphNumberPadding') -and $defaultsMap.ContainsKey('ParagraphNumberPadding')) {
        $ParagraphNumberPadding = [int]$defaultsMap['ParagraphNumberPadding']
    }

    if (-not $PSBoundParameters.ContainsKey('SplitParagraphs') -and $defaultsMap.ContainsKey('SplitParagraphs')) {
        $SplitParagraphs = [string]$defaultsMap['SplitParagraphs']
    }

    if (-not $PSBoundParameters.ContainsKey('SplitParagraphsForEditingTemplates') -and $defaultsMap.ContainsKey('SplitParagraphsForEditingTemplates')) {
        $SplitParagraphsForEditingTemplates = [System.Management.Automation.SwitchParameter]::new([bool]$defaultsMap['SplitParagraphsForEditingTemplates'])
    }

    if (-not $PSBoundParameters.ContainsKey('ChapterHeaderPattern')) {
        if ($defaultsMap.ContainsKey('ChapterHeaderPattern')) {
            $ChapterHeaderPattern = [string]$defaultsMap['ChapterHeaderPattern']
        }
        elseif ($defaultsMap.ContainsKey('ChapterHeader')) {
            $ChapterHeaderPattern = [string]$defaultsMap['ChapterHeader']
        }
        elseif ($defaultsMap.ContainsKey('headerPattern')) {
            $ChapterHeaderPattern = [string]$defaultsMap['headerPattern']
        }
        elseif ($defaultsMap.ContainsKey('chapterHeaderPattern')) {
            $ChapterHeaderPattern = [string]$defaultsMap['chapterHeaderPattern']
        }
    }

    if (-not $PSBoundParameters.ContainsKey('ChapterSplitPattern')) {
        if ($defaultsMap.ContainsKey('ChapterSplitPattern')) {
            $ChapterSplitPattern = [string]$defaultsMap['ChapterSplitPattern']
        }
        elseif ($defaultsMap.ContainsKey('SplitPattern')) {
            $ChapterSplitPattern = [string]$defaultsMap['SplitPattern']
        }
        elseif ($defaultsMap.ContainsKey('splitPattern')) {
            $ChapterSplitPattern = [string]$defaultsMap['splitPattern']
        }
    }

    if (-not $PSBoundParameters.ContainsKey('NoIndex') -and $defaultsMap.ContainsKey('NoIndex')) {
        $NoIndex = [System.Management.Automation.SwitchParameter]::new([bool]$defaultsMap['NoIndex'])
    }

    if (-not $PSBoundParameters.ContainsKey('ChapterLevel') -and $defaultsMap.ContainsKey('ChapterLevel')) {
        $ChapterLevel = [string]$defaultsMap['ChapterLevel']
    }

    if (-not $PSBoundParameters.ContainsKey('ChapterModule') -and $defaultsMap.ContainsKey('ChapterModule')) {
        $ChapterModule = [string]$defaultsMap['ChapterModule']
    }

    if (-not $PSBoundParameters.ContainsKey('NamingDate') -and $defaultsMap.ContainsKey('NamingDate')) {
        $defaultNamingDate = [string]$defaultsMap['NamingDate']
        if (-not [string]::IsNullOrWhiteSpace($defaultNamingDate)) {
            if ($defaultNamingDate.Trim().ToLowerInvariant() -eq 'now') {
                $NamingDate = Get-Date
            }
            else {
                $NamingDate = [datetime]$defaultNamingDate
            }
        }
    }

    if (-not $PSBoundParameters.ContainsKey('RevisionNumber') -and $defaultsMap.ContainsKey('RevisionNumber')) {
        $RevisionNumber = [int]$defaultsMap['RevisionNumber']
    }

    if (-not $PSBoundParameters.ContainsKey('SourceDocumentTitle') -and $defaultsMap.ContainsKey('SourceDocumentTitle')) {
        $SourceDocumentTitle = [string]$defaultsMap['SourceDocumentTitle']
    }

    if (-not $PSBoundParameters.ContainsKey('IncludeFrontmatter') -and $defaultsMap.ContainsKey('IncludeFrontmatter')) {
        $IncludeFrontmatter = [string]$defaultsMap['IncludeFrontmatter']
    }

    if (-not $PSBoundParameters.ContainsKey('FrontmatterTags') -and $defaultsMap.ContainsKey('FrontmatterTags')) {
        $FrontmatterTags = @($defaultsMap['FrontmatterTags'] | ForEach-Object { [string]$_ })
    }

    if (-not $PSBoundParameters.ContainsKey('AutoConvertWord') -and $defaultsMap.ContainsKey('AutoConvertWord')) {
        $AutoConvertWord = [string]$defaultsMap['AutoConvertWord']
    }

    if (-not $PSBoundParameters.ContainsKey('PandocCommand') -and $defaultsMap.ContainsKey('PandocCommand')) {
        $PandocCommand = [string]$defaultsMap['PandocCommand']
    }

    if (-not $PSBoundParameters.ContainsKey('ConvertedMarkdownDirectory') -and $defaultsMap.ContainsKey('ConvertedMarkdownDirectory')) {
        $ConvertedMarkdownDirectory = [string]$defaultsMap['ConvertedMarkdownDirectory']
    }

    if (-not $PSBoundParameters.ContainsKey('KeepConvertedMarkdown') -and $defaultsMap.ContainsKey('KeepConvertedMarkdown')) {
        $KeepConvertedMarkdown = [string]$defaultsMap['KeepConvertedMarkdown']
    }

    if (-not $PSBoundParameters.ContainsKey('MoveConvertedChaptersToVault') -and $defaultsMap.ContainsKey('MoveConvertedChaptersToVault')) {
        $MoveConvertedChaptersToVault = [string]$defaultsMap['MoveConvertedChaptersToVault']
    }

    if (-not $PSBoundParameters.ContainsKey('VaultChapterDestination') -and $defaultsMap.ContainsKey('VaultChapterDestination')) {
        $VaultChapterDestination = [string]$defaultsMap['VaultChapterDestination']
    }

    if (-not $PSBoundParameters.ContainsKey('EnablePostProcessing') -and $defaultsMap.ContainsKey('EnablePostProcessing')) {
        $EnablePostProcessing = [string]$defaultsMap['EnablePostProcessing']
    }

    if (-not $PSBoundParameters.ContainsKey('UseChapterTemplate') -and $defaultsMap.ContainsKey('UseChapterTemplate')) {
        $UseChapterTemplate = [string]$defaultsMap['UseChapterTemplate']
    }

    if (-not $PSBoundParameters.ContainsKey('ChapterTemplatePath') -and $defaultsMap.ContainsKey('ChapterTemplatePath')) {
        $ChapterTemplatePath = [string]$defaultsMap['ChapterTemplatePath']
    }
}

if (-not (Test-Path -LiteralPath $DestDir)) {
    New-Item -ItemType Directory -Path $DestDir -Force | Out-Null
}

$autoConvertWordFlag = Convert-ToBooleanValue -Value $AutoConvertWord -DefaultValue $true
$includeFrontmatterFlag = Convert-ToBooleanValue -Value $IncludeFrontmatter -DefaultValue $true
$keepConvertedMarkdownFlag = Convert-ToBooleanValue -Value $KeepConvertedMarkdown -DefaultValue $false
$moveConvertedChaptersToVaultFlag = Convert-ToBooleanValue -Value $MoveConvertedChaptersToVault -DefaultValue $false
$enablePostProcessingFlag = Convert-ToBooleanValue -Value $EnablePostProcessing -DefaultValue $true
$useChapterTemplateFlag = Convert-ToBooleanValue -Value $UseChapterTemplate -DefaultValue $true
$splitParagraphsFlag = Convert-ToBooleanValue -Value $SplitParagraphs -DefaultValue $false
$splitParagraphsForEditingTemplatesFlag = [bool]$SplitParagraphsForEditingTemplates
$resolvedSourceInputPath = Resolve-SourcePath -SourcePath $SourceFile
if (-not $resolvedSourceInputPath) {
    throw "Source file not found: $SourceFile"
}
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
    $fallbackChapterHeaderPattern = '(?mi)^(?:#{1,6}\s+)?\*{0,3}\s*(?:Chapter|Capitolo)\s+(\d+)\s*[:\.-]?\s*(.*?)\s*\*{0,3}\s*$'
    $fallbackChapterSplitPattern = '(?mi)(?=^(?:#{1,6}\s+)?\*{0,3}\s*(?:Chapter|Capitolo)\s+\d+\b)'

    $chapters = $content -split $ChapterSplitPattern
    $headerRegex = [regex]::new($ChapterHeaderPattern, [System.Text.RegularExpressions.RegexOptions]::Multiline)
    $headerMatches = $headerRegex.Matches($content)

    if ($headerMatches.Count -eq 0) {
        $fallbackHeaderRegex = [regex]::new($fallbackChapterHeaderPattern, [System.Text.RegularExpressions.RegexOptions]::Multiline)
        $fallbackHeaderMatches = $fallbackHeaderRegex.Matches($content)
        if ($fallbackHeaderMatches.Count -gt 0) {
            $ChapterHeaderPattern = $fallbackChapterHeaderPattern
            $ChapterSplitPattern = $fallbackChapterSplitPattern
            $chapters = $content -split $ChapterSplitPattern
            $headerRegex = $fallbackHeaderRegex
            $headerMatches = $fallbackHeaderMatches
        }
    }

    if ($headerMatches.Count -gt 1) {
        $matchedSplitChunks = 0
        foreach ($chunk in $chapters) {
            if ($chunk -match $ChapterHeaderPattern) {
                $matchedSplitChunks++
            }
        }

        if ($matchedSplitChunks -ne $headerMatches.Count) {
            # Fallback robusto: segmenta per indice dei match reali dell'header capitolo.
            $rebuiltChapters = @()
            for ($i = 0; $i -lt $headerMatches.Count; $i++) {
                $startIndex = $headerMatches[$i].Index
                if ($i -lt ($headerMatches.Count - 1)) {
                    $length = $headerMatches[$i + 1].Index - $startIndex
                }
                else {
                    $length = $content.Length - $startIndex
                }

                $rebuiltChapters += $content.Substring($startIndex, $length)
            }

            $chapters = $rebuiltChapters
        }
    }

    $chapterFiles = @()
    $chapterFilePaths = @()

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

            $shouldSplitParagraphs = $splitParagraphsFlag
            if (-not $shouldSplitParagraphs -and $splitParagraphsForEditingTemplatesFlag -and $resolvedTemplatePath -and $resolvedTemplatePath -match 'Editing Pass') {
                $shouldSplitParagraphs = $true
            }

            if ($shouldSplitParagraphs) {
                $paragraphLines = New-ParagraphSections -Body $body -ParagraphNumberPadding $ParagraphNumberPadding
            }
            else {
                $paragraphLines = @($body)
            }

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
            $chapterFilePaths += $filePath
        }
    }

    if ($chapterFiles.Count -eq 0) {
        throw "Nessun capitolo rilevato. Verifica ChapterHeaderPattern/ChapterSplitPattern nel defaults o passa pattern compatibili con il documento sorgente."
    }

    $moveResult = Move-ChaptersFromConvertedDirectoryToVault -ChapterFilePaths $chapterFilePaths -EnableMove $moveConvertedChaptersToVaultFlag -TargetDirectory $VaultChapterDestination

    if (-not $NoIndex) {
        $indexContent = @("# $BookTitle - Index", "", "Source: [[$SourceFile]]", "")
        foreach ($f in $chapterFiles) {
            $indexContent += "- [[$f]]"
        }

        [System.IO.File]::WriteAllLines((Join-Path $DestDir "$BookTitle - Index.md"), $indexContent)
    }

    $resultFiles = @($chapterFiles)
    if (-not $NoIndex) {
        $resultFiles += "$BookTitle - Index.md"
    }

    $resultFiles
}
finally {
    if ($convertedTempPath -and -not $keepConvertedMarkdownFlag -and (Test-Path -LiteralPath $convertedTempPath)) {
        Remove-Item -LiteralPath $convertedTempPath -Force -ErrorAction SilentlyContinue
    }
}
