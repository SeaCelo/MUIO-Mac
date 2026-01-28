#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_NAME="${MUIO_ENV_NAME:-muio-dev}"

if ! command -v conda >/dev/null 2>&1; then
  echo "Conda is required. Install Miniconda or Anaconda first." >&2
  exit 1
fi

CONDA_BASE="$(conda info --base)"
# shellcheck disable=SC1090
source "$CONDA_BASE/etc/profile.d/conda.sh"

if ! conda env list | awk '{print $1}' | grep -qx "$ENV_NAME"; then
  echo "Conda env '$ENV_NAME' not found. Run scripts/install-macos.sh first." >&2
  exit 1
fi

conda activate "$ENV_NAME"

if [[ -z "${MUIO_SOLVER_BIN_DIR:-}" && -d "/opt/homebrew/bin" ]]; then
  export MUIO_SOLVER_BIN_DIR="/opt/homebrew/bin"
fi

cd "$ROOT_DIR"
exec python "$ROOT_DIR/platform/macos_arm_launcher.py"
