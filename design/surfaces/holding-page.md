# Holding page — `genuinegossip.app`

Source: Holding Page — `genuinegossip.app` v0.1 (May 2026).

A pre-launch landing page for the domain. Lean-in-lightly posture:
regency hero, single email field, claret seal, no marketing copy.

## Purpose

- Hold the domain with brand-consistent presence.
- Capture interest from people who already heard the name (no SEO,
  no funnel optimization).
- Stay quiet. We write to subscribers exactly **once**, when keys
  are issued. No newsletter. No marketing.

## Surface palette

This page is treated as letterhead — it gets the **champagne paper**
palette, not the product's bone palette.

| Token | Hex | Use |
|---|---|---|
| `bg` | `#F4EBD9` | Page background (warm cream) |
| `paper` | `#FBF6E9` | Optional elevated surface |
| `ink` | `#1F1410` | Text and rules (deep ink, not the product `#0E0D0B`) |
| `soft` | `#7A6A5A` | Secondary text, mono caps meta |
| `claret` | `#7A1F2B` | Seal mark, salutation, confirmation copy |
| `hair` | `rgba(31,20,16,0.18)` | Header / footer rules |

Background dressing: two soft radial gradients, very subtle —
claret tint at top-left (5% opacity, 50% radius), champagne tint at
bottom-right (12% opacity, 50% radius). No other texture.

## Typography

Same families as the product (`Cormorant Garamond`, `Inter Tight`,
`JetBrains Mono`). Same italic-carries-warmth rule.

## Layout

Single column, max-width `980px`, page padding
`32px clamp(20px, 4vw, 48px)`. Body is `min-height: 100vh`,
flex column, header → main → footer.

### Header

A thin row, mono caps, ink-soft, with a 1px `hair` rule beneath and
24px space below the rule, then 48px before the hero.

- Left: 24px claret seal SVG (`gg` italic in bone) + wordmark
  `genuine gossip.` in Cormorant 400 / 18px / −0.2 letter-spacing,
  not uppercase.
- Right: meta line `PRIVATE RELEASE · 2026` (mono / 11px / +2 letter-
  spacing / UPPER / ink-soft).

### Hero (main)

Stacked, generously spaced (gap `48px`). Vertically centered in the
remaining viewport.

1. **Salutation.** `Dearest reader,` — Cormorant Italic 300,
   `clamp(28px, 3.4vw, 40px)`, claret, line-height 1.1.
2. **Display headline.** `a card / between / two of you.` — Cormorant
   300, `clamp(64px, 12vw, 168px)`, line-height 0.86, tracking −4px
   (clamp to −2px below 560px). The phrase `two of you.` is italic.
3. **Lede.** Cormorant Italic 300, `clamp(20px, 2.4vw, 28px)`,
   line-height 1.45, max-width 40ch, ink:

   > A small object — a single conversation card, passed between the
   > two of you, written and re-written. In private early release
   > this autumn.

4. **Signup form.** See below.

### Signup form

Hairline field — the same primitive as the in-app gate, restyled for
this surface.

- Container: flex column, gap 14px, max-width 480px, top margin 8px.
- Field row: flex baseline, 1px ink underline, 12px bottom padding.
  - Input: transparent, no border, no outline. Cormorant Light 300 /
    24px. Placeholder `your@address` in italic ink-soft.
  - Label: `REQUEST A KEY` — mono caps / 10px / +2 / UPPER / ink-soft.
- Submit: outlined button, ink border, ink text on transparent;
  hover fills ink and flips text to bg. Inter Tight 500 / 12px / +1.6
  / UPPER, padding 12 22. Copy: `Send key when ready`.
- Confirmation: hidden until submit; on submit shows Cormorant
  Italic / 18px / claret line — `— filed away. you'll hear from us.`
  Reset the form on submit.
- Note (below confirmation): Inter Tight / 14px / 1.6 line-height /
  ink-soft, max-width 46ch:

  > No newsletter. No marketing. We write to you exactly once, when
  > keys are issued.

### Footer

1px `hair` rule above. Mono caps, ink-soft, 32px vertical padding.
Flex row, space-between, wraps on narrow screens with 12px gap.

- Left: `genuinegossip.app`.
- Right: `© 2026 · written by hand`.

## Behavior

- The submit handler stores the email (mechanism deferred — backend
  not yet built; see `docs/roadmap.md`). Until backend lands, the
  page may live as static HTML with a no-op success state.
- No tracking pixels. No analytics. No third-party fonts beyond
  Google Fonts (used elsewhere).
- `prefers-reduced-motion`: no animation on the page; nothing to
  reduce.

## Selection style

`::selection { background: var(--ink); color: var(--bg); }` — same
rule as product surfaces. Selection feels like ink on paper.
