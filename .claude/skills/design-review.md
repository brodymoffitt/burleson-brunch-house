---
name: design-review
description: Audit existing UI for visual quality issues before shipping. Use when the user says "review the design", "does this look right", "audit this page", "what's wrong with this layout", or before merging a UI PR.
---

# Design review

Walk through the changed UI methodically. For each finding, name the file and
roughly where (component, section) so the fix is actionable.

## Checklist (in order)

### 1. Hierarchy
- Is the primary action obviously the primary action? (One per section, max.)
- Does scanning the page top-to-bottom reveal structure without reading?
- Are headings sized in clear steps (h1 >> h2 > h3, not h1 > h2 ≈ h3)?
- Is body text actually readable — at least `text-base`, line-height comfortable?

### 2. Spacing
- One consistent rhythm per section (don't mix `gap-4` and `gap-5`).
- Sections breathe: `py-16` minimum on marketing, `py-8` minimum on dense UI.
- Related items grouped tighter than unrelated ones (proximity = relationship).
- No cramped edges — mobile `px-4` minimum.

### 3. Color / tokens
- No raw `text-gray-*`, `bg-slate-*`, or hex codes — everything from `tailwind.config.mjs` tokens.
- Token chosen by **role**, not by hue (e.g. `bg-error-container` for warnings, not `bg-red-100`).
- Contrast actually meets WCAG AA: `text-on-X` matches the `bg-X` it sits on.
- Dark mode still works (if `dark:` prefixes exist anywhere on the page).

### 4. Typography
- Headline serif for headers, body sans for paragraphs — not mixed up.
- `font-script` used at most once per page, decoratively.
- Line length sane: paragraphs `max-w-prose` or `max-w-2xl`, not full-width walls.

### 5. Alignment & rhythm
- Things that should align, align (left edges, baselines, button heights).
- Grid columns equal width unless intentional.
- Buttons in a row: same height, same padding, same radius.

### 6. Radii & polish
- Radius scale is consistent (don't mix `rounded` and `rounded-md` in the same card).
- Shadows used sparingly — for elevation that matters, not for decoration.
- Borders use `outline-variant` / `outline` tokens, not raw `border-gray-200`.

### 7. Responsive
- Test mental model at 375px (mobile), 768px (tablet), 1280px (desktop).
- Nothing overflows horizontally on mobile.
- Images have `w-full h-auto` or aspect-ratio constraints.
- Text doesn't shrink below `text-sm` on mobile.

### 8. Interactive states
- `hover:`, `focus-visible:`, `active:` states present on interactive elements.
- Focus ring visible and uses a token color (`ring-primary` or similar).
- Disabled state distinguishable (`opacity-50 cursor-not-allowed` is fine).

## Output format

Report findings as:

```
[severity] file_path:line  — what's wrong, what to do
```

Severities: **blocking** (broken/inaccessible/off-brand), **should-fix** (visibly wrong),
**polish** (could be better). Don't pad the list with polish if there are blockers.
