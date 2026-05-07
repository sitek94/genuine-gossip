# Roadmap

Audience: AI agents. State markers, not deadlines.

States:

- **shipped** — done and live.
- **now** — in progress.
- **next** — committed, starts after current "now" closes.
- **later** — committed in direction, not in scope yet.
- **not committed** — direction noted, no commitment to build.

## Mobile (`apps/mobile/`)

| Item | State |
|---|---|
| Offline Flutter MVP — six decks, hardcoded prompts, two screens | now |
| App Store / Play first release | now |
| Accounts + auth (via Supabase) | later |
| Couples linking | later |
| Paid features (RevenueCat) | later |
| Analytics | later |
| Web version of app | not committed |

## Marketing (`apps/marketing/`)

| Item | State |
|---|---|
| Astro scaffold | shipped |
| Landing page, privacy policy, terms — required for App Store submission | next |
| Waitlist signup (Supabase table + anon-insert RLS) | later |
| Blog | not committed |

> Privacy policy URL must be live before submitting to App Store —
> marketing is therefore on the v1 critical path.

## Backend (`supabase/`)

| Item | State |
|---|---|
| Supabase project + migrations + RLS | later (gated on accounts/auth feature) |
| Edge functions (RevenueCat webhook, etc.) | later |

## Admin (`apps/admin/`)

| Item | State |
|---|---|
| Stack choice (build vs buy: Retool/Forest vs custom) | not committed |
| Curation/review tool for content | later |

## Cross-cutting

| Item | State |
|---|---|
| Design tokens + brand + writing guidelines in `design/` | next |
| Data contract doc in `docs/contract.md` | later (gated on first non-trivial schema) |
| Subdomain plan (`genuinegossip.app` apex, `admin.*`, deep links, Supabase auth redirects) | later (gated on auth or admin) |
| pnpm workspaces for shared TS | not committed (add when admin and marketing actually share code) |
