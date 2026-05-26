#!/usr/bin/env bash
# Run on your OTHER device to inventory what Claude Code config exists there.
# Output is plain text — safe to commit or paste back into a chat.

set -uo pipefail

echo "=================================================="
echo "Claude Code inventory  $(date)  $(uname -srm)"
echo "=================================================="
echo

echo "## Skills (user-level: ~/.claude/skills/)"
if [ -d "$HOME/.claude/skills" ]; then
  find "$HOME/.claude/skills" -maxdepth 2 -type f -name '*.md' | sed "s|$HOME|~|"
else
  echo "(none)"
fi
echo

echo "## Skills (project-level, this dir: .claude/skills/)"
if [ -d ".claude/skills" ]; then
  find ".claude/skills" -maxdepth 2 -type f -name '*.md'
else
  echo "(none in current directory)"
fi
echo

echo "## Agents (~/.claude/agents/)"
if [ -d "$HOME/.claude/agents" ]; then
  ls -1 "$HOME/.claude/agents" 2>/dev/null
else
  echo "(none)"
fi
echo

echo "## MCP servers configured for the user"
if command -v claude >/dev/null 2>&1; then
  claude mcp list 2>/dev/null || echo "(claude mcp list failed)"
else
  echo "(claude CLI not on PATH)"
fi
echo

echo "## .mcp.json files in home"
find "$HOME" -maxdepth 3 -name '.mcp.json' 2>/dev/null | sed "s|$HOME|~|"
echo

echo "## CLIs commonly used by Claude"
for c in gh hub fzf bat fd eza sqlite3 kubectl terraform aws gcloud az \
         docker docker-compose mongosh mysql psql redis-cli \
         node npm pnpm yarn bun deno python python3 pip uv \
         ruby go rustc cargo java mvn gradle make cmake gcc clang \
         jq yq rg ripgrep ; do
  if command -v "$c" >/dev/null 2>&1; then
    printf "  %-14s %s\n" "$c" "$(command -v "$c")"
  fi
done
echo

echo "## ~/.claude/ top level"
ls -la "$HOME/.claude/" 2>/dev/null | grep -v '^total' || echo "(no ~/.claude)"
echo

echo "=================================================="
echo "Done. Paste this output back, or:"
echo "  cp migration/inventory.txt to this repo to commit it."
echo "=================================================="
