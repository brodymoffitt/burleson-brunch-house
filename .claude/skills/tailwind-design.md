---
name: tailwind-design
description: Guide for designing and styling Astro components in this repo using its Material Design 3 token system. Use when building new UI, restyling existing components, or making layout/typography/color decisions. Triggers on requests like "style this", "make this look better", "design a [component]", "improve the look of [page]".
---

# Tailwind design (Astro + M3 tokens)

This repo uses a Material Design 3-style token system defined in
`tailwind.config.mjs`. Never hardcode hex colors, raw `text-gray-500`, or
arbitrary spacing — always reach for the existing tokens.

## Color tokens (use these, not raw colors)

**Roles, not hues.** Pick the token by what the element *does*, not what color you want.

- **Brand/primary actions:** `bg-primary text-on-primary` (filled buttons, key CTAs)
- **Tonal surfaces in primary family:** `bg-primary-container text-on-primary-container`
- **Secondary actions / accents:** `bg-secondary text-on-secondary` or `bg-secondary-container text-on-secondary-container`
- **Tertiary / highlight (warm accent):** `bg-tertiary text-on-tertiary` or `*-container` variants
- **Page background:** `bg-background text-on-background`
- **Cards / panels:** `bg-surface-container text-on-surface` — use `-low` / `-high` / `-highest` to layer depth
- **Subtle text on surface:** `text-on-surface-variant`
- **Borders/dividers:** `border-outline-variant` (light) or `border-outline` (stronger)
- **Errors:** `bg-error-container text-on-error-container` for messages; `bg-error text-on-error` for destructive buttons

## Typography

Four families, each with a job:
- `font-headline` (Newsreader serif) — page titles, section headers, brand moments
- `font-body` (Work Sans) — paragraphs, descriptions, default body text
- `font-label` (Work Sans) — buttons, form labels, small UI text
- `font-script` (Great Vibes) — decorative flourishes only, sparingly

Pair: headline serif + body sans is the established voice. Don't mix in a third sans-serif.

## Spacing & rhythm

- Default to Tailwind's 4px scale: `p-4`, `p-6`, `p-8`, `gap-4`, `gap-6`, `gap-8`.
- **Be consistent within a section** — pick one rhythm (e.g. `space-y-6`) and stick to it.
- Section vertical padding: `py-16` (mobile) → `md:py-24` → `lg:py-32` for marketing sections.
- Container: `max-w-7xl mx-auto px-4 sm:px-6 lg:px-8` is the established pattern.

## Radii

`rounded` (default 0.25rem) for subtle, `rounded-lg` for cards/buttons, `rounded-xl`
(1.5rem) for hero/feature cards, `rounded-full` for pills and avatars.

## Dark mode

`darkMode: 'class'` — the token names already imply light scheme. If you add
dark-mode styles, use `dark:` prefix and reach for the same role tokens (they
should be designed to work in both schemes; if a token looks wrong in dark, fix
it in `tailwind.config.mjs` rather than overriding inline).

## Process when designing a new component

1. **Identify its role** — is it a primary action, a container, a piece of body text?
2. **Pick tokens by role**, not by aesthetic preference.
3. **Set the type scale** before colors — get hierarchy right first.
4. **Lay out spacing** using one consistent rhythm.
5. **Add radii and shadows** last — these are polish, not structure.
6. **Check it against neighbors** — does it visually belong with the rest of the page?

## What to avoid

- `text-gray-*`, `bg-slate-*`, raw hex codes — use tokens.
- Arbitrary values like `text-[17px]` or `p-[13px]` unless there's a real reason.
- Mixing serif and script in the same paragraph.
- Inventing new colors inline — extend `tailwind.config.mjs` instead.
- Stacking more than 2 surface layers (`surface` → `surface-container` → done; don't go deeper without reason).
