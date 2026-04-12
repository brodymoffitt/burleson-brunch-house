# Design System Strategy: The Culinary Editorial

## 1. Overview & Creative North Star
The Creative North Star for this design system is **"The Heritage Host."** This isn't a digital storefront; it is a digital extension of a physical, sun-drenched breakfast room. We are moving away from the rigid, grid-locked "corporate" web and toward a high-end editorial layout that feels curated and lived-in.

By utilizing intentional asymmetry, overlapping imagery, and large-scale serif typography, we create an experience that feels as tactile as a heavy paper menu. We challenge the standard "box-on-box" UI by treating the interface as a series of layered organic surfaces, mimicking the warmth of a neighborhood table.

## 2. Colors & Surface Philosophy
The palette is grounded in the soft, muted tones of sage and dusty teal, anchored by the warmth of cream and the richness of wood-inspired accents.

### The "No-Line" Rule
Standard 1px borders are strictly prohibited for sectioning. We define space through **Tonal Transitions**. To separate the "Today’s Specials" section from the "Hero" area, shift the background from `surface` (#fffbff) to `surface_container_low` (#fdf9ef). The eye understands the boundary through color, not a harsh stroke.

### Surface Hierarchy & Nesting
Treat the interface as a physical stack of fine paper.
- **Background:** `surface` (#fffbff) for the primary canvas.
- **Secondary Sections:** `surface_container` (#f7f3e8) for large, grouped content.
- **Prominent Modules:** `surface_container_highest` (#ece8db) for call-outs or reservation cards.
Use this nesting to create "soft depth." An inner element should always be a tier higher or lower than its parent to establish focus.

### The "Glass & Gradient" Rule
To add visual "soul," use a subtle linear gradient on primary CTAs and header highlights, transitioning from `primary` (#55695d) to `primary_container` (#d2e8d9) at a 45-degree angle. For floating navigation or over-image labels, use **Glassmorphism**: `surface` at 70% opacity with a `20px` backdrop-blur.

## 3. Typography
The typography is an intentional dialogue between the elegance of a handwritten invitation and the authority of a classic broadsheet.

- **Display & Headline (Newsreader):** Use `display-lg` (3.5rem) for high-impact editorial moments. This serif conveys tradition and high-end quality.
- **Brand Identity (Script):** Reserved exclusively for the brand name and occasional "Hand-signed" accents (e.g., "From our kitchen to yours"). It should overlap images to break the digital "box."
- **Title & Body (Work Sans):** `body-lg` (1rem) provides the modern readability required for menus and descriptions. Its clean, sans-serif nature provides a necessary counterpoint to the decorative Newsreader.

## 4. Elevation & Depth
We eschew "Material" shadows in favor of **Ambient Tonal Layering**.

- **The Layering Principle:** Depth is achieved by placing a `surface_container_lowest` (#ffffff) card against a `surface_dim` (#e6e3d5) background. The contrast in warmth creates the lift.
- **Ambient Shadows:** For floating elements like a "Book a Table" button, use an extra-diffused shadow: `box-shadow: 0 12px 40px rgba(57, 56, 47, 0.06);`. The shadow color is a tint of our `on_surface` charcoal, never a neutral grey.
- **The "Ghost Border" Fallback:** If a boundary is strictly required for accessibility, use `outline_variant` (#bcb9ad) at **15% opacity**. It should be felt, not seen.

## 5. Components

### Buttons
- **Primary:** `primary` (#55695d) background with `on_primary` (#ffffff) text. Use `xl` (1.5rem) roundedness for a soft, inviting feel.
- **Tertiary:** No background. Use `primary` text with a subtle underline that expands on hover.

### Cards & Menu Items
Forbid the use of divider lines between items. Use `surface_container_low` for the card body and generous vertical padding (32px+) to define the separation. Images should have a `lg` (1rem) corner radius.

### Input Fields
Inputs should use the `surface_variant` (#ece8db) as a background with no border. On focus, transition to `primary_container` (#d2e8d9). This creates a "recessed" look that feels more premium than a white box.

### Signature Component: The "Feature Overlap"
A specialized component for hero sections where a `display-md` headline overlaps a `primary_container` decorative element and a `secondary` image frame. This breaks the grid and enforces the "Editorial" feel.

## 6. Do's and Don'ts

### Do
- **DO** use the `tertiary` (#835d35) "wood tone" for interactive accents like star ratings or price points.
- **DO** allow for intentional white space. The "Heritage Host" style needs room to breathe.
- **DO** use the `roundedness.xl` (1.5rem) scale for any element that the user "touches" (Buttons, Input fields) to keep it family-friendly.

### Don't
- **DON'T** use 100% black text. Always use `on_surface` (#39382f) for a softer, organic contrast.
- **DON'T** use standard 90-degree corners. Everything should have at least a `sm` radius to maintain the "warm and cozy" ethos.
- **DON'T** use high-speed, "snappy" animations. Use ease-in-out transitions (300ms+) to mimic a slow brunch atmosphere.