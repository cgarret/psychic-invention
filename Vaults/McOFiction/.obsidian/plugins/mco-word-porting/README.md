# MCO Word Porting (Obsidian plugin locale)

## Cosa fa

- Avvia `split_chapters.ps1` direttamente da Obsidian.
- Converte automaticamente file Word `.docx` in markdown prima dello split (via Pandoc).
- Trigger disponibili:
  - Command Palette: `Avvia porting documento (split chapters)`
  - Command Palette: `Crea nuovo capitolo da template`
  - Ribbon icon
  - Menu contestuale file `.md`
  - Auto-run all'avvio (opzionale)
  - Auto-porting da cartella monitorata (opzionale)
- Mostra un form (modal) per inserire i parametri principali.
- I file generati includono frontmatter YAML (se attivo).
- Post-processing automatico opzionale dei capitoli generati.
- Supporto template capitolo riusabile sia per split automatico sia per nuovo capitolo manuale.

## Alias directory virtuali

Il plugin supporta i path virtuali introdotti nel vault:

- `scripts://` -> cartella di progetto `scripts/` (esterna al vault)
- `assets://` -> cartella di progetto `assets/` (esterna al vault)
- `vault://` -> root della vault attiva

Esempi:

- `scripts://split_chapters.ps1`
- `assets://LaNebbiaDentro.docx`
- `vault://Notes`

## Requisito conversione Word

- Installa `pandoc` nel sistema (comando disponibile nel PATH), oppure imposta il percorso eseguibile in `Comando Pandoc` nelle impostazioni plugin.
- Se `Comando Pandoc` resta su `pandoc`, il plugin prova automaticamente anche il fallback Windows `AppData/Local/Pandoc/pandoc.exe`.
- Di default il markdown convertito da `.docx` viene mantenuto in `Notes/.converted` (opzione `Mantieni markdown convertiti` attiva).

## Default impostati per il tuo scenario

- Documento: `Shades of Silence - Fractured mosaic.md`
- Titolo documento: `Shades of Silence - Fractured mosaic`
- Output: `Notes`
- Vault root: `Vaults/McOFiction` (rilevato automaticamente da Obsidian)

## Setup rapido

1. Apri Obsidian sul vault `McOFiction`.
2. Vai in Settings -> Community plugins.
3. Disattiva Safe mode (se attivo).
4. Abilita plugin `MCO Word Porting`.
5. Apri Settings -> MCO Word Porting e verifica questi valori: `Script path relativo al vault` = `../../scripts/split_chapters.ps1`, `Documento sorgente default`, `Directory output default`, `Template capitolo` = `Templates/Chapter Template - Fast Drafting Minimal.md`.

Valori consigliati con directory virtuali:

- `Script path relativo al vault`: `scripts://split_chapters.ps1`
- `Documento sorgente default`: `assets://Shades of Silence - Fractured mosaic.md` (o `.docx`)
- `Directory output default`: `Notes` (oppure `vault://Notes`)
- `Template capitolo`: `Templates/Chapter Template - Fast Drafting Minimal.md`
- `Mantieni markdown convertiti`: `ON` (salva il file convertito in `Notes/.converted`)

## Template capitolo

- Template default creato in `Templates/Chapter Template.md`.
- Template narrativo avanzato creato in `Templates/Chapter Template - Narrative.md`.
- Placeholder disponibili nel template:
  - `{{FRONTMATTER}}`, `{{CHAPTER_HEADING}}`, `{{BODY}}`
  - `{{TITLE}}`, `{{CHAPTER_NUMBER}}`, `{{CHAPTER_NUMBER_PADDED}}`
  - `{{RAW_TITLE}}`, `{{SHORT_TITLE}}`, `{{BOOK_TITLE}}`, `{{SOURCE_DOCUMENT}}`
  - `{{NODE}}`, `{{LEVEL}}`, `{{MODULE}}`, `{{REVISION}}`

Per usare il template narrativo:

1. Apri Settings -> MCO Word Porting.
2. Imposta `Template capitolo` su `Templates/Chapter Template - Narrative.md`.
3. Lascia attivo `Usa template capitolo`.

## Note su input

- Input supportati: `.md` e `.docx`.
- Se il file è `.docx`, il plugin invia automaticamente i parametri di conversione allo script.
- Se disattivi `Mantieni markdown convertiti`, il `.md` intermedio viene eliminato al termine del porting.
