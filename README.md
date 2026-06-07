# psychic-invention

Utilities for converting `.docx` content into chapter Markdown files for Obsidian while enforcing the requested naming strategy.

## Narrative category prefixes

- `00_NOT` = Notes, ideas, fragments
- `01_SCN` = Scenes
- `02_CH` = Chapters
- `03_ARC` = Story arcs
- `04_WB` = Worldbuilding
- `05_GEN` = Genealogies
- `06_MAP` = Maps (diagrams, timelines)
- `07_RES` = Research, sources
- `08_DIA` = Modular diagrams
- `09_FIN` = Final versions
- `10_MAC` = Macro

## Naming convention

`[Level]_[Module]_[ShortTitle]_[Date]_[Rev]`

Examples:

- `00_NOT_ScatteredNote_2026-04-09.md`
- `01_SCN_ForestEntrance_2026-04-09_r2.md`
- `05_GEN_MarrasFamily_2026-04-09_r1.json`
- `09_FIN_Chapter03_2026-04-09.md`

`build_filename` normalizes this format and accepts date inputs such as `09/04/2026` or `2026-04-09`.
