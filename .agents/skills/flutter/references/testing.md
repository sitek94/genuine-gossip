# Testing

Layer tests at the level the problem deserves. Project-specific test conventions in `.agents/project/testing.md` win where they conflict.

## Levels

- **Unit tests** — pure Dart logic: models, session, filters, mappers, validators.
- **Widget tests** — single screens, reusable widgets, error / loading / empty / finished states, navigation triggers, form behavior.
- **Integration tests** — only for genuinely critical end-to-end flows. This project does not have any.

## Patterns

- Use `flutter_test`'s `WidgetTester`. No external test packages.
- Pump with `await tester.pumpWidget(...)`, settle with `await tester.pumpAndSettle()` after animations / navigation.
- Prefer semantic finders: `find.text('Next')`, `find.byType(QuestionCard)`. Use keys only when no semantic finder is clean.
- Assert with `expect(finder, findsOneWidget)` rather than reading widget internals.

## Determinism

- Inject seeded `Random(seed)` into anything that shuffles or samples. Never assert against a real random sequence.
- Don't depend on system time, locale, or platform channels in unit tests.
- For widget tests that exercise async work, drive the clock explicitly with `tester.pump(Duration(...))`.

## Test data

- Build small, named factory helpers for fixtures (`Question fixtureQuestion({String text = 'q'}) => ...`) instead of repeating literal data across tests.
- Keep fixtures next to the tests that use them; avoid a global `test/fixtures/` until there are real cross-feature fixtures.

## What not to test

- Theme constants, color values, text styles.
- Trivial getters or passthrough constructors.
- Implementation details (private fields, internal widget composition).
- Behavior that doesn't exist (don't write tests for Forbidden features).

## Running

```bash
flutter test
```

For a single file:

```bash
flutter test test/features/session/question_session_test.dart
```

Treat warnings from `flutter analyze` as failures unless explicitly justified in the change.
