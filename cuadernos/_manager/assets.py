from __future__ import annotations

from pathlib import Path
import html
import shutil
import struct
import subprocess
import tempfile

from .models import Notebook


def _png_size(path: Path) -> tuple[int, int]:
    try:
        with path.open("rb") as fh:
            header = fh.read(24)
        if header[:8] == b"\x89PNG\r\n\x1a\n" and len(header) >= 24:
            return struct.unpack(">II", header[16:24])
    except OSError:
        pass
    return (0, 0)


def _typst_project_path(notebook: Notebook, path: Path) -> str:
    """Convierte una ruta local en una ruta absoluta de proyecto para Typst.

    Las rutas relativas que llegan a ``cover4.typ`` se resolverían desde la
    carpeta de la plantilla, no desde el cuaderno. Una ruta que empieza por ``/``
    se resuelve desde ``--root`` y sigue siendo válida aunque la imagen se use
    desde otro módulo Typst.
    """

    root = notebook.root.resolve()
    resolved = path.resolve()
    try:
        relative = resolved.relative_to(root)
    except ValueError as exc:
        raise ValueError(f"El recurso queda fuera de la raíz del proyecto: {path}") from exc
    return "/" + relative.as_posix()


def _configured_cover_path(notebook: Notebook, configured: str) -> Path:
    configured = configured.strip()
    if configured.startswith("/"):
        return notebook.root / configured.lstrip("/")
    return notebook.path / configured


def _legacy_pdf_candidates(notebook: Notebook) -> list[Path]:
    candidates: list[Path] = []

    # PDF canónico del cuaderno.
    if notebook.output_path and notebook.output_path.exists():
        candidates.append(notebook.output_path)

    # PDF antiguos que todavía estén junto a las fuentes.
    if notebook.path.exists():
        candidates.extend(sorted(notebook.path.glob("*.pdf")))

    # Copias creadas por migraciones antiguas. Solo se leen como último recurso;
    # no se renombran ni se mueven desde el flujo normal de actualización.
    pdf_dir = notebook.root / "pdf"
    if pdf_dir.exists() and notebook.output_file:
        stem = Path(notebook.output_file).stem
        candidates.extend(sorted(pdf_dir.glob(f"{stem}-legacy*.pdf")))

    seen: set[Path] = set()
    unique: list[Path] = []
    for path in candidates:
        try:
            resolved = path.resolve()
        except OSError:
            continue
        if resolved not in seen and path.is_file():
            seen.add(resolved)
            unique.append(path)
    return unique


def _extract_largest_first_page_image(pdf: Path, target: Path) -> bool:
    pdfimages = shutil.which("pdfimages")
    if pdfimages is None:
        return False

    target.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.TemporaryDirectory(prefix="cuadernos-cover-") as temp_dir:
        prefix = Path(temp_dir) / "image"
        proc = subprocess.run(
            [pdfimages, "-f", "1", "-l", "1", "-png", str(pdf), str(prefix)],
            capture_output=True,
            text=True,
        )
        if proc.returncode != 0:
            return False

        images = [
            path
            for path in Path(temp_dir).glob("image-*.png")
            if _png_size(path) != (0, 0)
        ]
        if not images:
            return False

        best = max(images, key=lambda path: _png_size(path)[0] * _png_size(path)[1])
        temporary_target = target.with_suffix(target.suffix + ".tmp")
        shutil.copy2(best, temporary_target)
        temporary_target.replace(target)
        return target.exists() and target.stat().st_size > 0


def _write_placeholder(notebook: Notebook, target: Path) -> None:
    target.parent.mkdir(parents=True, exist_ok=True)
    title = html.escape(notebook.title)
    area = html.escape(notebook.area_label)
    code = html.escape(notebook.id)
    target.write_text(
        f'''<svg xmlns="http://www.w3.org/2000/svg" width="1240" height="1754" viewBox="0 0 1240 1754">
<defs>
  <linearGradient id="background" x1="0" y1="0" x2="1" y2="1">
    <stop stop-color="#10172f"/>
    <stop offset="1" stop-color="#40558d"/>
  </linearGradient>
</defs>
<rect width="1240" height="1754" fill="url(#background)"/>
<g fill="none" stroke="#ffffff" stroke-opacity=".12">
  <circle cx="980" cy="430" r="280"/>
  <circle cx="980" cy="430" r="190"/>
  <path d="M80 1280 C360 980 660 1480 1160 1110"/>
</g>
<text x="96" y="150" fill="#dce5ff" font-family="serif" font-size="48">{area}</text>
<text x="1140" y="150" fill="#dce5ff" font-family="sans-serif" font-size="42" text-anchor="end">{code}</text>
<foreignObject x="96" y="500" width="1048" height="520">
  <div xmlns="http://www.w3.org/1999/xhtml" style="font:700 98px/1.08 Georgia,serif;color:white">{title}</div>
</foreignObject>
</svg>''',
        encoding="utf-8",
    )


def ensure_cover_asset(notebook: Notebook, *, recover_from_pdf: bool = False) -> str | None:
    """Garantiza una portada válida y devuelve una ruta absoluta de proyecto.

    Prioridad:
    1. Imagen declarada y existente en ``cuaderno.toml``.
    2. Imagen recuperada previamente en ``generated/cover-extracted.png``.
    3. Si se solicita, recuperación desde la primera página de un PDF antiguo.
    4. SVG provisional generado localmente.

    Nunca devuelve una ruta a un archivo inexistente.
    """

    configured = str(notebook.cover.get("image", "")).strip()
    if configured:
        configured_path = _configured_cover_path(notebook, configured)
        if configured_path.is_file():
            return _typst_project_path(notebook, configured_path)

    generated_dir = notebook.path / "generated"
    generated_dir.mkdir(parents=True, exist_ok=True)

    extracted = generated_dir / "cover-extracted.png"
    if extracted.is_file() and extracted.stat().st_size > 0:
        return _typst_project_path(notebook, extracted)

    if recover_from_pdf:
        for pdf in _legacy_pdf_candidates(notebook):
            if _extract_largest_first_page_image(pdf, extracted):
                return _typst_project_path(notebook, extracted)

    placeholder = generated_dir / "cover-placeholder.svg"
    if not placeholder.is_file() or placeholder.stat().st_size == 0:
        _write_placeholder(notebook, placeholder)
    return _typst_project_path(notebook, placeholder)
