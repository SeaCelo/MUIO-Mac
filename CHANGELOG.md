# Changelog (MUIO-Mac)

This file tracks macOS‑specific changes made in this fork. Upstream changes are
not listed here unless they require a macOS adaptation.

## Unreleased

- (placeholder)

## 2026-02-04

- Rebased macOS port onto upstream MUIO v5.4.
- Documented demo data download/install steps and v5.4 baseline in README.
- Fixed CLEAN UP on macOS by skipping non‑directory entries in results folder.

## 2026-01-31

- Initial macOS Apple Silicon port based on upstream v5.3.
- Added macOS launcher (`platform/macos_arm_launcher.py`) with chdir and solver
  discovery logic, plus `MUIO_SOLVER_BIN_DIR` override.
- Added install/run/app scripts (`scripts/install-macos.sh`, `scripts/run-macos.sh`,
  `scripts/create-macos-app.sh`) with automatic browser launch.
- Added Homebrew solver install flow (GLPK + CBC).
- Added app “Quit” flow (frontend + `/shutdown` endpoint).
- URL‑encode case names in fetch paths to support spaces in macOS filesystems.
- Added `Brewfile` and `environment.yml` for reproducible setup.
- Added maintenance guide for upstream rebases.
