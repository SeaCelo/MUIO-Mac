#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_NAME="${MUIO_ENV_NAME:-muio-dev}"
INSTALL_SOLVERS="prompt"
USE_BREW_BUNDLE=1

usage() {
  cat <<'USAGE'
Usage: scripts/install-macos.sh [options]

Options:
  --env-name NAME        Conda environment name (default: muio-dev)
  --install-solvers      Install solvers via Homebrew without prompting
  --skip-solvers         Skip solver checks/install
  --no-brew-bundle       Use brew install instead of Brewfile
  -h, --help             Show this help
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --env-name)
      ENV_NAME="${2:-}"
      shift 2
      ;;
    --install-solvers)
      INSTALL_SOLVERS="yes"
      shift
      ;;
    --skip-solvers)
      INSTALL_SOLVERS="no"
      shift
      ;;
    --no-brew-bundle)
      USE_BREW_BUNDLE=0
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage
      exit 1
      ;;
  esac
done

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is required. Install it from https://brew.sh" >&2
  exit 1
fi

if ! command -v conda >/dev/null 2>&1; then
  echo "Conda is required. Install Miniconda or Anaconda first." >&2
  exit 1
fi

if [[ "$INSTALL_SOLVERS" != "no" ]]; then
  missing=()
  command -v glpsol >/dev/null 2>&1 || missing+=("glpsol")
  command -v cbc >/dev/null 2>&1 || missing+=("cbc")
  if ((${#missing[@]})); then
    echo "Missing solver binaries: ${missing[*]}"
    if [[ "$INSTALL_SOLVERS" == "yes" ]]; then
      if [[ $USE_BREW_BUNDLE -eq 1 && -f "$ROOT_DIR/Brewfile" ]]; then
        brew bundle --file "$ROOT_DIR/Brewfile"
      else
        cbc_formula="cbc"
        if ! brew info "$cbc_formula" >/dev/null 2>&1; then
          if brew info "coin-or-cbc" >/dev/null 2>&1; then
            cbc_formula="coin-or-cbc"
          else
            echo "Homebrew formula for CBC not found. Try: brew search cbc" >&2
            exit 1
          fi
        fi
        brew install glpk "$cbc_formula"
      fi
    else
      read -r -p "Install solvers via Homebrew now? [y/N] " reply
      if [[ "$reply" =~ ^[Yy]$ ]]; then
        if [[ $USE_BREW_BUNDLE -eq 1 && -f "$ROOT_DIR/Brewfile" ]]; then
          brew bundle --file "$ROOT_DIR/Brewfile"
        else
          cbc_formula="cbc"
          if ! brew info "$cbc_formula" >/dev/null 2>&1; then
            if brew info "coin-or-cbc" >/dev/null 2>&1; then
              cbc_formula="coin-or-cbc"
            else
              echo "Homebrew formula for CBC not found. Try: brew search cbc" >&2
              exit 1
            fi
          fi
          brew install glpk "$cbc_formula"
        fi
      fi
    fi
  fi
fi

CONDA_BASE="$(conda info --base)"
# shellcheck disable=SC1090
source "$CONDA_BASE/etc/profile.d/conda.sh"

if conda env list | awk '{print $1}' | grep -qx "$ENV_NAME"; then
  conda activate "$ENV_NAME"
else
  conda create -y -n "$ENV_NAME" python=3.11 pip
  conda activate "$ENV_NAME"
fi

python -m pip install -r "$ROOT_DIR/requirements.txt"

cat <<EOF
Install complete.

Next:
  scripts/run-macos.sh
EOF
