#!/usr/bin/env bash
# SessionStart hook: clone brodymoffitt/dotfiles and symlink files into ~/.claude/.
# Runs at the start of every Claude Code session in this repo.
#
# Required env vars (set in your Claude Code on the web environment settings):
#   DOTFILES_TOKEN   fine-grained PAT with read access to brodymoffitt/dotfiles
#
# Optional:
#   DOTFILES_REPO    default: brodymoffitt/dotfiles
#   DOTFILES_BRANCH  default: main

set -euo pipefail

REPO="${DOTFILES_REPO:-brodymoffitt/dotfiles}"
BRANCH="${DOTFILES_BRANCH:-main}"
CACHE_DIR="${HOME}/.cache/claude-dotfiles"
TARGET_DIR="${HOME}/.claude"

mkdir -p "$TARGET_DIR"

if [ -z "${DOTFILES_TOKEN:-}" ]; then
  echo "[restore-dotfiles] DOTFILES_TOKEN not set; skipping dotfiles sync." >&2
  exit 0
fi

CLONE_URL="https://x-access-token:${DOTFILES_TOKEN}@github.com/${REPO}.git"

if [ -d "$CACHE_DIR/.git" ]; then
  git -C "$CACHE_DIR" remote set-url origin "$CLONE_URL" >/dev/null
  git -C "$CACHE_DIR" fetch --quiet --depth=1 origin "$BRANCH"
  git -C "$CACHE_DIR" reset --quiet --hard "origin/${BRANCH}"
else
  rm -rf "$CACHE_DIR"
  git clone --quiet --depth=1 --branch "$BRANCH" "$CLONE_URL" "$CACHE_DIR"
fi

# Symlink every tracked file from the dotfiles repo into ~/.claude/.
# Mirrors the directory structure so nested files (e.g. agents/foo.md) work too.
cd "$CACHE_DIR"
while IFS= read -r -d '' file; do
  rel="${file#./}"
  case "$rel" in
    .git/*|.gitignore) continue ;;
  esac
  dest="${TARGET_DIR}/${rel}"
  mkdir -p "$(dirname "$dest")"
  ln -snf "${CACHE_DIR}/${rel}" "$dest"
done < <(find . -type f -print0)

echo "[restore-dotfiles] synced ${REPO}@${BRANCH} into ${TARGET_DIR}"
