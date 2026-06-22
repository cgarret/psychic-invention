# Copilot Instructions – Postman Vault

## Purpose
This Obsidian vault is used to **port Word (.docx) documents and books into Obsidian Markdown**, splitting them into well-structured notes organized by chapters and sections.

## Vault Structure Convention
```
/
├── _inbox/          # Raw imported content (staging area)
├── Books/
│   └── <BookTitle>/
│       ├── 00 - Index.md          # TOC with [[wikilinks]] to chapters
│       ├── 01 - Chapter Name.md
│       ├── 02 - Chapter Name.md
│       └── ...
├── Documents/
│   └── <DocTitle>/
│       ├── 00 - Index.md
│       └── <sections as notes>
└── _templates/      # Reusable note templates
```

## Conversion Guidelines
- Convert `.docx` headings (H1/H2/H3) to Markdown `#`/`##`/`###`
- Each top-level chapter (H1 or H2) becomes its own `.md` file
- Use Obsidian **wikilinks** (`[[Note Name]]`) for cross-references
- Preserve bold, italic, lists, and tables in Markdown
- Images: save to `<BookTitle>/assets/` and embed with `![[image.png]]`
- Footnotes: convert to inline callouts `> [!note]` or bottom-of-note references
- Strip Word-specific artifacts (revision marks, comments, field codes)

## Splitting Rules
- Split on **H1** by default for books; split on **H2** for long documents
- Name files as `NN - Title.md` where NN is zero-padded chapter number
- Always create a `00 - Index.md` with a full TOC using `[[wikilinks]]`
- Add YAML frontmatter to each note:
  ```yaml
  ---
  title: "Chapter Title"
  book: "Book Title"
  chapter: 1
  tags: [book, imported]
  ---
  ```

## Naming Grammar (Grammatica dei Nomi)

File naming convention:

```
LL_MOD_TitoloDocumento_TitoloCapitoloBreve_YYYY-MM-DD.md
```

| Prefisso | Tipo | Descrizione |
|----------|------|-------------|
| `00_NOT` | Note | Note, idee, frammenti |
| `01_SCN` | Scene | Scene singole |
| `02_CH` | Capitoli | Capitoli completi |
| `03_ARC` | Archi narrativi | Struttura degli archi |
| `04_WB` | World Building | Costruzione del mondo |
| `05_GEN` | Genealogie | Alberi genealogici, personaggi |
| `06_MAP` | Mappe | Diagrammi, linee temporali |
| `07_RES` | Ricerca | Fonti, riferimenti |
| `08_DIA` | Diagrammi | Diagrammi modulari |
| `09_FIN` | Versioni finali | Draft definitivi |
| `10_MAC` | Macro | Visione d'insieme |

**Esempio:** `02_CH_LaNebbiaDentro_NelSilenzioDelVetro_2026-06-05.md`

## Struttura MOC

- `MOC_Home.md` — hub principale del vault
- `MOC_Narrativa.md` — hub per romanzi, racconti
- `MOC_Articoli.md` — hub per articoli, saggi

Ogni categoria ha sottocartelle per ciascun prefisso (`00_NOT/`, `01_SCN/`, ecc.).

## Tools & Workflow
- Use **Pandoc** (`pandoc input.docx -t markdown -o output.md`) for initial conversion
- Then split the output into per-chapter files following the naming convention above
- Clean up Pandoc artifacts (e.g., `{.underline}`, `:::` divs, hard line breaks)

## Copilot Tasks
When asked to process a document, Copilot should:
1. Parse headings to identify split points
2. Generate individual chapter `.md` files with correct frontmatter
3. Generate a `00 - Index.md` TOC
4. Report any content that needs manual review (images, tables, footnotes)
