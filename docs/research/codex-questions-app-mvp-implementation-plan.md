# Codex Implementation Plan: Questions App MVP v0

## 0. Inputs Codex must use

Codex will receive:

1. `Minimal Offline Flutter Questions App Research Report.md`
2. `Flutter and Dart Best Practices Pack.md`
3. This implementation plan

Use them with this authority order:

1. This implementation plan wins for MVP-specific details.
2. The best-practices pack wins for architecture, naming, testing, state, and maintainability.
3. The research report wins for general Flutter setup and distribution context.
4. Do not implement anything outside the MVP scope unless explicitly requested.

Important override: the research report discusses bundled JSON assets. For this new implementation, do **not** use JSON. This is a new clean repository with hardcoded dummy questions in Dart source code.

---

## 1. Product goal

Build a small offline Flutter app for iOS and Android that shows relationship/conversation prompt cards.

Core flow:

```txt
Open app
-> choose deck
-> see one question at a time
-> tap Next to advance
-> finish deck
-> choose another deck or restart
```

The app is intentionally minimal. It is not a quiz app, chat app, journaling app, backend app, or CMS.

---

## 2. MVP v0 scope

Implement only:

- Flutter mobile app for iOS and Android.
- New clean repository.
- Hardcoded dummy questions in Dart source code.
- Fixed light Material 3 theme.
- Deck selection screen.
- Session screen showing one question at a time.
- Predefined deck filters.
- Shuffle selected deck once when session starts.
- No repeated questions within one session.
- Finished state when the selected deck is exhausted.
- Reset/change deck flow.
- Minimal unit and widget tests.

---

## 3. Explicit non-goals

Do **not** implement:

- Backend.
- Database.
- Auth.
- Early-access gate.
- Remote config.
- Remote content updates.
- JSON asset loading.
- Dependency on old repository or old `questions.json`.
- Favorites.
- History.
- Saved answers.
- User profiles.
- Shared state between devices.
- Push notifications.
- Analytics.
- Crash reporting SDKs.
- Dark mode toggle.
- Settings screen.
- Admin/content management.
- Complex routing.
- Deep links.
- State-management library unless the implementation genuinely cannot stay simple without it.
- Code generation.

---

## 4. Default implementation decisions

Use these defaults without asking follow-up questions:

```txt
Project name: questions_app
Display name: Questions
Android application ID: com.macieksitkowski.questionsapp
Apple bundle ID: com.macieksitkowski.questionsapp
Supported platforms: iOS, Android
State management: local StatefulWidget state + pure Dart session model
Routing: plain Navigator.push / Navigator.pop
Data source: hardcoded Dart list
Theme: fixed light Material 3
Animations: AnimatedSwitcher only
Progression: Next button only
Swipe: skip for MVP v0
Persistence: none
Tests: unit + widget smoke tests
Dependencies: default Flutter SDK + flutter_lints only
```

---

## 5. Architecture rules for this MVP

Follow the best-practices pack, but keep the app smaller than a production template.

### Use

- Feature-first structure.
- Small pure Dart models for app logic.
- Local widget state for session UI.
- Constructor parameters for dependencies/data.
- Pure widgets for reusable UI.
- `const` constructors where possible.
- Meaningful names.
- Dart naming conventions.
- Material 3 theme from app root.

### Avoid

- `lib/utils/`, `lib/helpers/`, `lib/common/` dumping grounds.
- Clean architecture boilerplate.
- Abstract repositories for hardcoded local data.
- Service locator.
- Global mutable state.
- Provider/Riverpod/Bloc for this tiny MVP.
- Generated code.
- Parsing or async work in `build()`.
- Large screen files with all widgets inline.

---

## 6. Repository bootstrap

### If creating the Flutter project from outside the repo

```bash
flutter create --empty --platforms=ios,android --org com.macieksitkowski questions_app
cd questions_app
```

### If Codex is already inside an empty repo root

Use this only if the repo directory name is Dart-valid, for example `questions_app`:

```bash
flutter create --empty --platforms=ios,android --org com.macieksitkowski .
```

If the current directory name is not a valid Dart package name, create the Flutter project in a temp directory and move generated files into the repo root.

### After project creation

Run:

```bash
flutter --version
flutter pub get
flutter analyze
flutter test
```

Expected initial tests may be empty depending on the `--empty` template. Continue after confirming the generated project is valid.

---

## 7. Dependency policy

Keep `pubspec.yaml` minimal.

