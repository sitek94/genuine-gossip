# Design System

Source: Design System (Typographic) v0.1 (May 2026).

The product is a single card held between two people. Type does the
work. The interface stays out of the way.

## Principles

1. **Text is the product.** Every prompt has been written, edited, and
   re-edited. Treat that work like a poem on a wall — frame it, don't
   decorate it. The card screen is mostly empty on purpose.
2. **Quiet beats clever.** No micro-interactions for their own sake.
   No gradient flourishes. No mascot, no emoji, no ornament.
3. **One typeface, two voices.** Cormorant Garamond carries every
   reading moment. Inter Tight handles labels, status, navigation.
   Italics carry warmth — use them.
4. **Hide the chrome.** The card screen has one labelled control —
   `tap for next`. Everything else (change deck, restart) hides at
   the edges and reveals on dwell. Reading first.
5. **Light and dark are equal.** Not dark-mode-as-skin. Both modes are
   designed; both are tested with real card text. Dark mode is for
   couches and beds.
6. **If in doubt, take it out.** The pull is always toward more —
   resist. The product is a single sentence and the room around it.

## Typography

Two faces. That's enough.

### Display — Cormorant Garamond

- Source: Google Fonts (free, OFL).
- Weights: **300 Light**, **400 Regular**.
- Styles: Roman + Italic (both essential).
- Used for: card text, headlines, deck names, end states.
- Tracking: −2.5px @ 96px → −0.2px @ 24px (loosens as size shrinks).

### Sans — Inter Tight

- Source: Google Fonts (free, OFL).
- Weights: **400 Regular**, **500 Medium**.
- Used for: labels, counters, status, buttons.
- House style: UPPERCASE with letter-spacing only — never sentence-case
  sans in body. That's the serif's job.

### Mono — JetBrains Mono

- Source: Google Fonts (free, OFL).
- Weights: 400 (system docs use 300/400/500 in specimens).
- Used for: small UI metadata in design specs and brand book layouts.
  Optional in product surfaces.

### Type scale

| Token | Px | Line-height | Tracking | Style | Use |
|---|---|---|---|---|---|
| `D1` Hero | 96 | 0.9 | −2.5 | Cormorant Light 300 | Hero / wordmark scale |
| `D2` Card | 42 | 1.05 | −0.8 | Cormorant Light 300, italic-mix | The card prompt itself (scales 38–46 by viewport, 30 inside the iPhone safe area in the anatomy spec) |
| `D3` Deck | 26 | 1.0 | −0.5 | Cormorant Light 300, italic for active | Deck-picker rows |
| `D4` Lede | 22 | 1.4 | — | Cormorant Italic 300 | Soft secondary copy, italic buttons |
| `S1` Body | 15 | 1.55 | — | Inter Tight 400 | Body copy (rare; settings, errors, early-access notice) |
| `S2` Action | 12 | — | +1.6 | Inter Tight 500, UPPER | The single primary button |
| `S3` Label | 10 | — | +2.0 | Inter Tight 400, UPPER | Status meta, deck labels, position counters |

### House rule — italic

Italic carries the human. Use it for the warm word in a sentence
(*truly*, *us*, *together*) — never for emphasis on a verb of
navigation.

## Color tokens

There is no brand color inside the product. Color is a distraction
from the words. The single ink earns every place it lands.

### Light · Bone

| Token | Hex | Use |
|---|---|---|
| `bg` (Bone) | `#F7F6F3` | Page background |
| `paper` | `#FFFFFF` | Cards / elevated surfaces |
| `ink` | `#0E0D0B` | Text, the single button |
| `ink-soft` | `#797673` | Secondary text, status meta |
| `ink-faint` | `#B8B6B2` | Tertiary / disabled |
| `hairline` | `rgba(14,13,11,0.12)` | Default rule |
| `hairline-strong` | `rgba(14,13,11,0.22)` | Emphasized rule (e.g. unplayed ruler ticks) |

### Dark · Bedroom

| Token | Hex | Use |
|---|---|---|
| `d-bg` | `#0E0D0B` | Page background |
| `d-paper` | `#1A1917` | Cards / elevated surfaces |
| `d-ink` | `#F7F6F3` | Text, the single button |
| `d-ink-soft` | `#8B8886` | Secondary text |
| `d-ink-faint` | `#4A4946` | Tertiary / disabled |
| `d-hairline` | `rgba(247,246,243,0.14)` | Default rule |
| `d-hairline-strong` | `rgba(247,246,243,0.28)` | Emphasized rule |

### Allowed / disallowed

**Allowed:** bone (surface) · ink (text + the single button) · three
soft greys (hierarchy alone).

**Disallowed in-product:** brand accents · per-deck color coding ·
semantic red/green/amber · gradients · shadows over 8px blur.

### Contrast

- Light: ink on bone 15.8:1 (AAA), ink-soft on bone 5.4:1 (AA large).
- Dark: d-ink on d-bg 15.8:1 (AAA), d-ink-soft on d-bg 5.0:1 (AA large).

## Space scale

4-base, near-geometric. Use the large end liberally — the silence
around a card is part of what the card means.

| Token | Px |
|---|---|
| `s-1` | 4 |
| `s-2` | 8 |
| `s-3` | 12 |
| `s-4` | 16 |
| `s-5` | 24 |
| `s-6` | 32 |
| `s-7` | 48 |
| `s-8` | 64 |
| `s-9` | 96 |
| `s-10` | 144 |

