import unittest

from obsidian_docx_converter import NameParts, NARRATIVE_PREFIXES, build_filename, split_chapters


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


if __name__ == "__main__":
    unittest.main()
