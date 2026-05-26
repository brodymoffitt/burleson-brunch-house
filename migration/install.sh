#!/usr/bin/env bash
# SessionStart hook: prepare this web session to match your usual setup.
# - installs CLIs listed in install-clis.sh
# - symlinks any user-level skills from migration/skills/ into ~/.claude/skills/
#
# Idempotent: safe to run on every session start.

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# --- CLIs ---------------------------------------------------------------
if [ -x "$SCRIPT_DIR/install-clis.sh" ]; then
  echo "[migration] installing CLIs"
  "$SCRIPT_DIR/install-clis.sh" || echo "[migration] some CLI installs failed (continuing)"
fi

# --- user-level skills --------------------------------------------------
if [ -d "$SCRIPT_DIR/skills" ]; then
  mkdir -p "$HOME/.claude/skills"
  count=0
  for src in "$SCRIPT_DIR"/skills/*; do
    [ -e "$src" ] || continue
    name="$(basename "$src")"
    ln -snf "$src" "$HOME/.claude/skills/$name"
    count=$((count+1))
  done
  echo "[migration] linked $count skill(s) into ~/.claude/skills/"
fi

echo "[migration] done"
