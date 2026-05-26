# Claude Code Migration

Goal: make your global `~/.claude/` config (CLAUDE.md, settings, hooks, etc.)
available in every Claude Code on the web session, since the web container is
ephemeral and starts fresh each time.

## Architecture

```
[other device ~/.claude/]  --push-->  [GitHub: brodymoffitt/dotfiles]
                                              |
                                              v
[web session container]  <--clone--  SessionStart hook on each new session
       symlinks files into ~/.claude/
```

## Step 1 — On your other device: export your global config

Run the script in this folder:

```bash
bash migration/01-export-from-other-device.sh
```

It will:
- show you what's currently in `~/.claude/`
- initialize a git repo there
- prepare a commit you can push to a new `brodymoffitt/dotfiles` GitHub repo

Read the script before running — it does not push anything on its own.

## Step 2 — Create the GitHub repo

1. Go to https://github.com/new
2. Name: `dotfiles`
3. Visibility: **Private**
4. Do NOT initialize with README/license (the script already made a clean repo)
5. Copy the SSH or HTTPS URL

Then on your other device:

```bash
cd ~/.claude
git remote add origin git@github.com:brodymoffitt/dotfiles.git
git push -u origin main
```

## Step 3 — Auth so web containers can clone the private repo

The web container needs read access to `brodymoffitt/dotfiles`. Easiest path:

1. Create a **fine-grained personal access token**: https://github.com/settings/tokens?type=beta
   - Resource owner: your account
   - Repository access: Only `brodymoffitt/dotfiles`
   - Repository permissions: **Contents: Read-only**
2. Add it as an environment secret in your Claude Code on the web environment
   settings as `DOTFILES_TOKEN`
   (see https://code.claude.com/docs/en/claude-code-on-the-web for where this
   lives in the dashboard)

## Step 4 — Wire up the SessionStart hook (already done in this repo)

The files in this folder do the wiring:

- `restore-dotfiles.sh` — what runs on every session start. Clones the
  dotfiles repo into a cache dir, then symlinks each file into `~/.claude/`.
- `settings.local.json.example` — the snippet that registers the hook.

To activate it on this machine for this project:

```bash
mkdir -p .claude
cp migration/settings.local.json.example .claude/settings.local.json
chmod +x migration/restore-dotfiles.sh
```

Commit and push — every future web session on this repo will run the hook
and restore your global Claude config before you start working.

## Step 5 — Test it

End this session and start a new one. Then ask:

> what's in ~/.claude/CLAUDE.md?

If the contents come back, you're done.

## Files in this folder

| File | Purpose |
|------|---------|
| `README.md` | This file |
| `01-export-from-other-device.sh` | Run on source machine to package `~/.claude/` |
| `restore-dotfiles.sh` | Hook script that runs at session start in web containers |
| `settings.local.json.example` | Snippet to register the SessionStart hook |
| `.gitignore` | So we don't accidentally commit cloned dotfiles |
