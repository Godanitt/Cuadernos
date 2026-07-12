from __future__ import annotations

from dataclasses import dataclass
from functools import lru_cache
from pathlib import Path
import os
import shutil
import subprocess
import tomllib


@dataclass(frozen=True, slots=True)
class TinymistCLI:
    """Capacidades detectadas del ejecutable de Tinymist."""

    executable: str
    lock_mode: str  # "lockfile" | "save-lock"
    supports_root: bool
    version: str


@dataclass(frozen=True, slots=True)
class LockInspection:
    mains: frozenset[str]
    valid: bool


def _executable_names() -> tuple[str, ...]:
    return ("tinymist.exe", "tinymist") if os.name == "nt" else ("tinymist",)


def _extension_candidates() -> list[Path]:
    """Busca el binario incluido por editores habituales sin recorrer todo HOME."""

    home = Path.home()
    roots = [
        home / ".vscode" / "extensions",
        home / ".vscode-server" / "extensions",
        home / ".cursor" / "extensions",
        home / ".windsurf" / "extensions",
    ]
    patterns = (
        "myriad-dreamin.tinymist-*/out/tinymist*",
        "myriad-dreamin.tinymist-*/bin/tinymist*",
        "myriad-dreamin.tinymist-*/dist/tinymist*",
        "myriad-dreamin.tinymist-*/tinymist*",
    )
    candidates: list[Path] = []
    for root in roots:
        if not root.exists():
            continue
        for pattern in patterns:
            candidates.extend(root.glob(pattern))
    return sorted(
        (path for path in candidates if path.is_file()),
        key=lambda path: path.stat().st_mtime,
        reverse=True,
    )


def _candidate_executables() -> list[str]:
    candidates: list[str] = []
    configured = os.environ.get("TINYMIST_BIN", "").strip()
    if configured:
        candidates.append(configured)
    located = shutil.which("tinymist")
    if located:
        candidates.append(located)
    candidates.extend(str(path) for path in _extension_candidates())

    unique: list[str] = []
    seen: set[str] = set()
    for candidate in candidates:
        key = str(Path(candidate).expanduser())
        if key not in seen:
            seen.add(key)
            unique.append(key)
    return unique


def _run_text(command: list[str], timeout: int = 10) -> tuple[int, str]:
    try:
        proc = subprocess.run(
            command,
            capture_output=True,
            text=True,
            timeout=timeout,
        )
    except (OSError, subprocess.TimeoutExpired):
        return 1, ""
    return proc.returncode, (proc.stdout or "") + "\n" + (proc.stderr or "")


@lru_cache(maxsize=1)
def detect_tinymist() -> TinymistCLI | None:
    """Detecta tanto versiones nuevas (`--lockfile`) como antiguas (`--save-lock`)."""

    for executable in _candidate_executables():
        code, help_text = _run_text([executable, "compile", "--help"])
        if code != 0 and not help_text.strip():
            continue
        if "--lockfile" in help_text:
            lock_mode = "lockfile"
        elif "--save-lock" in help_text:
            lock_mode = "save-lock"
        else:
            continue
        _, version_text = _run_text([executable, "--version"])
        version = version_text.strip().splitlines()[0] if version_text.strip() else "desconocida"
        return TinymistCLI(
            executable=executable,
            lock_mode=lock_mode,
            supports_root="--root" in help_text,
            version=version,
        )
    return None


def _relative(path: Path, root: Path) -> str:
    try:
        return path.resolve().relative_to(root.resolve()).as_posix()
    except ValueError:
        return path.resolve().as_posix()


def compile_command(
    cli: TinymistCLI,
    *,
    root: Path,
    main: Path,
    output: Path,
) -> list[str]:
    command = [cli.executable, "compile"]
    if cli.lock_mode == "lockfile":
        command.extend(["--lockfile", str((root / "tinymist.lock").resolve())])
    else:
        command.append("--save-lock")
    if cli.supports_root:
        command.extend(["--root", str(root.resolve())])
    command.extend([_relative(main, root), _relative(output, root)])
    return command


def _normalise_lock_path(value: object, root: Path) -> str | None:
    if not isinstance(value, str) or not value:
        return None
    text = value
    if text.startswith("file:"):
        text = text[5:]
    path = Path(text)
    if path.is_absolute():
        try:
            return path.resolve().relative_to(root.resolve()).as_posix()
        except ValueError:
            return path.resolve().as_posix()
    return path.as_posix().lstrip("./")


def inspect_lock(root: Path) -> LockInspection:
    path = root / "tinymist.lock"
    if not path.exists():
        return LockInspection(frozenset(), False)
    try:
        data = tomllib.loads(path.read_text(encoding="utf-8"))
    except (OSError, UnicodeDecodeError, tomllib.TOMLDecodeError):
        return LockInspection(frozenset(), False)

    mains: set[str] = set()
    documents = data.get("document", [])
    if not isinstance(documents, list):
        return LockInspection(frozenset(), False)
    for document in documents:
        if not isinstance(document, dict):
            continue
        main = _normalise_lock_path(document.get("main") or document.get("id"), root)
        if main:
            mains.add(main)
    return LockInspection(frozenset(mains), True)


def notebook_main_key(root: Path, main: Path) -> str:
    return _relative(main, root)
