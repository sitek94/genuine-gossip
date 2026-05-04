# AGENTS.md

Control plane for AI coding agents working on this repository. Keep this file short. Deeper rules live under `.agents/` and source material lives under `docs/`.

## Project identity

- **Name:** Questions
- **What:** Minimal offline Flutter app (iOS + Android) that shows relationship and conversation prompt cards, one at a time.
- **Stack:** Flutter (Dart 3.6+), Material 3, no backend, no persistence, no third-party state library.
- **Status:** MVP v0. Intentionally tiny. Do not expand scope.

## Required reading

Before editing any code in this repo, read these in order:

1. `.agents/project/scope.md` — what's in/out of MVP v0.
2. `.agents/project/architecture.md` — folder layout and architectural rules.
3. `.agents/skills/flutter/SKILL.md` — Flutter/Dart implementation defaults.

For tests, additionally read:

- `.agents/project/testing.md`
- `.agents/skills/flutter/references/testing.md`

For code review or pre-merge checks, read:

- `.agents/project/review-checklist.md`

Read deeper `.agents/skills/flutter/references/*` files only when the task touches that area.

## Priority order

When sources conflict, higher wins:

1. The user's explicit task in this session.
2. `.agents/project/*` (project law).
3. `.agents/skills/flutter/*` (reusable Flutter law).
4. `docs/product/*` (product spec, MVP definition).
5. `docs/research/*` (background research; reference only, not active rules).

## Hard constraints

- Do not expand MVP scope unless explicitly requested. See `.agents/project/scope.md`.
- Do not add backend, database, persistence, JSON asset loading, auth, analytics, remote config, push notifications, or crash reporting.
- Do not add a state-management package (Provider, Riverpod, Bloc, etc.). Local widget state + a pure Dart session model is the contract.
- Do not add a routing package (`go_router` etc.). Use plain `Navigator`.
- Do not add code generation, service locators, or `core/` / `utils/` / `helpers/` / `managers/` folders.
- Do not add new dependencies without a task that justifies them.
- Do not duplicate rules across multiple agent files. This file plus `.agents/` is canonical; any tool-specific adapters (e.g. `CLAUDE.md`, `.cursor/rules/*`) must be tiny pointers.

## Validation commands

Run after any non-trivial change:

```bash
dart format .
flutter analyze
flutter test
```

Build smoke commands (do not run unless the task requires them):

```bash
flutter pub get
flutter build appbundle
flutter build ipa
```

## Where deeper rules live

```
AGENTS.md                              # this file (control plane)
.agents/
  README.md                            # how this directory is organized
  project/                             # app-specific rules (project law)
    scope.md
    architecture.md
    testing.md
    review-checklist.md
  skills/
    flutter/                           # reusable Flutter/Dart rules
      SKILL.md
      references/
        dart-rules.md
        state-management.md
        widgets-and-ui.md
        testing.md
        anti-patterns.md
docs/
  product/                             # active product spec
    mvp.md
  research/                            # background research, source archive
    flutter-dart-best-practices-pack.md
    minimal-offline-flutter-questions-app-report.md
    codex-questions-app-mvp-implementation-plan.md
```

## Adapter files

Tool-specific adapter files are tiny pointers to this control plane. They MUST NOT duplicate rules.

- `CLAUDE.md` — Claude Code adapter; points here and to `.agents/skills/flutter/SKILL.md`.
- `.cursor/rules/flutter.mdc` — Cursor rule with `alwaysApply: true` and a `**/*.dart` glob; points here and to the project + skill files.

If you add another adapter (e.g. for a new agent tool), keep it tiny and reference this file. There is one canonical instruction set: this one.
