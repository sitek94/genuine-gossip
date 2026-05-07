# Architecture

Audience: AI agents working anywhere in this repo.

## Repo philosophy

Polyglot single repo. One git repo for all surfaces of Genuine Gossip
(mobile, marketing, future admin, backend). No workspace tooling
(pnpm/Turbo/Nx) — each `apps/<name>/` is independent. Single repo
chosen because the project is solo-dev and AI-assisted; cross-cutting
concerns (design specs, data contract, agent rules) live at root.

## Top-level layout

```
AGENTS.md                # repo router → apps/<app>/AGENTS.md
CLAUDE.md                # tiny adapter pointing to AGENTS.md
README.md                # short repo readme

.agents/                 # repo-wide AI agent rules (created on demand)
.cursor/rules/           # Cursor adapter, scoped per app via globs
.github/workflows/       # CI

apps/
  mobile/                # Flutter (iOS + Android)
  marketing/             # Astro static site
  admin/                 # future, stack TBD (not Next.js)

supabase/                # backend: migrations, RLS, edge functions
                         # (created when first migration lands)

design/                  # design-related material (brand, tokens,
                         # writing, etc.) — populated incrementally

docs/                    # repo-wide context for agents (this file
                         # lives here)
```

## Per-app stacks

| App | Stack | Notes |
|---|---|---|
| `apps/mobile/` | Flutter / Dart 3 | iOS + Android, Material 3, no state-management package, plain Navigator. See `apps/mobile/AGENTS.md`. |
| `apps/marketing/` | Astro | Static for now: landing, privacy, terms, App Store badges. Waitlist later via Supabase. |
| `apps/admin/` | TBD | Curation/review tool for the solo operator. Decision deferred. Not Next.js. |

## Cross-cutting

- **Backend:** Supabase. Migrations are operational source of truth.
  Edge functions in `supabase/functions/`. `apps/backend/` likely
  never exists — Supabase IS the backend.
- **Data contract:** a design doc / domain model lives in `docs/`
  (file added when first non-trivial schema work begins). Used as
  *input* when designing migrations and client models. Migrations,
  not the contract, are the SoT.
- **Design:** `design/` holds design-related material — tokens,
  brand, typography, writing guidelines. Filled incrementally.
- **Agent rules:** root `AGENTS.md` is a router. Each app has its
  own `apps/<app>/AGENTS.md`. Repo-wide rules (when needed) live in
  root `.agents/`.

## Conventions

- Don't pre-create empty top-level dirs. Add a dir when it has real
  content (`supabase/` on first migration, `design/` on first token
  doc, etc.).
- Don't duplicate rules across files. Each rule has one canonical
  home; everything else is a pointer.
- When adding a new app, mirror the mobile pattern: `apps/<name>/`
  with its own `AGENTS.md`, `CLAUDE.md` (pointer), `.gitignore`.
