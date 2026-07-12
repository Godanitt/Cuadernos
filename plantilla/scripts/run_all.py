#!/usr/bin/env python3
"""Compatibilidad: compila todos los cuadernos mediante la CLI central.

Uso desde cualquier directorio:
    python plantilla/scripts/run_all.py
"""
from __future__ import annotations

from pathlib import Path
import subprocess
import sys

PROJECT_ROOT = Path(__file__).resolve().parents[2]

if __name__ == "__main__":
    raise SystemExit(
        subprocess.call(
            [sys.executable, "-m", "cuadernos", "update"],
            cwd=PROJECT_ROOT,
        )
    )
