#!/usr/bin/env python3
"""Recoge PDFs generados accidentalmente dentro de ./cuadernos y los mueve a ./pdf.

Normalmente no hace falta si usas plantilla/scripts/run_all.py, porque ya compila
cada cuaderno directamente en ./pdf.
"""
from __future__ import annotations

import shutil
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[2]
NOTEBOOK_ROOT = PROJECT_ROOT / "cuadernos"
PDF_DIR = PROJECT_ROOT / "pdf"


def collect_pdfs() -> int:
    PDF_DIR.mkdir(exist_ok=True)
    moved = 0
    for pdf in NOTEBOOK_ROOT.rglob("*.pdf"):
        target = PDF_DIR / pdf.name
        if target.exists():
            target.unlink()
        print(f"Moviendo: {pdf.relative_to(PROJECT_ROOT)} -> {target.relative_to(PROJECT_ROOT)}")
        shutil.move(str(pdf), str(target))
        moved += 1
    return moved


if __name__ == "__main__":
    n = collect_pdfs()
    print(f"DONE: {n} PDF(s) movido(s).")
