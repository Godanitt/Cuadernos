#!/usr/bin/env python3
"""Compila todos los cuadernos Typst y deja los PDFs en ./pdf.

Uso desde la raíz del proyecto:
    python plantilla/scripts/run_all.py

También funciona lanzándolo desde cualquier directorio.
"""
from __future__ import annotations

import os
import subprocess
from pathlib import Path
from multiprocessing import Pool, cpu_count

PROJECT_ROOT = Path(__file__).resolve().parents[2]
NOTEBOOK_ROOT = PROJECT_ROOT / "cuadernos"
PDF_DIR = PROJECT_ROOT / "pdf"

IGNORED_DIRS = {"Capitulos", "Ejercicios", "Imagenes", "__pycache__"}


def collect_main_typs() -> list[Path]:
    files: list[Path] = []
    if not NOTEBOOK_ROOT.is_dir():
        return files

    for category in sorted(p for p in NOTEBOOK_ROOT.iterdir() if p.is_dir()):
        for notebook in sorted(p for p in category.iterdir() if p.is_dir()):
            if notebook.name in IGNORED_DIRS:
                continue
            # Convención: el .typ principal vive directamente en la carpeta del cuaderno.
            files.extend(sorted(notebook.glob("*.typ")))
    return files


def compile_typ(typ_file: Path) -> tuple[str, bool, str]:
    rel_input = typ_file.relative_to(PROJECT_ROOT)
    out_pdf = PDF_DIR / f"{typ_file.stem}.pdf"
    rel_output = out_pdf.relative_to(PROJECT_ROOT)

    env = dict(os.environ)
    env["TYPST_PROJECT_ROOT"] = str(PROJECT_ROOT)

    cmd = [
        "typst",
        "compile",
        str(rel_input),
        str(rel_output),
        "--root",
        str(PROJECT_ROOT),
    ]
    proc = subprocess.run(
        cmd,
        cwd=PROJECT_ROOT,
        env=env,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
    )
    return str(rel_input), proc.returncode == 0, proc.stderr.strip()


if __name__ == "__main__":
    PDF_DIR.mkdir(exist_ok=True)
    typ_files = collect_main_typs()

    print(f"PROJECT_ROOT = {PROJECT_ROOT}")
    print(f"Cuadernos encontrados: {len(typ_files)}")

    if not typ_files:
        raise SystemExit(0)

    workers = max(1, min(cpu_count(), len(typ_files)))
    with Pool(workers) as pool:
        results = pool.map(compile_typ, typ_files)

    failed = False
    for rel, ok, err in results:
        if ok:
            print(f"[OK]    {rel}")
        else:
            failed = True
            print(f"[ERROR] {rel}")
            if err:
                print(err)

    if failed:
        raise SystemExit(1)

    print("DONE: PDFs actualizados en ./pdf")
