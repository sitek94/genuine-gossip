# Decisions

Audience: AI agents and future-maintainer-self. Short rationale per
decision so we don't re-litigate.

## Repo

- **Single polyglot repo.** Solo dev juggling mobile + marketing +
  future admin + backend. Cross-cutting concerns (design, data
  contract, agent context) need one home. Multi-repo + shared repo
  has higher coordination tax than a single repo.
- **No workspace tooling (pnpm/Turbo/Nx).** Apps are independent
  language ecosystems (Dart, TS) — workspaces buy little. Add pnpm
  workspaces only when admin and marketing actually share TS code.
- **Restructured into `apps/` before v1 release.** Cheapest moment:
  no Fastlane, no TestFlight/Play uploads, no signed builds anchored
  to current paths. After v1 ships, store/CI infra anchors to paths
  and the migration cost rises.

## Backend

- **Supabase.** Solo dev + AI-assisted = leverage on managed
  Postgres + auth + storage. Lock-in is acceptable at this stage;
  do not optimize for migrating off until there is revenue.
- **Migrations are operational SoT.** Auto-generated TS types from
  Supabase CLI. Dart models hand-written or AI-generated from
  schema/PostgREST OpenAPI.
- **Data contract is a design doc, not the SoT.** When a feature
  needs schema, update the contract first as a domain-level design
  artifact, then derive migrations and client models from it (with
  AI help). The contract guides design; migrations enforce
  operation. Doc rot is mitigated by automating contract updates
  via agent hooks (when wired).

## Frontends

- **Mobile = Flutter / Dart.** Already shipping; not changing.
- **Marketing = Astro, static.** Right size for landing + privacy +
  terms + App Store badges. Waitlist later via Supabase (single
  table + anon-insert RLS). No Next.js for marketing — overkill.
- **Admin = TBD, not Next.js.** Decided later. May be a buy
  (Retool/Forest) rather than a build. Until then, `apps/admin/`
  does not exist.

## Agent rules

- **Root `AGENTS.md` is a router.** Per-app `AGENTS.md` carries
  app-specific rules. `.agents/` at root for repo-wide rules (added
  on demand). Cursor rules live at root `.cursor/rules/` with globs
  scoped to `apps/<name>/**`.

## Conventions

- **Don't pre-create empty placeholder dirs.** A dir exists only
  when it has real content. Empty dirs rot and lie.
- **One canonical source per rule.** Adapters (`CLAUDE.md`,
  `.cursor/rules/*`) are pointers, not duplicate content.
