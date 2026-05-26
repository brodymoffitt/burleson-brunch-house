#!/usr/bin/env bash
# Run this on your OTHER device (the one with the working ~/.claude/ setup).
# It packages your global Claude config into a git repo ready to push to GitHub.
#
# It does NOT push anything. Read it, then run it.

set -euo pipefail

CLAUDE_DIR="${HOME}/.claude"

if [ ! -d "$CLAUDE_DIR" ]; then
  echo "No ~/.claude/ directory found. Nothing to export."
  exit 1
fi

echo "==> Contents of ~/.claude/:"
ls -la "$CLAUDE_DIR"
echo

echo "==> Files that will be tracked (everything except caches and secrets):"
cd "$CLAUDE_DIR"

# A reasonable .gitignore for ~/.claude/. Adjust before committing if needed.
cat > .gitignore <<'EOF'
# caches and per-session state
projects/
todos/
shell-snapshots/
statsig/
ide/
.credentials.json
*.log
EOF

if [ ! -d .git ]; then
  echo "==> Initializing git repo in ~/.claude/"
  git init -q
  git branch -M main
fi

git add -A
git status --short
echo
echo "==> Review the staged files above. If anything sensitive is staged,"
echo "    edit ~/.claude/.gitignore and re-run this script."
echo
echo "Next steps:"
echo "  1. Create a PRIVATE repo at https://github.com/new called 'dotfiles'"
echo "  2. cd ~/.claude"
echo "  3. git commit -m 'initial claude config export'"
echo "  4. git remote add origin git@github.com:brodymoffitt/dotfiles.git"
echo "  5. git push -u origin main"
