# Postman Vault

This vault is the working area for importing Word documents into Obsidian Markdown and organizing them as books or long-form documents.

## Folder Map

| Folder | Purpose |
|--------|---------|
| [.obsidian/](./.obsidian/) | Obsidian app settings and plugin state |
| [.vscode/](./.vscode/) | VS Code workspace settings |
| [Articoli/](./Articoli/) | Article and essay material |
| [Books/](./Books/) | Book imports and chapter-based content |
| [BOX_NOTE/](./BOX_NOTE/) | Box-style note staging and support material |
| [Clippings/](./Clippings/) | Imported clippings and source excerpts |
| [Documents/](./Documents/) | Long-form document imports |
| [Narrativa/](./Narrativa/) | Narrative and fiction structure |
| [tools/](./tools/) | Helper scripts and utilities |
| [_Attachments/](./_Attachments/) | Media and supporting files |
| [_inbox/](./_inbox/) | Raw incoming material |
| [_templates/](./_templates/) | Reusable note templates |

## MOC Entry Points

| File | Role |
|------|------|
| [MOC_Home.md](MOC_Home.md) | Vault home and main entry point |
| [MOC_Narrativa.md](MOC_Narrativa.md) | Narrative hub for books, fiction, and imported chapters |
| [MOC_Articoli.md](MOC_Articoli.md) | Articles hub for essays and nonfiction notes |
| [Welcome.md](Welcome.md) | Landing note for the vault |

## Naming Grammar

The vault follows a modular filename pattern:

```text
LL_MOD_TitoloDocumento_TitoloCapitoloBreve_YYYY-MM-DD.md
```

Common prefixes include:

- `00_NOT` for notes and fragments
- `01_SCN` for scenes
- `02_CH` for chapters
- `03_ARC` for narrative arcs
- `04_WB` for world building
- `05_GEN` for genealogies
- `06_MAP` for maps and timelines
- `07_RES` for research and sources
- `08_DIA` for diagrams
- `09_FIN` for final versions
- `10_MAC` for macro-level material

Example:

```text
02_CH_LaNebbiaDentro_NelSilenzioDelVetro_2026-06-05.md
```

## Import Workflow

The intended workflow is:

1. Convert a `.docx` source file to Markdown with Pandoc.
2. Split the Markdown into one note per chapter or section.
3. Create a `00 - Index.md` file with a table of contents.
4. Link related notes with Obsidian wikilinks.
5. Move images or other assets into the relevant attachment folder.

## Conversion Rules

- Split books on H1 by default.
- Split long documents on H2 when needed.
- Preserve lists, tables, emphasis, and links during conversion.
- Clean Pandoc artifacts before finalizing notes.
- Keep chapter notes in chapter-number order with a zero-padded prefix.

## Automation Notes

The vault includes [AGENTS.md](AGENTS.md) with the Copilot instructions for document porting.
The instructions emphasize:

- generating a `00 - Index.md` TOC
- using wikilinks for cross-references
- keeping imports grouped by book or document title
- reporting any content that needs manual cleanup

## Suggested Starting Points

If you are exploring this vault, start with the following files:

1. [MOC_Home.md](MOC_Home.md)
2. [MOC_Narrativa.md](MOC_Narrativa.md)
3. [MOC_Articoli.md](MOC_Articoli.md)
4. [Welcome.md](Welcome.md)
