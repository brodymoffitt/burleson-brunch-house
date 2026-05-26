# Website Business — Claude Code Context

## What I'm building
Professional websites for local businesses with no existing web presence.
Goal: fast, beautiful, sellable. Zero manual coding or design decisions.

## Stack
- Framework: Astro + Tailwind CSS
- Deployment: Vercel via GitHub
- Components: 21st.dev for UI primitives
- Design system: exported from Claude Design (designer.md in project folder)

## Design Rules
- Always read designer.md before writing any UI code
- Mobile-first, fully responsive
- No generic AI layouts — use reference screenshots provided
- Avoid: purple gradients, centered hero text on dark bg, stock-looking sections
- Use semantic HTML: section, article, nav, header, footer
- No JS frameworks unless interaction specifically requires it

## Coding Conventions
- All components in src/components/
- All pages in src/pages/
- One repo per client, named: clientname-website
- Commit after each major section is complete
- Always run: npm run build before marking anything done

## Workflow
- Plan before building — confirm structure before writing code
- One section at a time
- Be specific when I give feedback — I will tell you exactly what to change
- When adding components from 21st.dev, blend them with the existing design system

## Skills Installed
- impeccable (frontend design polish + audit + anti-pattern detection)
- frontend-design (Anthropic official, distinctive UI generation)
- tailwind-design, design-review, design-tokens (repo-specific, knows the M3 token system)
- UIUX Pro Max (via uipro-cli) — not yet installed in this environment
