# Questions App — MVP v0

Active product spec. This is the single source of truth for what the app does today. Background research lives in `../research/`.

## One-line description

A small offline Flutter app for iOS and Android that shows relationship and conversation prompt cards, one at a time.

## Core flow

```
open app
  → choose deck
  → see one question at a time
  → tap Next to advance
  → finish deck
  → restart, or choose another deck
```

## In scope

- Flutter mobile app for iOS and Android.
- Hardcoded dummy questions in Dart source (`lib/features/questions/question_catalog.dart`).
- Six predefined decks: Shuffle Everything, Warm & Light, Deep Talk, Playful Energy, Relationship Check-in, Intimate.
- Two screens: Deck list, Session.
- Session shuffles its deck once at start; no repeats within a session.
- Finished state with Restart and Choose another deck actions.
- Fixed light Material 3 theme.
- Local widget state + a small pure Dart `QuestionSession` model.
- Unit tests for session/catalog logic; widget tests for app smoke and session flow.

## Out of scope (intentionally not built)

- Backend, database, persistence, JSON asset loading.
- Auth, accounts, profiles, sign-in gates.
- Analytics, crash reporting, push notifications.
- Remote config, remote content updates, feature flags.
- Favorites, history, saved answers, settings screen, dark-mode toggle.
- State-management packages, routing packages, code generation, service locators.

The full Forbidden list lives in `../../.agents/project/scope.md`.

## App identity

- Display name: `Questions`
- Android `applicationId`: `com.macieksitkowski.questionsapp`
- iOS bundle ID: `com.macieksitkowski.questionsapp`
- Version: `1.0.0+1`

## Distribution

- iOS: TestFlight / App Store (or Unlisted) once App Store Connect is set up.
- Android: Google Play internal testing track.

## Source documents

For background and rationale (do not treat as active rules):

- `../research/codex-questions-app-mvp-implementation-plan.md` — implementation plan that produced the current code.
- `../research/minimal-offline-flutter-questions-app-report.md` — long-form research on the architectural choices.
- `../research/flutter-dart-best-practices-pack.md` — general Flutter/Dart best-practices pack used as input to `.agents/skills/flutter/`.