Allowed dependencies:

```yaml
dependencies:
  flutter:
    sdk: flutter

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: any
```

Do not add:

- `provider`
- `flutter_riverpod`
- `bloc` / `flutter_bloc`
- `go_router`
- `freezed`
- `json_serializable`
- `equatable`
- HTTP clients
- storage packages
- analytics packages

Add a dependency only if a task becomes impossible with Flutter SDK APIs. For this MVP, it should not be necessary.

---

## 8. Target file structure

Implement this structure:

```txt
lib/
  main.dart
  app/
    questions_app.dart
  ui/
    app_theme.dart
  features/
    questions/
      question.dart
      question_catalog.dart
      deck_definition.dart
      deck_catalog.dart
    deck_selection/
      deck_list_screen.dart
      deck_card.dart
    session/
      question_session.dart
      session_screen.dart
      question_card.dart

test/
  features/
    questions/
      deck_catalog_test.dart
    session/
      question_session_test.dart
  widget/
    app_smoke_test.dart
    session_flow_test.dart

README.md
analysis_options.yaml
pubspec.yaml
```

Do not create extra folders unless a file would otherwise become too large.

---

## 9. Domain model

### `lib/features/questions/question.dart`

Create typed models and enums.

Required enums:

```dart
enum QuestionTopic {
  connection,
  communication,
  fun,
  future,
  values,
  lifestyle,
  intimacy,
}

enum QuestionVibe {
  playful,
  reflective,
  deep,
  flirty,
}

enum QuestionExplicitness {
  none,
  suggestive,
  sexual,
}

enum QuestionFormat {
  question,
  prompt,
  challenge,
}
```

Required model shape:

```dart
final class Question {
  const Question({
    required this.id,
    required this.text,
    required this.topic,
    required this.vibe,
    required this.explicitness,
    required this.format,
  });

  final String id;
  final String text;
  final QuestionTopic topic;
  final QuestionVibe vibe;
  final QuestionExplicitness explicitness;
  final QuestionFormat format;
}
```

Rules:

- Use `final class` unless analysis/lints object.
- Keep fields immutable.
- No JSON methods.
- No `copyWith` unless actually needed.
- No equality package.

---

## 10. Hardcoded dummy data

### `lib/features/questions/question_catalog.dart`

Create a hardcoded list:

```dart
const questionCatalog = <Question>[
  // dummy questions
];
```

Requirements:

- At least 24 dummy questions.
- Every question has a stable ID like `q_001`.
- Every deck must match at least 2 questions.
- Use placeholder/dummy but product-realistic question text.
- Keep explicit content mild for MVP. It is okay to include `intimacy` and `suggestive`; avoid graphic sexual text.
- No old repo dependency.
- No JSON file.
- No asset declaration.

Suggested distribution:

```txt
connection: 4+
communication: 4+
fun: 4+
future: 3+
values: 3+
lifestyle: 3+
intimacy: 4+

playful: 5+
reflective: 6+
deep: 5+
flirty: 3+

explicitness.none: most questions
explicitness.suggestive: some intimacy questions
explicitness.sexual: optional; preferably skip in dummy MVP content
```

---

## 11. Deck definitions

### `lib/features/questions/deck_definition.dart`

Create deck model.

Required deck IDs:

```dart
enum DeckId {
  shuffleEverything,
  warmLight,
  deepTalk,
  playfulEnergy,
  relationshipCheckIn,
  intimate,
}
```

Required deck model fields:

```dart
final class DeckDefinition {
  const DeckDefinition({
    required this.id,
    required this.title,
    required this.description,
  });

  final DeckId id;
  final String title;
  final String description;

  bool matches(Question question) {
    // switch by id
  }
}
```

Deck matching rules:

```txt
Shuffle Everything:
  all questions

Warm & Light:
  explicitness == none
  AND vibe is playful OR reflective

Deep Talk:
  vibe == deep

Playful Energy:
  vibe == playful

Relationship Check-in:
  explicitness == none
  AND topic in connection, communication, future, lifestyle, values

Intimate:
  topic == intimacy
```

### `lib/features/questions/deck_catalog.dart`

Create:

```dart
const deckCatalog = <DeckDefinition>[
  // six decks above
];

List<Question> questionsForDeck(DeckDefinition deck) {
  return questionCatalog.where(deck.matches).toList(growable: false);
}
```

Rules:

