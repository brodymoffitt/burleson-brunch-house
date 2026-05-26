---
name: design-tokens
description: Manage and extend the Material Design 3 token system in tailwind.config.mjs. Use when adding new colors, adjusting the palette, changing fonts, adding radii, or when the user asks "add a new accent color", "tweak the palette", "support dark mode for X".
---

# Design tokens

The token system lives in `tailwind.config.mjs`. It follows Material Design 3
naming: each color family (`primary`, `secondary`, `tertiary`, `error`) has a
full set of role tokens (`-container`, `on-*`, `*-fixed`, `*-dim`, etc.).

## The rules

1. **Never add a token without its `on-*` pair.** A `bg-foo` is useless if there's no `text-on-foo` that's readable on it.
2. **Add to `theme.extend.colors`, not `theme.colors`** — keeps Tailwind's defaults available as fallback.
3. **Name by role, not by hue.** If you find yourself wanting `bg-light-green`, you're naming wrong — what *role* is it? `surface-success-container`? `primary-fixed`?
4. **Test contrast** before committing. AA = 4.5:1 for body text, 3:1 for large text and UI components.

## Adding a new color family

If you genuinely need one (rare — usually you can use an existing family):

```js
'success':                   '#hex',
'success-dim':               '#hex',
'success-container':         '#hex',
'on-success':                '#ffffff',
'on-success-container':      '#hex',
```

Mirror the structure of `primary`/`secondary`/etc. — anything less is incomplete.

## Adjusting the existing palette

- Change `primary` and you must re-verify every place it's used.
- `on-*` tokens must update too if the base shifts darker/lighter.
- Surface tokens form a layered stack — `surface-container-lowest` → `surface-container-highest` should read as steps of elevation, not random shades.

## Fonts

Four families currently registered:
- `headline`: Newsreader (serif)
- `body`: Work Sans
- `label`: Work Sans
- `script`: Great Vibes

Fonts must also be loaded — check `src/layouts/` or the base HTML for the
`<link>` to Google Fonts or local font files. Adding to the Tailwind config
alone doesn't load the font.

## Radii

Current scale:
- `DEFAULT`: 0.25rem
- `sm`: 0.375rem
- `lg`: 0.5rem
- `xl`: 1.5rem
- `full`: pill/circle

Resist adding more steps. Five is plenty; six starts to feel arbitrary.

## Dark mode

`darkMode: 'class'` is active. To properly support dark mode for a new token
family, define both schemes:

```js
// option A: media-query-driven via CSS variables (more work, more flexible)
// option B: provide explicit dark variants and use `dark:` prefix in markup
```

Right now the repo uses option B implicitly. If you want first-class dark
support, propose option A and migrate the whole palette in one PR — don't
half-migrate.

## Process when extending tokens

1. State the **role** the new token plays.
2. Check if an existing family already covers it. If yes, use that.
3. If no, add the **full set** of related tokens (base + on-* + container variants).
4. Update one usage site as proof it works.
5. Run the dev server and check both light and dark.
