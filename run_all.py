#!/usr/bin/env python3
"""Entrada única de Cuadernos.

Uso habitual:
  python run_all.py                 # cuadernos + papers, incremental
  python run_all.py cuadernos       # solo pdf/
  python run_all.py cuadernos Fisica
  python run_all.py paper           # solo paper/
  python run_all.py paper P-MiPaper
"""
from __future__ import annotations

from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parent
SRC = ROOT / "src"
if str(SRC) not in sys.path:
    sys.path.insert(0, str(SRC))

from cuadernos_manager.cli import main

COMMANDS = {"update", "build", "list", "check", "sync", "stats", "watch"}
TARGET_ALIASES = {
    "cuaderno": "cuadernos",
    "cuadernos": "cuadernos",
    "pdf": "cuadernos",
    "paper": "paper",
    "papers": "paper",
}


def _argv() -> list[str]:
    args = sys.argv[1:]
    if args and args[0] in TARGET_ALIASES:
        return ["update", "--target", TARGET_ALIASES[args[0]], *args[1:]]
    if args and args[0] in COMMANDS:
        if len(args) > 1 and args[1] in TARGET_ALIASES:
            return [args[0], "--target", TARGET_ALIASES[args[1]], *args[2:]]
        return args
    return ["update", "--target", "all", *args]


if __name__ == "__main__":
    raise SystemExit(main(_argv()))
