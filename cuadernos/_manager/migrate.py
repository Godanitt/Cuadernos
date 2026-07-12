from __future__ import annotations

from pathlib import Path
import filecmp
import re
import shutil
import unicodedata

from .parser import slugify

_UNICODE_ESCAPE = re.compile(r"#U([0-9A-Fa-f]{4})")


def _decode_legacy_name(name: str) -> str:
    def repl(match: re.Match[str]) -> str:
        try:
            return chr(int(match.group(1), 16))
        except ValueError:
            return ""

    return _UNICODE_ESCAPE.sub(repl, name)


def _portable_name(name: str) -> str:
    decoded = _decode_legacy_name(name)
    # Los nombres Python como __init__.py, _manager y __pycache__ ya son
    # portables y deben conservar exactamente sus guiones bajos.
    if decoded == name and re.fullmatch(r"[A-Za-z0-9._-]+", name):
        return name
    stem = unicodedata.normalize("NFKD", decoded).encode("ascii", "ignore").decode("ascii")
    stem = re.sub(r"[^A-Za-z0-9._-]+", "_", stem)
    stem = re.sub(r"_{3,}", "__", stem)
    return stem.strip(" ") or "unnamed"


def _archive_conflict(source: Path, target_dir: Path) -> None:
    target_dir.mkdir(parents=True, exist_ok=True)
    safe_stem = _portable_name(source.stem)
    candidate = target_dir / f"{safe_stem}.original{source.suffix}"
    index = 2
    while candidate.exists():
        if source.is_file() and candidate.is_file() and filecmp.cmp(source, candidate, shallow=False):
            source.unlink()
            return
        candidate = target_dir / f"{safe_stem}.original-{index}{source.suffix}"
        index += 1
    shutil.move(str(source), str(candidate))


def _merge_directory(source: Path, target: Path) -> None:
    target.mkdir(parents=True, exist_ok=True)
    archive = target / "legacy"
    for child in list(source.iterdir()):
        destination = target / child.name
        if not destination.exists():
            shutil.move(str(child), str(destination))
        elif child.is_dir() and destination.is_dir():
            _merge_directory(child, destination)
            child.rmdir()
        elif child.is_file() and destination.is_file() and filecmp.cmp(child, destination, shallow=False):
            child.unlink()
        else:
            _archive_conflict(child, archive)
    source.rmdir()


def _normalize_tree(root: Path) -> list[str]:
    messages: list[str] = []
    if not root.exists():
        return messages
    # Profundidad descendente: primero archivos y subcarpetas, luego sus padres.
    paths = sorted(root.rglob("*"), key=lambda path: len(path.parts), reverse=True)
    for path in paths:
        if not path.exists():
            continue
        new_name = _portable_name(path.name)
        if new_name == path.name:
            continue
        target = path.with_name(new_name)
        if path.is_dir() and target.exists() and target.is_dir():
            _merge_directory(path, target)
            messages.append(f"fusionado {path.name} -> {target.name}")
        elif target.exists():
            if path.is_file() and target.is_file() and filecmp.cmp(path, target, shallow=False):
                path.unlink()
                messages.append(f"eliminado duplicado {path.name}")
            else:
                _archive_conflict(path, target.parent / "legacy")
                messages.append(f"archivado conflicto {path.name}")
        else:
            path.rename(target)
            messages.append(f"renombrado {path.name} -> {target.name}")
    return messages


def _collect_source_pdfs(root: Path) -> list[str]:
    messages: list[str] = []
    notebook_root = root / "cuadernos"
    pdf_dir = root / "pdf"
    pdf_dir.mkdir(exist_ok=True)
    for pdf in list(notebook_root.rglob("*.pdf")) if notebook_root.exists() else []:
        target = pdf_dir / _portable_name(pdf.name)
        if target.exists():
            if filecmp.cmp(pdf, target, shallow=False):
                pdf.unlink()
                messages.append(f"eliminado PDF duplicado {pdf.relative_to(root)}")
                continue
            target = pdf_dir / f"{target.stem}-legacy{target.suffix}"
        shutil.move(str(pdf), str(target))
        messages.append(f"movido {pdf.relative_to(root)} -> {target.relative_to(root)}")
    return messages


def migrate_legacy_layout(root: Path) -> list[str]:
    """Normaliza de forma segura restos del repositorio anterior.

    Es idempotente: las ejecuciones posteriores no realizan cambios.
    """
    messages = _normalize_tree(root / "cuadernos")
    messages.extend(_normalize_tree(root / "pdf"))
    messages.extend(_collect_source_pdfs(root))
    return messages


_PART_CONTENT_IMPORT = '#import "generated/part_references.typ": part-reading-list'
_GLOBAL_BIBLIOGRAPHY = '''#if bibliography-enabled {
  my-bibliography(
    bibliography(bibliography-file, title: "Bibliografía", full: true)
  )
}'''

