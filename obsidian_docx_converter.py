from __future__ import annotations

from dataclasses import dataclass
from datetime import datetime
from pathlib import Path
import re
import xml.etree.ElementTree as ET
from zipfile import ZipFile


NARRATIVE_PREFIXES = {
    "00_NOT": "Notes, ideas, fragments",
    "01_SCN": "Scenes",
    "02_CH": "Chapters",
    "03_ARC": "Story arcs",
    "04_WB": "Worldbuilding",
    "05_GEN": "Genealogies",
    "06_MAP": "Maps (diagrams, timelines)",
    "07_RES": "Research, sources",
    "08_DIA": "Modular diagrams",
    "09_FIN": "Final versions",
    "10_MAC": "Macro",
}


@dataclass(frozen=True)
class NameParts:
    level: int
    module: str
    short_title: str
    date: str
    revision: int | None = None


def normalize_short_title(title: str) -> str:
    parts = re.findall(r"[A-Za-z0-9]+", title)
    return "".join(part.capitalize() for part in parts) or "Untitled"


def normalize_date(value: str) -> str:
    value = value.strip()
    for fmt in ("%Y-%m-%d", "%d/%m/%Y", "%d-%m-%Y"):
        try:
            return datetime.strptime(value, fmt).strftime("%Y-%m-%d")
        except ValueError:
            continue
    raise ValueError(f"Unsupported date format: {value}")


def build_filename(parts: NameParts, extension: str = "md") -> str:
    module = re.sub(r"[^A-Z0-9]", "", parts.module.upper())
    short_title = normalize_short_title(parts.short_title)
    date = normalize_date(parts.date)
    filename = f"{parts.level:02d}_{module}_{short_title}_{date}"
    if parts.revision is not None:
        filename += f"_r{parts.revision}"
    return f"{filename}.{extension.lstrip('.')}"


def _extract_docx_text(docx_file: Path) -> str:
    with ZipFile(docx_file) as archive:
        raw = archive.read("word/document.xml")
    root = ET.fromstring(raw)
    ns = {"w": "http://schemas.openxmlformats.org/wordprocessingml/2006/main"}
    paragraphs = []
    for paragraph in root.findall(".//w:p", ns):
        fragments = [node.text for node in paragraph.findall(".//w:t", ns) if node.text]
        text = "".join(fragments).strip()
        if text:
            paragraphs.append(text)
    return "\n".join(paragraphs)


def split_chapters(document_text: str) -> list[tuple[str, str]]:
    chapters: list[tuple[str, str]] = []
    current_title: str | None = None
    current_lines: list[str] = []

    for line in document_text.splitlines():
        match = re.match(r"^\s*chapter\s+(\d+)(?:\s*[:-]\s*(.*))?\s*$", line, re.IGNORECASE)
        if match:
            if current_title and current_lines:
                chapters.append((current_title, "\n".join(current_lines).strip()))
            chapter_number = int(match.group(1))
            chapter_label = (match.group(2) or f"Chapter{chapter_number:02d}").strip()
            current_title = chapter_label
            current_lines = []
            continue

        if current_title:
            current_lines.append(line)

    if current_title and current_lines:
        chapters.append((current_title, "\n".join(current_lines).strip()))

    return chapters


def convert_docx_to_markdown_chapters(
    docx_path: str | Path,
    output_dir: str | Path,
    module: str = "CH",
    start_level: int = 2,
    revision: int | None = None,
) -> list[Path]:
    docx_file = Path(docx_path)
    out_dir = Path(output_dir)
    out_dir.mkdir(parents=True, exist_ok=True)

    text = _extract_docx_text(docx_file)
    chapters = split_chapters(text)
    now_date = datetime.now().strftime("%Y-%m-%d")
    written_files: list[Path] = []

    for index, (title, body) in enumerate(chapters, start=1):
        level = start_level
        parts = NameParts(level=level, module=module, short_title=title, date=now_date, revision=revision)
        file_name = build_filename(parts)
        file_path = out_dir / file_name
        content = f"# {title}\n\n{body}\n"
        file_path.write_text(content, encoding="utf-8")
        written_files.append(file_path)

    return written_files
