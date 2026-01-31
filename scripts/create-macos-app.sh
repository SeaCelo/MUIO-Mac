#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT_DIR="$ROOT_DIR/dist"
APP_NAME="${MUIO_APP_NAME:-MUIO-Mac}"
APP_PATH="$OUT_DIR/${APP_NAME}.app"
ENV_NAME="${MUIO_ENV_NAME:-muio-dev}"

if ! command -v osacompile >/dev/null 2>&1; then
  echo "osacompile not found. Install Xcode Command Line Tools:" >&2
  echo "  xcode-select --install" >&2
  exit 1
fi

mkdir -p "$OUT_DIR"

escape_applescript_string() {
  printf '%s' "$1" | sed 's/\\/\\\\/g; s/\"/\\"/g'
}

REPO_ESCAPED="$(escape_applescript_string "$ROOT_DIR")"
RUN_PATH_ESCAPED="$(escape_applescript_string "$ROOT_DIR/scripts/run-macos.sh")"
ENV_NAME_ESCAPED="$(escape_applescript_string "$ENV_NAME")"
TMP_SCRIPT="$(mktemp -t muio-launcher.XXXXXX.applescript)"
trap 'rm -f "$TMP_SCRIPT"' EXIT

cat > "$TMP_SCRIPT" <<EOF
set repoPath to "${REPO_ESCAPED}"
set runScriptPath to "${RUN_PATH_ESCAPED}"
set envName to "${ENV_NAME_ESCAPED}"
set appPath to POSIX path of (path to me)
set appDir to do shell script "dirname " & quoted form of appPath
set repoFromApp to do shell script "cd " & quoted form of appDir & " && cd .. && pwd"
set runFromApp to repoFromApp & "/scripts/run-macos.sh"
set runCmd to ""
if (do shell script "test -x " & quoted form of runFromApp & "; echo $?") is "0" then
  set runCmd to "cd " & quoted form of repoFromApp & "; MUIO_ENV_NAME=" & quoted form of envName & " " & quoted form of runFromApp
else
  set runCmd to "cd " & quoted form of repoPath & "; MUIO_ENV_NAME=" & quoted form of envName & " " & quoted form of runScriptPath
end if
tell application "Terminal"
  activate
  do script runCmd
end tell
delay 2
open location "http://127.0.0.1:5002/"
EOF

rm -rf "$APP_PATH"
osacompile -o "$APP_PATH" "$TMP_SCRIPT"

cat <<EOF
Created app bundle:
  $APP_PATH

You can double-click it to launch MUIO (opens Terminal).
EOF
