# Questions

A small offline Flutter app for iOS and Android that shows relationship and conversation prompt cards. Open the app, pick a deck, and tap through one question at a time.

## MVP scope (v0)

- Flutter mobile app for iOS and Android.
- Hardcoded dummy questions (no JSON, no backend).
- Six predefined decks: Shuffle Everything, Warm & Light, Deep Talk, Playful Energy, Relationship Check-in, Intimate.
- Deck selection screen + session screen showing one question at a time.
- Each session shuffles its deck once at start; no question repeats within a session.
- Finished state with restart and choose-another-deck actions.
- Fixed light Material 3 theme.
- Local widget state + a small pure Dart session model (no state management library).

## Explicit non-goals (intentionally not included)

- Backend, database, auth, remote config, remote content updates.
- JSON/asset content loading.
- Favorites, history, saved answers, user profiles, settings screen.
- Push notifications, analytics, crash reporting.
- Dark mode toggle.
- Complex routing or deep links.
- Code generation, service locators, or third-party state libraries.

The catalog is intentionally hardcoded in Dart source code (`lib/features/questions/question_catalog.dart`) using placeholder content suitable for the MVP.

## Project layout

```
lib/
  main.dart
  app/questions_app.dart
  ui/app_theme.dart
  features/
    questions/        # Question + deck models, catalog, filters
    deck_selection/   # Deck list screen + deck card widget
    session/          # Pure Dart session model + session screen + question card
test/
  features/questions/ # Deck catalog and filter tests
  features/session/   # Session logic tests
  widget/             # App smoke + session flow widget tests
```

## Toolchain

This repository pins the Flutter SDK via `.fvmrc`.

If you use [FVM](https://fvm.app) locally:

```bash
fvm install
fvm flutter pub get
fvm flutter analyze
fvm flutter test
```

If you do not use FVM, make sure your installed Flutter version matches `.fvmrc`.

## Validation

Before opening a PR:

```bash
flutter pub get
dart format .
dart format -o none --set-exit-if-changed .
flutter analyze
flutter test --reporter expanded
```

GitHub Actions runs the same validation in `.github/workflows/validate.yml`.

## Run and build (optional)

```bash
flutter run
flutter build appbundle  # Android, requires release signing (see below)
```

> iOS distribution (`flutter build ipa`) is intentionally out of scope for this MVP — codesigning/provisioning is not configured in the repo.

## Android release signing

Android release builds require a real signing key.

1. Copy `android/key.properties.template` to `android/key.properties`.
2. Fill in the real keystore values.
3. Keep `android/key.properties` and the keystore file out of version control (already covered by `.gitignore`).
4. Then run:

```bash
flutter build appbundle --release
```

## App identity

- Display name: `Questions`
- Android `applicationId`: `com.sitek94.questionsapp`
- iOS bundle ID: `com.sitek94.questionsapp`
- Version: `1.0.0+1`

## AI agent instructions

Agent-readable instructions live alongside the code:

- `AGENTS.md` — control plane, required reading order, hard constraints.
- `.agents/project/` — app-specific rules (scope, architecture, testing, review checklist).
- `.agents/skills/flutter/` — reusable Flutter/Dart implementation standards.
- `docs/product/mvp.md` — active product spec.
- `docs/research/` — background research and source material.