- Keep deck titles/descriptions in one authoritative place.
- Do not duplicate deck filtering logic in UI.
- Unit-test each deck has at least one matching question; preferably at least two.

---

## 12. Session logic

### `lib/features/session/question_session.dart`

Create a pure Dart session model. This is the most important logic in the app.

Required behavior:

- Start session from selected deck and its matching questions.
- Copy the matching questions into a new list.
- Shuffle exactly once at session creation.
- Store shuffled order in memory.
- Track current index.
- Expose current question.
- Advance with `next()`.
- Finish when current index reaches list length.
- Do not reshuffle on widget rebuild.
- Do not persist anything.

Recommended shape:

```dart
final class QuestionSession {
  factory QuestionSession.start({
    required DeckDefinition deck,
    required List<Question> questions,
    Random? random,
  }) {
    final shuffledQuestions = List<Question>.of(questions)..shuffle(random);
    return QuestionSession._(
      deck: deck,
      questions: List.unmodifiable(shuffledQuestions),
      currentIndex: 0,
    );
  }

  const QuestionSession._({
    required this.deck,
    required this.questions,
    required this.currentIndex,
  });

  final DeckDefinition deck;
  final List<Question> questions;
  final int currentIndex;

  bool get isEmpty;
  bool get isFinished;
  Question? get currentQuestion;
  int get totalCount;
  int get completedCount;

  QuestionSession next();
  QuestionSession restart({Random? random});
}
```

Implementation notes:

- `isFinished` should be true when `questions.isEmpty` or `currentIndex >= questions.length`.
- `currentQuestion` should be null when finished.
- `next()` should return `this` when already finished.
- `completedCount` should not exceed `totalCount`.
- `restart()` should reshuffle the same session’s deck questions if implemented. If this complicates code, handle restart from the screen by creating a new session from `questionsForDeck(deck)`.

Testing requirements:

- Starting session preserves all selected questions.
- Shuffled session contains no duplicate IDs.
- Repeated `next()` eventually reaches finished state.
- `next()` after finished is safe.
- Empty deck input produces finished/empty state.

---

## 13. App bootstrap and theme

### `lib/main.dart`

Keep this tiny:

```dart
import 'package:flutter/material.dart';
import 'app/questions_app.dart';

void main() {
  runApp(const QuestionsApp());
}
```

### `lib/app/questions_app.dart`

Create root `MaterialApp`.

Requirements:

- `debugShowCheckedModeBanner: false`
- `theme: buildAppTheme()`
- `themeMode: ThemeMode.light`
- `home: const DeckListScreen()`
- No named routes.
- No router package.

### `lib/ui/app_theme.dart`

Create a simple Material 3 light theme.

Requirements:

- Use `ThemeData(useMaterial3: true)`.
- Use `ColorScheme.fromSeed(...)`.
- Keep styling centralized.
- Do not add dark theme.
- Avoid excessive custom design work.

---

## 14. Deck selection UI

### `lib/features/deck_selection/deck_list_screen.dart`

Screen requirements:

- Shows app title.
- Shows all six decks.
- Each deck item shows title and description.
- Tapping a deck starts a new session.
- Uses `Navigator.push` with `MaterialPageRoute`.
- Passes the selected `DeckDefinition` into `SessionScreen`.
- Does not create global state.

Recommended behavior on tap:

```dart
final questions = questionsForDeck(deck);
Navigator.of(context).push(
  MaterialPageRoute<void>(
    builder: (_) => SessionScreen(
      deck: deck,
      questions: questions,
    ),
  ),
);
```

### `lib/features/deck_selection/deck_card.dart`

Create a small reusable widget for one deck row/card.

Requirements:

- Stateless.
- Receives title, description, and callback.
- Uses Material components, for example `Card`, `InkWell`, `ListTile`.
- Does not know about question filtering.

---

## 15. Session UI

### `lib/features/session/session_screen.dart`

Screen requirements:

- StatefulWidget is acceptable and expected.
- Create `QuestionSession` once in `initState`.
- Do not create or shuffle the session in `build()`.
- Shows selected deck title.
- Shows progress, for example `3 / 12`.
- Shows one question card when session is active.
- Shows finished state when exhausted.
- Has `Next` button while active.
- Has `Choose another deck` button in active and finished states.
- Has `Restart deck` button in finished state.
- Back navigation should work normally.

State rules:

- State owner: `SessionScreen` only.
- Store one `_session` field.
- On `Next`, call `setState(() => _session = _session.next())`.
- On restart, create a new session from the same original `questions` list.
- Do not use global state.
- Do not persist session.