_PART_IMPORT_RE = re.compile(
    r'^\s*#import\s+"generated/part_references\.typ":\s*[^\n]+$\n?',
    re.MULTILINE,
)
_PART_HELPER_RE = re.compile(
    r'^\s*#let\s+part-reading-list\(slug(?:,[^)]*)?\)\s*=\s*part-bibliography\(\s*\n'
    r'\s*entries:\s*part-references\.at\(slug,\s*default:\s*\(\)\),\s*\n'
    r'\s*\)\s*$\n?',
    re.MULTILINE,
)
_PART_CALL_RE = re.compile(
    r'^\s*#part-reading-list\([^\n]*\)\s*$\n?',
    re.MULTILINE,
)
_PART_LINE_RE = re.compile(
    r'(?m)^\s*#part\(\s*"(?P<title>(?:\\.|[^"\\])*)"[^\n]*\)\s*$'
)


def _compact_blank_lines(text: str) -> str:
    return re.sub(r'\n{3,}', '\n\n', text).strip() + '\n'


def _ensure_main_bibliography_support(text: str) -> str:
    """Deja el `main.typ` solo con la bibliografía global.

    Las lecturas por parte se importan dentro de `content.typ`, que es el
    ámbito donde se invoca `part-reading-list`. Esto evita errores de alcance
    de Typst y funciona igual para cuadernos existentes y nuevos.
    """
    text = _PART_IMPORT_RE.sub('', text)
    text = _PART_HELPER_RE.sub('', text)
    if 'bibliography(bibliography-file' not in text:
        text = text.rstrip() + '\n\n' + _GLOBAL_BIBLIOGRAPHY + '\n'
    return _compact_blank_lines(text)


def _unescape_typst_string(value: str) -> str:
    return (
        value.replace(r'\\"', '"')
        .replace(r'\\n', ' ')
        .replace(r'\\\\', '\\')
    )


def _ensure_part_reading_calls(text: str, notebook) -> str:
    """Importa el helper en `content.typ` y deja una llamada por parte."""
    # Normaliza cualquier variante anterior y define el helper en el mismo
    # módulo en el que se usa. El archivo generado exporta la función completa.
    text = _PART_IMPORT_RE.sub('', text)
    text = _PART_HELPER_RE.sub('', text)
    text = text.lstrip()
    text = _PART_CONTENT_IMPORT + "\n\n" + text

    matches = list(_PART_LINE_RE.finditer(text))
    if not matches:
        return _compact_blank_lines(_PART_CALL_RE.sub('', text))

    slug_by_title = {part.title.strip(): part.slug for part in notebook.parts}
    pieces: list[str] = [text[: matches[0].start()]]
    for index, match in enumerate(matches):
        end = matches[index + 1].start() if index + 1 < len(matches) else len(text)
        block = text[match.start():end]
        block = _PART_CALL_RE.sub('', block).rstrip()
        title = _unescape_typst_string(match.group('title')).strip()
        part_slug = slug_by_title.get(title, slugify(title))
        pieces.append(f'{block}\n\n#part-reading-list("{part_slug}")\n\n')
    return _compact_blank_lines(''.join(pieces))


def migrate_part_bibliography(notebooks) -> list[str]:
    """Restaura y mantiene bibliografía general + lecturas por parte.

    - `references` en cada `[[parts]]` selecciona las lecturas de esa parte.
    - `generated/part_references.typ` exporta `part-reading-list` y se regenera en cada `update`.
    - Cada `content.typ` importa esa función y mantiene una llamada al final de cada parte.
    - La bibliografía BibTeX completa se imprime una sola vez al final del PDF.

    Es idempotente y también repara la migración clásica anterior, que podía
    dejar imports en `content.typ` apuntando a un archivo generado eliminado.
    """
    messages: list[str] = []
    for notebook in notebooks:
        main = notebook.main_path
        if main is not None and main.exists():
            original = main.read_text(encoding='utf-8')
            updated = _ensure_main_bibliography_support(original)
            if updated != original:
                main.write_text(updated, encoding='utf-8')
                messages.append(f'bibliografía dual en {main.relative_to(notebook.root)}')

        content = notebook.content_path
        if content is not None and content.exists():
            original = content.read_text(encoding='utf-8')
            updated = _ensure_part_reading_calls(original, notebook)
            if updated != original:
                content.write_text(updated, encoding='utf-8')
                messages.append(f'lecturas por parte en {content.relative_to(notebook.root)}')
    return messages


# Alias temporal para instalaciones que aún importen el nombre del parche
# anterior. Su comportamiento ya es el nuevo: bibliografía dual.
def migrate_classic_bibliography(notebooks) -> list[str]:
    return migrate_part_bibliography(notebooks)
