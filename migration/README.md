# Migration: skills + CLIs + MCPs

Each of these moves differently. Here's the short version:

| Thing | Where it lives | How to migrate |
|-------|----------------|----------------|
| **Skills** | Markdown files in `~/.claude/skills/` (user) or `.claude/skills/` (project) | Copy the files into this repo or a synced dotfiles repo |
| **CLIs** | Binaries installed in the container | SessionStart hook installs them on each fresh web session |
| **MCPs** | `.mcp.json` (project) or web dashboard (environment) | Commit `.mcp.json` to the repo; or configure in the dashboard |

## Step 1 — Inventory your other device

Run this on the device that currently has everything working:

```bash
bash migration/inventory.sh > migration/inventory.txt
```

Paste `inventory.txt` back to me (or commit it) and I'll wire up exactly what
you have — no guessing.

## Step 2 — Skills

Two options:

- **Per-project skills** — drop `.md` files into `.claude/skills/` here. They
  load automatically when you open this repo. Best for project-specific skills.
- **User-level skills** — copy your `~/.claude/skills/` from the other device
  into `migration/skills/` here, and the `install.sh` hook will symlink them
  into `~/.claude/skills/` on every web session start.

## Step 3 — CLIs

Edit `migration/install-clis.sh` to list whatever's missing on the web side.
Already pre-installed in this container:

```
node npm pnpm yarn bun python python3 pip uv ruby go cargo rustc
java mvn gradle docker git jq yq rg make cmake gcc clang psql redis-cli
```

Common ones NOT pre-installed (uncomment in `install-clis.sh` to add):
`gh`, `fzf`, `bat`, `fd-find`, `eza`, `sqlite3`, `kubectl`, `terraform`,
`aws-cli`, `gcloud`.

## Step 4 — MCPs

You already have three MCPs wired into this web environment: **GitHub**,
**Calendar**, **Gmail**. Those are configured at the environment level in the
Claude Code on the web dashboard — not via files.

If you want a different set of MCPs for *this repo specifically*, drop them in
`.mcp.json` at the repo root. Template is in `migration/mcp.json.example`.

To add or remove environment-level MCPs (the ones available in every session),
go to the environment settings: https://code.claude.com/docs/en/claude-code-on-the-web

## Step 5 — Activate

```bash
mkdir -p .claude
cp migration/settings.local.json.example .claude/settings.local.json
git add .claude migration && git commit -m "activate migration hooks" && git push
```

End this session and start a new one. The hook will install your CLIs and
link your skills before you start.