### `lib/features/session/question_card.dart`

Requirements:

- Stateless.
- Receives a `Question`.
- Displays the question text only, plus optional small metadata if useful.
- No business logic.
- Use `AnimatedSwitcher` in the parent or inside this widget to animate question changes.
- Key the animated child by question ID so transitions actually happen.

Recommended animation:

```dart
AnimatedSwitcher(
  duration: const Duration(milliseconds: 180),
  child: QuestionCard(
    key: ValueKey(question.id),
    question: question,
  ),
)
```

Do not implement complex swipe physics for MVP v0.

---

## 16. Error and empty states

Even with hardcoded data, handle safe states.

Required states:

```txt
Deck has questions:
  show session normally

Deck has no questions:
  show empty state with button to choose another deck

Session finished:
  show finished message with restart and choose-another-deck actions
```

Do not throw from UI for empty lists. Unit tests should cover empty input to `QuestionSession.start`.

---

## 17. Testing plan

Use only `flutter_test` and Dart test APIs available through Flutter.

### `test/features/questions/deck_catalog_test.dart`

Test:

- `deckCatalog` contains exactly six decks.
- Deck IDs are unique.
- Question IDs are unique.
- Each deck returns at least two questions from dummy catalog.
- Warm & Light filter excludes suggestive/sexual questions.
- Intimate filter only returns `QuestionTopic.intimacy`.

### `test/features/session/question_session_test.dart`

Test:

- Start session contains all provided questions.
- Shuffled questions have same IDs as input.
- `currentQuestion` is initially non-null for non-empty input.
- Calling `next()` advances progress.
- Advancing through all questions reaches `isFinished == true`.
- No question ID appears twice in the session order.
- Empty input starts finished.
- Calling `next()` after finished does not crash and remains finished.

Use deterministic `Random(1)` where order-specific assertions are needed.

### `test/widget/app_smoke_test.dart`

Test:

- App builds.
- App title is visible.
- All six deck titles are visible.

### `test/widget/session_flow_test.dart`

Test:

- Tap one deck.
- Session screen opens.
- A question card appears.
- Tap `Next`.
- Progress changes.
- Repeatedly tap `Next` until finished.
- Finished message appears.
- Tap `Choose another deck`.
- Deck list appears again.

Widget-test implementation notes:

- Use stable visible text or keys for important controls.
- Prefer button text like `Next`, `Restart deck`, `Choose another deck`.
- Use `await tester.pumpAndSettle()` after navigation and animation.

---

## 18. Implementation phases

### Phase 1: Create clean Flutter app

Tasks:

1. Run `flutter create`.
2. Confirm package name is `questions_app`.
3. Confirm iOS and Android platforms exist.
4. Replace generated starter with minimal app skeleton.
5. Run validation commands.

Commands:

```bash
flutter pub get
dart format .
flutter analyze
flutter test
```

Done when:

- Project opens as a Flutter app.
- `flutter analyze` passes.
- `flutter test` passes or reports no meaningful tests yet.

### Phase 2: Add app shell and theme

Tasks:

1. Create `lib/app/questions_app.dart`.
2. Create `lib/ui/app_theme.dart`.
3. Keep `main.dart` minimal.
4. Set `home` to a temporary placeholder or directly to `DeckListScreen` after Phase 4.

Done when:

- App starts with Material 3 light theme.
- No dark mode or settings exist.

### Phase 3: Add question and deck model

Tasks:

1. Create `question.dart`.
2. Create `question_catalog.dart` with dummy questions.
3. Create `deck_definition.dart` with matching rules.
4. Create `deck_catalog.dart`.
5. Add unit tests for catalog/filter rules.

Commands:

```bash
dart format .
flutter analyze
flutter test test/features/questions/deck_catalog_test.dart
```

Done when:

- All decks match dummy questions.
- No duplicate IDs.
- No UI depends on duplicated deck logic.

### Phase 4: Add deck selection screen

Tasks:

1. Create `deck_list_screen.dart`.
2. Create `deck_card.dart`.
3. Wire `QuestionsApp.home` to `DeckListScreen`.
4. Render all deck cards from `deckCatalog`.
5. Add tap handler, but session screen can be temporary if not implemented yet.

Done when:

- App shows all six decks.
- Deck card widget is small and presentation-only.

### Phase 5: Add session logic

Tasks:

1. Create `question_session.dart`.
2. Implement shuffle-once session creation.
3. Implement `next()` and finished state.
4. Add unit tests.

Commands:

```bash
dart format .
flutter analyze
flutter test test/features/session/question_session_test.dart
```

Done when:

- Session tests pass.
- No shuffle occurs inside UI `build()`.

### Phase 6: Add session screen

Tasks:

1. Create `session_screen.dart`.
2. Create `question_card.dart`.
3. In `SessionScreen.initState`, create session once.
4. Add progress text.
5. Add `Next` action.
6. Add finished state.
7. Add restart action.
8. Add choose-another-deck action via `Navigator.pop`.
9. Add simple `AnimatedSwitcher` for question changes.

Done when:

- Deck tap opens session.
- Next advances cards.
- Finished state appears.
- Restart works.
- Back/choose another deck returns to deck list.

### Phase 7: Add widget tests

Tasks:

1. Add app smoke test.
2. Add session flow test.
3. Use stable button text or keys.
4. Keep tests behavior-focused.

Commands:

```bash
dart format .
flutter analyze
flutter test
```

Done when:

- All unit and widget tests pass.

### Phase 8: Clean metadata and README

Tasks:

1. Ensure display name is `Questions` or `Questions App`.
2. Ensure app identifiers are placeholders or set to `com.macieksitkowski.questionsapp`.
3. Set `version: 1.0.0+1` in `pubspec.yaml`.
4. Write `README.md` with:
   - app purpose
   - MVP scope
   - commands
   - explicit non-goals
   - note that questions are hardcoded dummy data

README commands section:

```bash
flutter pub get
dart format .
flutter analyze
flutter test
flutter run
flutter build appbundle
flutter build ipa
```

Do not include backend setup instructions.

### Phase 9: Final validation

Run:

```bash
dart format .
flutter analyze
flutter test
flutter build apk --debug
```

If running on macOS with Xcode installed, also run:

```bash
flutter build ios --debug --no-codesign
```

For release artifacts, do not attempt signing unless credentials are already configured. Mention release build commands in the final summary instead.

---

## 19. Required final validation output from Codex

After implementation, Codex should report:

```txt
Summary:
- What was implemented

Files changed:
- Key files and purpose

Validation:
- dart format .
- flutter analyze
- flutter test
- flutter build apk --debug
- flutter build ios --debug --no-codesign, if run

Known limitations:
- Hardcoded dummy questions
- No persistence
- No backend
- No store signing configured unless done manually
```

If a command cannot run due to environment limitations, Codex should state the exact limitation and still run every available validation command.

---

## 20. Acceptance criteria

Implementation is complete when all are true:

- App is a clean Flutter project.
- App has no dependency on the old repo.
- Questions are hardcoded in Dart source code.
- No JSON file is required.
- No backend/auth/storage/analytics dependency exists.
- App starts directly at deck selection.
- Six predefined decks are visible.
- Selecting a deck starts a question session.
- Session order is shuffled once at start.
- Rebuilding UI does not reshuffle.
- A question never repeats within a session.
- `Next` advances one card.
- Finished state appears after final card.
- User can restart deck.
- User can return to deck list.
- App uses fixed light Material 3 theme.
- Unit tests cover deck filters and session logic.
- Widget tests cover deck list and session flow.
- `dart format .`, `flutter analyze`, and `flutter test` pass.

---

## 21. Anti-pattern checklist

Before finishing, verify Codex did **not** add:

- `provider`, `riverpod`, `bloc`, or other state library.
- `go_router` or named-route maps.
- `assets/questions.json` or any JSON parsing.
- `lib/utils` / `lib/helpers` dumping ground.
- A domain/use-case layer for no reason.
- Service locator.
- Singleton mutable app state.
- Generated files.
- Backend placeholder code.
- TODOs for future features.
- Manual answer entry or answer persistence.
- Favorites/history/settings/auth.

---

## 22. Notes for future versions, not MVP v0

These are intentionally out of scope now:

- Replace dummy hardcoded questions with curated content.
- Move questions into JSON asset or remote source.
- Add favorites.
- Add persistence with local storage.
- Add backend sync.
- Add app-store screenshots/metadata.
- Add Android Play internal testing release config.
- Add iOS App Store / unlisted release flow.
- Add stricter lint pack such as `very_good_analysis`.
- Add Riverpod/Provider/Bloc if shared state grows.

Do not implement any of the above in MVP v0.
