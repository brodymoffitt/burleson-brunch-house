#!/usr/bin/env bash
# Run this ON YOUR LOCAL MACHINE (Mac or Linux) — not in Claude Code on the web.
# Creates a parent workspace folder for all your client website projects.
#
# Final structure:
#
#   ~/claude-website-projects/
#     CLAUDE.md               <- your business-wide standards (auto-loads for every project here)
#     burleson-brunch-house/  <- first client
#     <next-client>/          <- future client repos go here too
#
#   ~/.claude/
#     skills/
#       impeccable/           <- shared across every project
#       frontend-design/
#     settings.json           <- 21st.dev MCP + permissions, applies globally
#
# Re-runnable: safe to run again. Won't overwrite existing client repos.

set -euo pipefail

WORKSPACE="${HOME}/claude-website-projects"
CLAUDE_USER_DIR="${HOME}/.claude"
SOURCE_REPO="git@github.com:brodymoffitt/burleson-brunch-house.git"
SOURCE_BRANCH="claude/eloquent-heisenberg-WgkEn"   # branch where our setup lives

echo "==> Creating workspace at $WORKSPACE"
mkdir -p "$WORKSPACE"
mkdir -p "$CLAUDE_USER_DIR/skills"

# --- 1. Clone burleson-brunch-house into the workspace -------------------
if [ ! -d "$WORKSPACE/burleson-brunch-house" ]; then
  echo "==> Cloning burleson-brunch-house"
  git -C "$WORKSPACE" clone "$SOURCE_REPO"
else
  echo "==> burleson-brunch-house already exists, skipping clone"
fi

cd "$WORKSPACE/burleson-brunch-house"
git fetch origin "$SOURCE_BRANCH"
git checkout "$SOURCE_BRANCH" 2>/dev/null || git switch -c "$SOURCE_BRANCH" --track "origin/$SOURCE_BRANCH"

# --- 2. Place the business-wide CLAUDE.md at the workspace root ----------
# Claude Code (local) walks up the directory tree, so this loads for every
# client repo nested inside the workspace.
if [ ! -f "$WORKSPACE/CLAUDE.md" ]; then
  echo "==> Copying business-wide CLAUDE.md to workspace root"
  cp "$WORKSPACE/burleson-brunch-house/CLAUDE.md" "$WORKSPACE/CLAUDE.md"
else
  echo "==> $WORKSPACE/CLAUDE.md already exists, leaving it alone"
fi

# --- 3. Install shared skills globally (~/.claude/skills/) ---------------
echo "==> Installing shared skills into ~/.claude/skills/"
for skill in impeccable frontend-design; do
  src="$WORKSPACE/burleson-brunch-house/.claude/skills/$skill"
  dest="$CLAUDE_USER_DIR/skills/$skill"
  if [ -d "$src" ]; then
    rm -rf "$dest"
    cp -r "$src" "$dest"
    echo "    installed $skill"
  fi
done

# --- 4. Set up global ~/.claude/settings.json with 21st.dev MCP ----------
SETTINGS="$CLAUDE_USER_DIR/settings.json"
if [ ! -f "$SETTINGS" ]; then
  echo "==> Creating $SETTINGS with 21st.dev Magic MCP"
  cat > "$SETTINGS" <<'JSON'
{
  "mcpServers": {
    "magic": {
      "command": "npx",
      "args": ["-y", "@21st-dev/magic@latest"],
      "env": {
        "API_KEY": "${TWENTYFIRST_API_KEY}"
      }
    }
  }
}
JSON
  echo "    NOTE: set TWENTYFIRST_API_KEY in your shell rc (~/.zshrc or ~/.bashrc):"
  echo "          export TWENTYFIRST_API_KEY=your-key-here"
else
  echo "==> $SETTINGS already exists, leaving it alone (merge magic MCP manually if needed)"
fi

# --- 5. Verify ----------------------------------------------------------
echo
echo "=================================================="
echo "Workspace ready at: $WORKSPACE"
echo "=================================================="
ls -la "$WORKSPACE"
echo
echo "Shared skills:"
ls "$CLAUDE_USER_DIR/skills"
echo
echo "Next steps:"
echo "  1. cd $WORKSPACE/burleson-brunch-house && claude   # start working here"
echo "  2. For a new client:"
echo "       cd $WORKSPACE"
echo "       git clone git@github.com:brodymoffitt/<new-client>-website.git"
echo "       cp -r burleson-brunch-house/_template/. <new-client>-website/"
echo "  3. Make sure TWENTYFIRST_API_KEY is exported in your shell rc."
