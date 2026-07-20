from __future__ import annotations

from pathlib import Path
import json
import re

from .metadata import METADATA_START, read_metadata
from .settings import load_project_settings


def _replace_metadata_field(source: str, field: str, old: str, new: str) -> str:
    if old == new:
        return source
    pattern = re.compile(
        rf'(?m)^(?P<indent>\s*){re.escape(field)}:\s*"{re.escape(old)}"\s*,?\s*$'
    )
    match = pattern.search(source)
    if not match:
        return source
    line = match.group(0)
    trailing_comma = "," if line.rstrip().endswith(",") else ""
    replacement = f'{match.group("indent")}{field}: "{new}"{trailing_comma}'
    return source[: match.start()] + replacement + source[match.end() :]


def _rename_if_present(source: Path, target: Path) -> bool:
    if source == target or not source.exists():
        return False
    target.parent.mkdir(parents=True, exist_ok=True)
    if target.exists():
        try:
            if source.is_file() and target.is_file() and source.read_bytes() == target.read_bytes():
                source.unlink()
                return True
        except OSError:
            pass
        return False
    source.rename(target)
    return True


def _rewrite_json(path: Path, id_map: dict[str, str], text_map: dict[str, str]) -> None:
    if not path.exists():
        return
    try:
        data = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError):
        return

    def rewrite(value):
        if isinstance(value, str):
            for old, new in sorted(text_map.items(), key=lambda item: len(item[0]), reverse=True):
                value = value.replace(old, new)
            return value
        if isinstance(value, list):
            return [rewrite(item) for item in value]
        if isinstance(value, dict):
            return {id_map.get(key, key): rewrite(item) for key, item in value.items()}
        return value

    path.write_text(json.dumps(rewrite(data), indent=2, ensure_ascii=False) + "\n", encoding="utf-8")


def _main_tail(main: Path) -> str:
    """Conserva el nombre humano ya elegido para el main y retira su prefijo."""
    stem = main.stem
    if "-" in stem:
        _, tail = stem.split("-", 1)
        if tail.strip():
            return tail.strip()
    return stem.strip() or main.parent.name


def normalize_notebook_names(root: Path) -> int:
    """Normaliza todos los cuadernos al esquema ``Area-Nombre`` sin números.

    El nombre del main es la única identidad canónica. Por ejemplo:
    ``MED-Oncologia.typ`` + ``MED-06`` se convierte en
    ``Med-Oncologia.typ`` + ``Med-Oncologia`` + ``Med-Oncologia.pdf``.

    La operación es idempotente y también actualiza PDFs existentes, previews,
    ``tinymist.lock`` y las cachés del gestor.
    """
    root = root.resolve()
    settings = load_project_settings(root)
    id_map: dict[str, str] = {}
    text_map: dict[str, str] = {}
    changed = 0

    base = root / "cuadernos"
    if not base.exists():
        return 0

    mains: list[Path] = []
    for candidate in sorted(base.rglob("*.typ")):
        if "_manager" in candidate.parts:
            continue
        try:
            head = candidate.read_text(encoding="utf-8", errors="replace")[:16000]
        except OSError:
            continue
        if METADATA_START in head:
            mains.append(candidate)

    for main in mains:
        try:
            metadata = read_metadata(main)
            source = main.read_text(encoding="utf-8", errors="replace")
        except (OSError, TypeError, ValueError):
            continue

        area = str(metadata.get("area") or main.parent.parent.name)
        prefix = settings.area(area).prefix
        tail = _main_tail(main)
        new_stem = f"{prefix}-{tail}"
        new_id = new_stem
        new_output = f"{new_stem}.pdf"

        old_id = str(metadata.get("id", ""))
        old_output = str(metadata.get("output", ""))
        old_main = main
        new_main = main.with_name(f"{new_stem}.typ")

        updated = _replace_metadata_field(source, "id", old_id, new_id)
        updated = _replace_metadata_field(updated, "output", old_output, new_output)
        if updated != source:
            main.write_text(updated, encoding="utf-8")
            changed += 1

        if old_main != new_main and _rename_if_present(old_main, new_main):
            changed += 1

        if old_id and old_id != new_id:
            id_map[old_id] = new_id
            text_map[old_id] = new_id
        if old_main != new_main:
            old_rel = old_main.relative_to(root).as_posix()
            new_rel = new_main.relative_to(root).as_posix()
            text_map[old_rel] = new_rel
            text_map[f"file:{old_rel}"] = f"file:{new_rel}"

        if old_output and old_output != new_output:
            old_pdf = root / "pdf" / old_output
            new_pdf = root / "pdf" / new_output
            if _rename_if_present(old_pdf, new_pdf):
                changed += 1
            text_map[old_output] = new_output
            text_map[f"pdf/{old_output.removesuffix('.pdf')}"] = f"pdf/{new_output.removesuffix('.pdf')}"

        if old_id != new_id:
            preview_dir = root / "docs" / "assets" / "previews"
            for suffix in (".png", ".svg"):
                for preview_id in {old_id, new_id}:
                    if not preview_id:
                        continue
                    preview = preview_dir / f"{preview_id}{suffix}"
                    if preview.exists():
                        preview.unlink(missing_ok=True)
                        changed += 1

    lock = root / "tinymist.lock"
    if lock.exists() and text_map:
        try:
            original = lock.read_text(encoding="utf-8")
            updated = original
            for old, new in sorted(text_map.items(), key=lambda item: len(item[0]), reverse=True):
                updated = updated.replace(old, new)
            if updated != original:
                lock.write_text(updated, encoding="utf-8")
                changed += 1
        except OSError:
            pass

    cache_dir = root / ".cuadernos-cache"
    _rewrite_json(cache_dir / "build.json", id_map, text_map)
    _rewrite_json(cache_dir / "tinymist.json", id_map, text_map)
    return changed


# Alias temporal para instalaciones que todavía importen el nombre anterior.
def normalize_legacy_prefixes(root: Path) -> int:
    return normalize_notebook_names(root)
