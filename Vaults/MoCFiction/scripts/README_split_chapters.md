# Split Chapters Script - README

Questo documento descrive le funzioni presenti in split_chapters.ps1, la logica di naming dei file capitolo e la conversione automatica da Word a Markdown.

## Scopo

Lo script legge un file sorgente (`.md` o `.docx`), individua i capitoli, crea un file Markdown per ogni capitolo e genera (opzionalmente) un file index.

## Parametri principali

- SourceFile: file di input (`.md` oppure `.docx`).
- DestDir: cartella di output per i file generati (consigliata: `Notes/02_CH`).
- BookTitle: titolo libro usato nell'index.
- ChapterNumberPadding: padding del numero capitolo nel contenuto (es. 01, 02).
- ParagraphNumberPadding: padding del numero paragrafo nel contenuto (es. 01, 02).
- SplitParagraphs: se true divide il body in paragrafi separati; default false.
- SplitParagraphsForEditingTemplates: se presente divide i paragrafi solo con template di editing; default false.
- ChapterHeaderPattern: regex per riconoscere l'header del capitolo (supporta formati con/senza `#`, con enfasi markdown e parole `Chapter`/`Capitolo`; compatibile anche con alias `ChapterHeader`/`HeaderPattern`).
- ChapterSplitPattern: regex per dividere il documento in blocchi capitolo (compatibile anche con alias `SplitPattern`/`splitPattern` in CLI e defaults).
- NoIndex: se presente, non genera il file index.
- ChapterLevel: valore Livello per il nome file capitolo (default: 02).
- ChapterModule: valore Modulo per il nome file capitolo (default: CH).
- NamingDate: data usata nel nome file (formato YYYY-MM-DD).
- RevisionNumber: revisione minima iniziale (default: 0 => r00).
- AutoConvertWord: abilita conversione automatica per input `.docx`.
- PandocCommand: comando/path per l'eseguibile pandoc.
- ConvertedMarkdownDirectory: cartella per markdown convertiti da Word (default: cartella temporanea di sistema `.../split_chapters`, fuori dal vault Obsidian).
- KeepConvertedMarkdown: se true mantiene i markdown temporanei convertiti da Word.
- MoveConvertedChaptersToVault: se true sposta i capitoli generati da una cartella di conversione (`converted`, `_converted` o `.converted`) verso la cartella vault di destinazione.
- VaultChapterDestination: cartella target per lo spostamento capitoli da `.converted` (default: `Notes/02_CH`).
- EnablePostProcessing: pulizia automatica del contenuto generato (spazi finali e righe vuote duplicate).
- UseChapterTemplate: se true applica un template ai capitoli generati.
- ChapterTemplatePath: percorso template markdown con placeholder per il rendering del capitolo.
- DefaultsFile: percorso del file JSON con i valori di default dei parametri (default: `scripts/split_chapters.defaults.json`).

Default corrente:

- I default principali sono esternalizzati in [split_chapters.defaults.json](split_chapters.defaults.json).
- Se `UseChapterTemplate` e true e `ChapterTemplatePath` non viene passato, lo script usa automaticamente `Vaults/McOFiction/Templates/Chapter Template - Fast Drafting Minimal.md`.

Placeholder template supportati:

- `{{FRONTMATTER}}`
- `{{TITLE}}`
- `{{CHAPTER_HEADING}}`
- `{{CHAPTER_NUMBER}}`
- `{{CHAPTER_NUMBER_PADDED}}`
- `{{RAW_TITLE}}`
- `{{SHORT_TITLE}}`
- `{{BOOK_TITLE}}`
- `{{SOURCE_DOCUMENT}}`
- `{{NODE}}`
- `{{LEVEL}}`
- `{{MODULE}}`
- `{{REVISION}}`
- `{{BODY}}`

Template disponibili nel vault:

- `Vaults/McOFiction/Templates/Chapter Template.md` (base)
- `Vaults/McOFiction/Templates/Chapter Template - Narrative.md` (narrative card estesa)
- `Vaults/McOFiction/Templates/Chapter Template - Fast Drafting Minimal.md` (bozza rapida, molto snello)
- `Vaults/McOFiction/Templates/Chapter Template - Editing Pass Structural.md` (revisione strutturale)

## Naming grammar dei capitoli

Formato file capitolo:

[Livello]_[Modulo]_[TitoloBreve]_[Data]_[Rev].md

Dettagli:

- Livello: ChapterLevel (default 02)
- Modulo: ChapterModule (default CH)
- TitoloBreve: derivato dal titolo capitolo in CamelCase
- Data: NamingDate nel formato YYYY-MM-DD
- Rev: rNN (2 cifre minime), es. r00, r01, r10

Esempio:

02_CH_TheIntrusion_2026-05-27_r00.md

## Funzioni

### New-ParagraphSections

Input:

- Body
- ParagraphNumberPadding

Comportamento:

- Divide il body in paragrafi su righe vuote.
- Salta paragrafi vuoti.
- Salta paragrafi composti solo da marker tipo ^id.
- Rimuove marker finali tipo ^id.
- Restituisce blocchi Markdown con heading, ad esempio:

Nota:

- Lo script usa questa logica solo quando `SplitParagraphs` è attivo; di default il capitolo viene mantenuto come blocco unico.
- Se `SplitParagraphsForEditingTemplates` è attivo, la stessa logica si applica solo quando il template selezionato corrisponde al template di editing.

```markdown
## Paragraph 01
testo paragrafo
```

### Convert-ToChapterShortTitle

Input:

- RawTitle

Comportamento:

- Estrae token alfanumerici.
- Converte in CamelCase.
- Se non trova token validi, usa Untitled.

Esempio:

