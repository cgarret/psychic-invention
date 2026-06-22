from __future__ import annotations

from dataclasses import dataclass
from datetime import datetime
import argparse
from pathlib import Path
import re
import subprocess
import tempfile
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


OBSIDIAN_IMAGE_EXTENSIONS = {".png", ".jpg", ".jpeg", ".gif", ".webp", ".bmp", ".svg"}


def _normalize_obsidian_embeds(text: str) -> str:
    def replace_embed(match: re.Match[str]) -> str:
        target = match.group(1).strip()
        alias = None
        if "|" in target:
            target, alias = target.split("|", 1)
            target = target.strip()
            alias = alias.strip() or None

        target = target.split("#", 1)[0].strip()
        link_path = Path(target)
        if link_path.suffix.lower() not in OBSIDIAN_IMAGE_EXTENSIONS:
            return alias or link_path.stem or target

        alt_text = alias or link_path.stem or "image"
        return f"![{alt_text}]({target})"

    return re.sub(r"!\[\[([^\]]+)\]\]", replace_embed, text)


def _normalize_obsidian_wikilinks(text: str) -> str:
    def replace_link(match: re.Match[str]) -> str:
        target = match.group(1).strip()
        alias = None
        if "|" in target:
            target, alias = target.split("|", 1)
            target = target.strip()
            alias = alias.strip() or None

        target = target.split("#", 1)[0].strip()
        return alias or Path(target).stem or target

    return re.sub(r"(?<![!])\[\[([^\]]+)\]\]", replace_link, text)


def normalize_obsidian_markdown(text: str) -> str:
    normalized = _normalize_obsidian_embeds(text)
    normalized = _normalize_obsidian_wikilinks(normalized)
    return normalized.strip() + "\n"


def convert_markdown_to_docx(
    markdown_path: str | Path,
    output_path: str | Path | None = None,
) -> Path:
    source_path = Path(markdown_path)
    if not source_path.is_file():
        raise FileNotFoundError(f"Markdown file not found: {source_path}")

    destination_path = Path(output_path) if output_path is not None else source_path.with_suffix(".docx")
    destination_path.parent.mkdir(parents=True, exist_ok=True)

    markdown_text = source_path.read_text(encoding="utf-8")
    prepared_text = normalize_obsidian_markdown(markdown_text)

    with tempfile.NamedTemporaryFile("w", suffix=".md", delete=False, encoding="utf-8") as temp_file:
        temp_path = Path(temp_file.name)
        temp_file.write(prepared_text)

    try:
        subprocess.run(
            ["pandoc", str(temp_path), "-o", str(destination_path), "--from", "markdown", "--to", "docx"],
            check=True,
            capture_output=True,
            text=True,
            encoding="utf-8",
        )
    except FileNotFoundError as exc:
        raise RuntimeError("Pandoc is required to convert Markdown to DOCX.") from exc
    except subprocess.CalledProcessError as exc:
        raise RuntimeError(f"Pandoc conversion failed for {source_path}: {exc.stderr}") from exc
    finally:
        temp_path.unlink(missing_ok=True)

    return destination_path


def convert_obsidian_vault_to_docx(
    source_dir: str | Path,
    output_dir: str | Path,
) -> list[Path]:
    source_root = Path(source_dir)
    destination_root = Path(output_dir)

    if not source_root.is_dir():
        raise NotADirectoryError(f"Source directory not found: {source_root}")

    destination_root.mkdir(parents=True, exist_ok=True)
    converted_files: list[Path] = []

    for markdown_file in sorted(source_root.rglob("*.md")):
        relative_path = markdown_file.relative_to(source_root)
        output_path = destination_root / relative_path.with_suffix(".docx")
        converted_files.append(convert_markdown_to_docx(markdown_file, output_path))

    return converted_files


def _main() -> int:
    parser = argparse.ArgumentParser(description="Convert Obsidian Markdown files to DOCX using Pandoc.")
    parser.add_argument("source", help="Markdown file or vault directory to convert")
    parser.add_argument(
        "output",
        nargs="?",
        help="Destination DOCX file for a single note or destination directory for a vault",
    )
    args = parser.parse_args()

    source_path = Path(args.source)
    if source_path.is_dir():
        if args.output is None:
            raise SystemExit("Output directory is required when the source is a directory.")
        convert_obsidian_vault_to_docx(source_path, args.output)
        return 0

    output_path = args.output if args.output is not None else source_path.with_suffix(".docx")
    convert_markdown_to_docx(source_path, output_path)
    return 0


if __name__ == "__main__":
    raise SystemExit(_main())


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
