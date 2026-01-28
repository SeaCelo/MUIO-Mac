import os
import sys
import shutil
from pathlib import Path
import runpy


def _prepend_path(bin_dir: str) -> None:
    current_path = os.environ.get("PATH", "")
    os.environ["PATH"] = f"{bin_dir}{os.pathsep}{current_path}"


def _require_solver(binary_name: str) -> None:
    if shutil.which(binary_name) is None:
        print(
            f"Missing solver binary '{binary_name}'. "
            "Install via Homebrew or set MUIO_SOLVER_BIN_DIR.",
            file=sys.stderr,
        )
        sys.exit(1)


def main() -> None:
    repo_root = Path(__file__).resolve().parents[1]
    os.chdir(repo_root)
    sys.path.insert(0, str(repo_root))
    sys.path.insert(0, str(repo_root / "API"))

    bin_dir = os.environ.get("MUIO_SOLVER_BIN_DIR", "/opt/homebrew/bin")
    os.environ["MUIO_SOLVER_BIN_DIR"] = bin_dir
    _prepend_path(bin_dir)

    _require_solver("glpsol")
    _require_solver("cbc")

    # Override solver working directories for macOS/Homebrew without touching core code.
    from pathlib import Path as _Path
    from Classes.Case.OsemosysClass import Osemosys as _Osemosys

    _orig_init = _Osemosys.__init__

    def _patched_init(self, case):  # type: ignore[no-redef]
        _orig_init(self, case)
        solver_dir = os.environ.get("MUIO_SOLVER_BIN_DIR")
        if solver_dir:
            self.glpkFolder = _Path(solver_dir)
            self.cbcFolder = _Path(solver_dir)

    _Osemosys.__init__ = _patched_init

    runpy.run_module("API.app", run_name="__main__")


if __name__ == "__main__":
    main()
