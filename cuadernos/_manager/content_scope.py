from __future__ import annotations

import os
from pathlib import Path
import re

from .models import Notebook

_BEGIN = "// <cuadernos:auto-imports>"
_END = "// </cuadernos:auto-imports>"
_BLOCK_RE = re.compile(
    rf"(?ms)^\s*{re.escape(_BEGIN)}.*?{re.escape(_END)}\s*\n?"
)
_TEMPLATE_IMPORT_RE = re.compile(
    r'''(?mx)^\s*\#import\s+["'][^"']*plantilla/plantilla\.typ["']\s*:'''
)
_REFERENCES_IMPORT_RE = re.compile(
    r'''(?mx)^\s*\#import\s+["'][^"']*generated/part_references\.typ["']\s*:'''
)
_READING_LIST_RE = re.compile(r"(?m)^\s*#let\s+part-reading-list\b")


def _typst_relative_path(from_dir: Path, target: Path) -> str:
    """Devuelve una ruta relativa válida también en Typst 0.15+.

    Typst exige barras `/` en las rutas. `os.path.relpath` mantiene además la
    compatibilidad si en el futuro se añaden cuadernos con otra profundidad.
    """

    return os.path.relpath(target, start=from_dir).replace(os.sep, "/")


def managed_content_prelude(notebook: Notebook, body: str = "") -> str:
    """Genera el ámbito que necesita un `content.typ` independiente.

    Los archivos evaluados mediante `include` son módulos con su propio ámbito;
    por ello no heredan los símbolos importados por el archivo principal. Este
    bloque hace disponibles `part`, `chapter`, los entornos de la plantilla y
    la bibliografía específica de cada parte.
    """

    content_path = notebook.content_path
    if content_path is None:
        return ""

    lines = [_BEGIN]

    if not _TEMPLATE_IMPORT_RE.search(body):
        template = notebook.root / "plantilla" / "plantilla.typ"
        rel_template = _typst_relative_path(content_path.parent, template)
        lines.append(f'#import "{rel_template}": *')

    if not _REFERENCES_IMPORT_RE.search(body):
        references = notebook.path / "generated" / "part_references.typ"
        rel_references = _typst_relative_path(content_path.parent, references)
        lines.append(f'#import "{rel_references}": part-references')

    if not _READING_LIST_RE.search(body):
        lines.extend(
            [
                "",
                "#let part-reading-list(slug) = part-bibliography(",
                "  entries: part-references.at(slug, default: ()),",
                ")",
            ]
        )

    lines.append(_END)
    return "\n".join(lines)


def ensure_content_scope(notebook: Notebook) -> bool:
    """Inserta o actualiza el bloque administrado al inicio de `content.typ`.

    Es idempotente y no toca el resto del contenido escrito por el usuario.
    Devuelve `True` únicamente cuando el archivo ha cambiado.
    """

    content_path = notebook.content_path
    if content_path is None or not content_path.exists():
        return False

    original = content_path.read_text(encoding="utf-8")
    body = _BLOCK_RE.sub("", original).lstrip("\ufeff\n")
    prelude = managed_content_prelude(notebook, body)
    updated = f"{prelude}\n\n{body}" if prelude else body

    if updated == original:
        return False

    content_path.write_text(updated, encoding="utf-8")
    return True
