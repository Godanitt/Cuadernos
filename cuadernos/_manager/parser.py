from __future__ import annotations

from dataclasses import dataclass, field
from pathlib import Path
import re
import subprocess
import unicodedata

from .metadata import METADATA_START, METADATA_END

INCLUDE_RE = re.compile(r'#include\s+"([^"]+)"')
PART_RE = re.compile(r'#part\(\s*"([^"]+)"')
CHAPTER_RE = re.compile(r'#chapter\(\s*"([^"]+)"')
FIGURE_RE = re.compile(r'#figure\s*\(')
EXERCISE_RE = re.compile(r'#(?:exercise|problem)\s*\(')
CITATION_KEY_RE = re.compile(r'@[A-Za-z]+\s*\{\s*([^,\s]+)', re.IGNORECASE)
BIB_ENTRY_RE = re.compile(
    r'@[A-Za-z]+\s*\{\s*(?P<key>[^,\s]+)\s*,(?P<body>.*?)\n\}',
    re.IGNORECASE | re.DOTALL,
)
BIB_FIELD_RE = re.compile(
    r'(?P<name>[A-Za-z]+)\s*=\s*[\{\"](?P<value>.*?)[\}\"]\s*,?\s*(?:\n|$)',
    re.DOTALL,
)


@dataclass(slots=True)
class ParsedPart:
    title: str
    chapters: list[str] = field(default_factory=list)


@dataclass(slots=True)
class SourceStats:
    parts: list[ParsedPart]
    chapters: int
    words: int
    figures: int
    exercises: int
    includes: list[Path]


@dataclass(slots=True)
class BibRecord:
    key: str
    raw: str
    fields: dict[str, str]

    @property
    def label(self) -> str:
        author = self.fields.get("author", "").replace(" and ", ", ")
        title = self.fields.get("title", "").replace("{", "").replace("}", "")
        year = self.fields.get("year", "")
        value = " — ".join(x for x in (author, title) if x)
        if year:
            value += f" ({year})"
        return value or self.key


def slugify(value: str) -> str:
    normalized = unicodedata.normalize("NFKD", value)
    ascii_value = normalized.encode("ascii", "ignore").decode("ascii")
    slug = re.sub(r"[^a-zA-Z0-9]+", "-", ascii_value).strip("-").lower()
    return slug or "parte"


def strip_line_comments(text: str) -> str:
    out: list[str] = []
    for line in text.splitlines():
        in_string = False
        escaped = False
        cut = len(line)
        i = 0
        while i < len(line) - 1:
            char = line[i]
            if escaped:
                escaped = False
            elif char == "\\" and in_string:
                escaped = True
            elif char == '"':
                in_string = not in_string
            elif not in_string and line[i : i + 2] == "//":
                cut = i
                break
            i += 1
        out.append(line[:cut])
    return "\n".join(out)


def flatten_source(path: Path, seen: set[Path] | None = None) -> tuple[str, list[Path]]:
    if seen is None:
        seen = set()
    path = path.resolve()
    if path in seen or not path.exists():
        return "", []
    seen.add(path)
    text = path.read_text(encoding="utf-8", errors="replace")
    clean = strip_line_comments(text)
    chunks: list[str] = []
    includes: list[Path] = []
    cursor = 0
    for match in INCLUDE_RE.finditer(clean):
        chunks.append(clean[cursor : match.start()])
        include_path = (path.parent / match.group(1)).resolve()
        included_text, nested = flatten_source(include_path, seen)
        chunks.append(included_text)
        if include_path.exists():
            includes.append(include_path)
        includes.extend(nested)
        cursor = match.end()
    chunks.append(clean[cursor:])
    return "\n".join(chunks), includes


def parse_source(path: Path | None) -> SourceStats:
    if path is None or not path.exists():
        return SourceStats(parts=[], chapters=0, words=0, figures=0, exercises=0, includes=[])
    text, includes = flatten_source(path)
    # El bloque `notebook` contiene metadatos legibles por Python y Typst, pero
    # no forma parte del contenido editorial ni debe inflar el recuento de palabras.
    start = text.find(METADATA_START)
    end = text.find(METADATA_END)
    if start >= 0 and end >= start:
        text = text[:start] + text[end + len(METADATA_END):]
    events: list[tuple[int, str, str]] = []
    events += [(m.start(), "part", m.group(1).strip()) for m in PART_RE.finditer(text)]
    events += [(m.start(), "chapter", m.group(1).strip()) for m in CHAPTER_RE.finditer(text)]
    events.sort(key=lambda x: x[0])
    parts: list[ParsedPart] = []
    current: ParsedPart | None = None
    for _, kind, title in events:
        if kind == "part":
            current = ParsedPart(title=title)
            parts.append(current)
        else:
            if current is None:
                current = ParsedPart(title="Contenido")
                parts.append(current)
            current.chapters.append(title)
    without_code = re.sub(r'#[A-Za-z][\w-]*(?:\([^)]*\))?', ' ', text)
    words = len(re.findall(r"[A-Za-zÁÉÍÓÚÜÑáéíóúüñ]{3,}", without_code))
    return SourceStats(
        parts=parts,
        chapters=sum(len(p.chapters) for p in parts),
        words=words,
        figures=len(FIGURE_RE.findall(text)),
        exercises=len(EXERCISE_RE.findall(text)),
        includes=includes,
    )


def pdf_page_count(path: Path | None) -> int:
    if path is None or not path.exists():
        return 0
    try:
        proc = subprocess.run(
            ["pdfinfo", str(path)],
            check=True,
            capture_output=True,
            text=True,
            timeout=5,
        )
    except (OSError, subprocess.SubprocessError):
        return 0
    match = re.search(r"^Pages:\s+(\d+)", proc.stdout, re.MULTILINE)
    return int(match.group(1)) if match else 0


def bibtex_records(path: Path | None) -> list[BibRecord]:
    if path is None or not path.exists():
        return []
    text = path.read_text(encoding="utf-8", errors="replace")
    records: list[BibRecord] = []
    cursor = 0
    while True:
        match = re.search(r"@[A-Za-z]+\s*\{", text[cursor:], re.IGNORECASE)
        if not match:
            break
        start = cursor + match.start()
        brace = cursor + match.end() - 1
        depth = 0
        in_string = False
        escaped = False
        end = None
        for index in range(brace, len(text)):
            char = text[index]
            if in_string:
                if escaped:
                    escaped = False
                elif char == "\\":
                    escaped = True
                elif char == '"':
                    in_string = False
                continue
            if char == '"':
                in_string = True
            elif char == "{":
                depth += 1
            elif char == "}":
                depth -= 1
                if depth == 0:
                    end = index + 1
                    break
        if end is None:
            break
        raw = text[start:end].strip()
        header = re.search(r"@[A-Za-z]+\s*\{\s*([^,\s]+)\s*,", raw, re.IGNORECASE)
        if header:
            body = raw[header.end():]
            fields = {
                field.group("name").lower(): re.sub(r"\s+", " ", field.group("value")).strip()
                for field in BIB_FIELD_RE.finditer(body)
            }
            records.append(BibRecord(key=header.group(1), raw=raw, fields=fields))
        cursor = end
    return records


def bibliography_keys(path: Path | None) -> set[str]:
    return {record.key for record in bibtex_records(path)}


def bibliography_entries(path: Path | None) -> dict[str, str]:
    return {record.key: record.label for record in bibtex_records(path)}
