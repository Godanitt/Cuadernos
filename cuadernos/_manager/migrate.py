from __future__ import annotations

from pathlib import Path
import filecmp
import re
import shutil
import unicodedata

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