### Page rhythm

- Phone gutters: `22px` horizontal.
- Top safe-area inset: `46px`.
- Card text inset (T R B L): `84 / 22 / 110 / 22`. Prompt is vertically
  centered with breathing room above and below the controls.
- Tap targets: 44 × 44 px minimum. Exception: the entire card screen
  is the tap target for "next." Edge handles for change/restart are
  56 px wide and reveal on dwell.

## Components

Six. Anything not on this list needs an argument before it's added.

### 1. Button · Primary

The committing action. At most one on screen. Outlined; ink on bone,
fills on press.

- Type: `S2` Action / 12px / 500 / UPPER / +1.6 letter-spacing.
- Size: height 44 · padding 12·22.
- Border: 1px ink.
- Hover: fill ink, text bone, 150ms.
- Press: opacity 0.85, no scale.

### 2. Button · Italic

The continuing action. Used at end-of-deck and inline. Reads like a
sentence, not a button.

- Type: `D4` Italic / 22px / 300 / italic.
- Hit area: full text + 8px halo.
- Hover: underline 1px (`text-underline-offset: 4px`).
- Use: continuations, low-stakes nav.
- The trailing arrow (→) stays roman so it doesn't lean.

### 3. Field · Hairline

The only input in the app — the access key on the gate. No box, no
rounded corners. A single ink line and a label.

- Type: `D2` / 28px / 300 / +8 letter-spacing.
- Underline: 1px ink (always; no focus ring).
- Label: `S3`, right-aligned (e.g. `KEY`).
- Caret: system caret, ink color.
- Error: label flips to italic copy (e.g. *not this one. try again.*).

### 4. Deck row

List item for the deck picker. Hairline-separated, all-lowercase
serif. Active row goes italic, gains the arrow; inactive rows go
ink-soft.

- Type: `D3` / 26px / 300 / lowercase.
- Active: italic + ink + trailing arrow.
- Inactive: ink-soft, no arrow.
- Index: `S3`, 18px width, mono-aligned (e.g. `02`).
- Padding: 12 / 0 (top/bottom of row).
- Tap target: full row, 44px min height.

### 5. Progress · Ruler

Deck-progress indicator. One tick per card; played cards rise to 10px,
unplayed sit at 1px. No counters, no percentages — the eye reads it
immediately.

- Played: 10px ink bar.
- Unplayed: 1px hairline-strong.
- Gap between ticks: 3px.
- Width: fills card gutter (`calc(100% − 44)`).
- Animation: height 1 → 10px, 240ms ease-out, on advance.

### 6. Status meta

The single header bar across every screen — context on the left,
position on the right. Always in soft grey, always at the very top
edge of the safe area.

- Type: `S3` / 10px / 400 / +2 letter-spacing / UPPER.
- Color: ink-soft.
- Position: top: 46px (safe-inset).
- Numbers: tabular-nums always (e.g. `05 / 14`).

## Motion

Slow. Honest. Default to under-doing it — a card change is a fade and
a half-second, not a flick.

| Use | Duration |
|---|---|
| State changes (button hover, ruler tick) | 240ms |
| Card advance | 380ms |
| Screen-to-screen | 600ms |

- Easing: `cubic-bezier(.2, .7, .2, 1)` — decelerating ease for
  everything. No bounce, no overshoot, no spring. The product never
  *arrives*; it settles.
- Card transition: **crossfade only**. New card cross-fades over the
  old at 380ms. No horizontal motion — the card is a held object,
  not a swiped page.
- `prefers-reduced-motion`: drop all transitions to opacity-only fades
  at 120ms. The product still changes states, just instantly.
- Haptics: a single soft haptic on card advance. Nothing on deck pick,
  nothing on gate enter. The product never buzzes for confirmation.

## Card-screen anatomy

Every fixed measurement in the entire app comes back to this one
screen. Get this right and the rest of the system follows.

```
┌──────────────────────────────────────┐
│ [system status bar]                  │
│                                      │
│ a · status meta (deck · position)    │  ← top: 46px
│                                      │
│                                      │
│        b · card text · D2            │  ← inset 84 top, 110 bottom
│        Cormorant 300, ~30–46px       │     vertically centered
│        italics carry warmth          │
│                                      │
│                                      │
│ c · progress ruler                   │  ← bottom: 56px
│ d · ⟵ change      TAP FOR NEXT       │  ← bottom: 28px
└──────────────────────────────────────┘
```

| Anchor | Element | Notes |
|---|---|---|
| a | Status meta | Deck name + position. `S3` label, top: 46px. |
| b | Card text | `D2` (42px iPhone, scales 38–46 by viewport, ~30px inside the safe-area on small phones). Top inset 84, bottom 110. Vertically centered. Italics carry warmth. |
| c | Progress ruler | Played: 10px ink. Unplayed: 1px hairline-strong. 56px from bottom edge. |
| d | Affordances row | Left: change deck (soft `S3`). Center: `TAP FOR NEXT` (ink — the only labeled control). Right: reserved for restart, hidden until completion. |
| e | Tap target | The entire screen above the affordances row advances. Single biggest hit area in the app — by design. |
