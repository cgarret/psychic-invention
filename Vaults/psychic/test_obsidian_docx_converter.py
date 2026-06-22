import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

from Vaults.psychic.obsidian_docx_converter import (
    NameParts,
    NARRATIVE_PREFIXES,
    build_filename,
    convert_obsidian_vault_to_docx,
    normalize_obsidian_markdown,
    split_chapters,
)


class ConverterTests(unittest.TestCase):
    def test_build_filename_matches_required_pattern(self):
        parts = NameParts(
            level=1,
            module="SCN",
            short_title="Return to Forest",
            date="09/04/2026",
            revision=3,
        )
        self.assertEqual(build_filename(parts), "01_SCN_ReturnToForest_2026-04-09_r3.md")

    def test_examples_are_supported(self):
        self.assertEqual(
            build_filename(NameParts(level=0, module="NOT", short_title="Scattered Note", date="2026-04-09")),
            "00_NOT_ScatteredNote_2026-04-09.md",
        )
        self.assertEqual(
            build_filename(NameParts(level=9, module="FIN", short_title="Chapter03", date="2026-04-09")),
            "09_FIN_Chapter03_2026-04-09.md",
        )

    def test_split_chapters(self):
        text = """Preface\nChapter 1: Forest Entrance\nLine A\nChapter 2 - River Crossing\nLine B"""
        self.assertEqual(
            split_chapters(text),
            [("Forest Entrance", "Line A"), ("River Crossing", "Line B")],
        )

    def test_narrative_prefixes_include_requested_keys(self):
        self.assertIn("01_SCN", NARRATIVE_PREFIXES)
        self.assertIn("10_MAC", NARRATIVE_PREFIXES)

    def test_normalize_obsidian_markdown_converts_wikilinks(self):
        text = "See [[Forest Entrance|the forest]] and ![[assets/map.png]] before [[Chapter 2#Summary]]."
        self.assertEqual(
            normalize_obsidian_markdown(text),
            "See the forest and ![map](assets/map.png) before Chapter 2.\n",
        )

    def test_convert_obsidian_vault_to_docx_preserves_structure(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            source_root = Path(temp_dir) / "vault"
            output_root = Path(temp_dir) / "export"
            nested_dir = source_root / "nested"
            nested_dir.mkdir(parents=True)
            (source_root / "alpha.md").write_text("# Alpha", encoding="utf-8")
            (nested_dir / "beta.md").write_text("# Beta", encoding="utf-8")

            def fake_convert(markdown_path, output_path=None):
                destination = Path(output_path) if output_path is not None else Path(markdown_path).with_suffix(".docx")
                destination.parent.mkdir(parents=True, exist_ok=True)
                destination.write_text("docx", encoding="utf-8")
                return destination

            with patch("Vaults.psychic.obsidian_docx_converter.convert_markdown_to_docx", side_effect=fake_convert):
                converted = convert_obsidian_vault_to_docx(source_root, output_root)

            self.assertEqual(
                [path.relative_to(output_root) for path in converted],
                [Path("alpha.docx"), Path("nested/beta.docx")],
            )


if __name__ == "__main__":
    unittest.main()