- "the intrustion" -> "TheIntrustion"
- "chapter-2: the return" -> "Chapter2TheReturn"

### Get-NextChapterRevisionNumber

Input:

- DestinationDirectory
- Level
- Module
- ShortTitle
- Date
- MinimumRevision

Comportamento:

- Cerca file esistenti con stesso prefisso:
  Level_Module_ShortTitle_Date_rNN.md
- Se trova revisioni, usa max + 1.
- Garantisce almeno MinimumRevision.

Risultato pratico:

- Primo file: r00
- Successivo stesso nodo base: r01
- Poi r02, r03, ...

### New-ChapterFileNodeName

Input:

- ShortTitle
- Level
- Module
- Date
- RevisionNumber

Output:

- Nodo filename in formato:
  Level_Module_ShortTitle_YYYY-MM-DD_rNN

### Move-ChaptersFromConvertedDirectoryToVault

Input:

- ChapterFilePaths
- EnableMove
- TargetDirectory

Comportamento:

- Se `EnableMove` e false, non esegue alcuno spostamento.
- Se `ChapterFilePaths` e vuoto, termina senza errore e senza creare cartelle target.
- Se `EnableMove` e true, sposta solo i capitoli effettivamente generati dentro una cartella chiamata `.converted`.
- Crea automaticamente la cartella target se non esiste.
- Anche se i capitoli vengono spostati, l'index resta nella cartella `DestDir` (tipicamente `Notes`).

## Flusso logico

1. Legge SourceFile.
2. Divide il contenuto in blocchi capitolo.
  - Usa `ChapterSplitPattern` come prima strategia.
  - Se `ChapterHeaderPattern` non produce match, applica fallback automatico ai pattern robusti interni (`Chapter|Capitolo`) per evitare falsi negativi da differenze di contesto esecuzione.
  - Se il numero di blocchi non coincide con i match reali di `ChapterHeaderPattern`, applica fallback per indice match header.
3. Per ogni capitolo:
   - Estrae numero e titolo.
   - Crea TitoloBreve in CamelCase.
   - Calcola revisione progressiva.
   - Costruisce nome file con grammar standard.
   - Trasforma il body in sezioni paragrafo.
   - Scrive file capitolo.
4. Se abilitato (`MoveConvertedChaptersToVault=true`), sposta i capitoli generati dentro `.converted` verso `VaultChapterDestination`.
5. Se NoIndex non e impostato, crea il file index nella cartella `DestDir`.

Se non viene rilevato alcun capitolo, lo script termina con errore esplicito invece di produrre output ambiguo.

## Esempi di esecuzione

Con vault Obsidian e directory virtuali (`scripts://` e `assets://`), il plugin `MCO Word Porting` risolve automaticamente i path verso le cartelle esterne del progetto.

Valori consigliati nelle impostazioni plugin:

- Script path: `scripts://split_chapters.ps1`
- Documento sorgente: `assets://nome-file.md` oppure `assets://nome-file.docx`
- Output: `Notes` oppure `vault://Notes`

Esecuzione base:

pwsh -File ./scripts/split_chapters.ps1 -SourceFile "Alektorophobia_revised.md"

Con cartella custom e data fissa:

pwsh -File ./scripts/split_chapters.ps1 -SourceFile "book.md" -DestDir "Notes/Book" -NamingDate "2026-05-27"

Con file defaults custom:

pwsh -File ./scripts/split_chapters.ps1 -DefaultsFile "scripts/split_chapters.defaults.json" -SourceFile "book.md"

Con revisione minima forzata:

pwsh -File ./scripts/split_chapters.ps1 -SourceFile "book.md" -RevisionNumber 5

Input Word con conversione automatica:

pwsh -File ./scripts/split_chapters.ps1 -SourceFile "book.docx" -DestDir "Notes" -AutoConvertWord true -PandocCommand "pandoc"

Con template e post-processing:

pwsh -File ./scripts/split_chapters.ps1 -SourceFile "book.docx" -DestDir "Notes" -UseChapterTemplate true -ChapterTemplatePath "Vaults/McOFiction/Templates/Chapter Template.md" -EnablePostProcessing true

Con move dei capitoli da `.converted` a `Notes/02_CH`:

pwsh -File ./scripts/split_chapters.ps1 -SourceFile "book.docx" -DestDir "Notes/.converted" -MoveConvertedChaptersToVault true -VaultChapterDestination "Notes/02_CH"

Variante fast drafting minimal:

pwsh -File ./scripts/split_chapters.ps1 -SourceFile "book.md" -DestDir "Notes" -UseChapterTemplate true -ChapterTemplatePath "Vaults/McOFiction/Templates/Chapter Template - Fast Drafting Minimal.md"

Variante editing pass (revisione strutturale):

pwsh -File ./scripts/split_chapters.ps1 -SourceFile "book.md" -DestDir "Notes" -UseChapterTemplate true -ChapterTemplatePath "Vaults/McOFiction/Templates/Chapter Template - Editing Pass Structural.md"

Variante editing pass con paragrafi separati:

pwsh -File ./scripts/split_chapters.ps1 -SourceFile "book.md" -DestDir "Notes" -UseChapterTemplate true -ChapterTemplatePath "Vaults/McOFiction/Templates/Chapter Template - Editing Pass Structural.md" -SplitParagraphsForEditingTemplates

Senza index:

pwsh -File ./scripts/split_chapters.ps1 -SourceFile "book.md" -NoIndex

## Note operative

- Se DestinationDirectory non esiste, viene creata.
- SourceFile deve esistere, altrimenti lo script termina con errore.
- Se SourceFile e `.docx`, serve Pandoc disponibile.
- Il file index mantiene il formato wiki link usato nel vault.
