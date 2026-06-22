# Vaults Overview

This folder contains several Obsidian vaults and a small converter utility for generating DOCX exports from Markdown notes.

## Vaults

| Vault | Purpose | Entry notes |
|-------|---------|-------------|
| [psychic](psychic/) | Markdown-to-DOCX conversion utility used on Obsidian notes | [obsidian_docx_converter.py](psychic/obsidian_docx_converter.py), [test_obsidian_docx_converter.py](psychic/test_obsidian_docx_converter.py) |
| [psychic-docx-export](psychic-docx-export/) | Generated DOCX export from the psychic vault | Export output created by the converter |
| [master-pi](master-pi/) | Mixed personal vault with narrative and research notes | [MOC- HOME.md](master-pi/MOC-%20HOME.md), [NOTES_BOX/MOC Articles.md](master-pi/NOTES_BOX/MOC%20Articles.md), [NOTES_BOX/MOC Tech Topic.md](master-pi/NOTES_BOX/MOC%20Tech%20Topic.md) |
| [McOFiction](McOFiction/) | Fiction-oriented vault with book and narrative organization | [MOC HOME.md](McOFiction/MOC%20HOME.md), [MOC Books.md](McOFiction/MOC%20Books.md), [MOC.md](McOFiction/MOC.md), [Vault.md](McOFiction/Vault.md) |
| [MoCFiction](MoCFiction/) | Supporting fiction tooling and assets | [scripts/](MoCFiction/scripts/), [assets/](MoCFiction/assets/) |
| [narrative-pi](narrative-pi/) | Narrative knowledge system with multiple topical folders | [Home.md](narrative-pi/Home.md), [MOC Home .md](narrative-pi/MOC%20Home%20.md) |
| [postman](postman/) | Narrative/article vault with MOC-driven structure | [MOC_Home.md](postman/MOC_Home.md), [MOC_Narrativa.md](postman/MOC_Narrativa.md), [MOC_Articoli.md](postman/MOC_Articoli.md) |

## Common patterns

Several vaults use MOC-style entry notes to organize content around a home page or category map. The most explicit grammar is in [postman/MOC_Home.md](postman/MOC_Home.md) and defines modular level prefixes such as `00_NOT`, `01_SCN`, `02_CH`, and `09_FIN`.

The narrative vaults also use naming conventions that encode level, module, title, and date in the filename, which makes the notes easier to sort and link.

## Converter workflow

The [psychic/obsidian_docx_converter.py](psychic/obsidian_docx_converter.py) script now supports:

- converting a single Markdown note to DOCX
- converting an entire Obsidian vault recursively to DOCX
- normalizing Obsidian wikilinks and embeds before conversion

A test suite is available in [psychic/test_obsidian_docx_converter.py](psychic/test_obsidian_docx_converter.py).

## Generated output

The current DOCX export lives in [psychic-docx-export](psychic-docx-export/). If you want a fresh export, rerun the converter against the desired vault path.
