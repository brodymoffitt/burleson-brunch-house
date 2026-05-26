# Template — bootstrap a new client website

This folder is a self-contained starter for a new client website project.
Copy its contents into a fresh repo and you get the same skills, MCPs, and
auto-installed CLIs that this repo has.

## Bootstrap a new client (the fast path)

```bash
# 1. Create empty repo on GitHub: clientname-website (private)
# 2. Locally:
mkdir clientname-website && cd clientname-website
git init && git branch -M main

# 3. Copy template contents into it
cp -r /path/to/burleson-brunch-house/_template/. .

# 4. Scaffold the Astro app
npm create astro@latest . -- --template minimal --typescript strict
npm install -D tailwindcss @astrojs/tailwind
# ...wire tailwind.config.mjs like the brunch-house repo

# 5. Replace placeholders
# Edit CLAUDE.md — replace {{CLIENT_NAME}}, {{BUSINESS_NAME}}, etc.
# Drop the client's designer.md export into the root

# 6. First commit + push
git add . && git commit -m "initial bootstrap from template"
git remote add origin git@github.com:brodymoffitt/clientname-website.git
git push -u origin main

# 7. In Claude Code on the web dashboard:
#    - Create a new environment for this repo
#    - Set TWENTYFIRST_API_KEY secret (so 21st.dev Magic MCP works)
#    - Open a session and the SessionStart hook installs vercel etc.
```

## What's in this template

| Path | Purpose |
|------|---------|
| `CLAUDE.md` | Project context template (replace placeholders per client) |
| `.claude/settings.local.json` | Registers the SessionStart hook |
| `.claude/install-clis.sh` | Installs vercel and any other CLIs on each session |
| `.claude/skills/impeccable/` | pbakaus/impeccable design skill |
| `.claude/skills/frontend-design/` | Anthropic's official frontend-design skill |
| `.mcp.json` | 21st.dev Magic MCP config (needs `TWENTYFIRST_API_KEY` env var) |

## What's NOT in the template (and why)

- The repo-specific design skills (`tailwind-design`, `design-review`,
  `design-tokens`) — those are tuned to the brunch-house's specific token
  palette. For each new client, regenerate them from that client's
  designer.md / tailwind.config.mjs.
- `tailwind.config.mjs` — every client has a different palette; copying
  the brunch-house tokens would be misleading.
- Astro page/component files — scaffolded fresh per client.

## When you change the template

If you improve the skills, install scripts, or MCP config here, **also**
back-propagate them into client repos that need them. Or pull from this
template into existing clients as a one-off `cp -r` job.
