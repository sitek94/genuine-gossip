# State Management

This project uses **local widget state + a pure Dart session model**. No state-management package. Do not introduce one.

This file documents the decision tree for completeness, so you understand why the project sits where it does and don't drift "upward" without cause.

## Decision order

1. **Local widget state (`StatefulWidget` + `setState`)**
   - Use for ephemeral UI: toggles, selected index, text input, focus, animation coordination.
   - **This project lives here.** All UI state is local; session state lives in a pure Dart `QuestionSession` owned by the session screen.

2. **`InheritedWidget` / `provider`**
   - Consider only when more than one route or feature genuinely needs the same source of truth.
   - Not used here.

3. **Riverpod**
   - Consider for medium apps that want stronger DI, ergonomic async/error/loading handling, and testable state independent of `BuildContext`.
   - Not used here.

4. **Bloc / Cubit**
   - Consider when explicit state transitions and event-driven orchestration carry real weight.
   - Not used here.

## Hard rules for this project

- Do not add Provider, Riverpod, Bloc, GetX, MobX, or any other state-management package.
- Do not add a global "app state" object, singleton, or service locator.
- The selected `DeckDefinition` is passed into the session screen via constructor. That is the integration contract between screens.
- Session mutation is modeled by returning a new `QuestionSession` from `next()` / `restart()`. Do not mutate session fields in place.
- Derived UI state (e.g. progress label) must be derived in `build()` from the session model; do not store what can be cheaply computed.

## If you think you need a library

You don't. Re-read `.agents/project/scope.md`. If the task genuinely cannot be done within the project's constraints, stop and surface it instead of adding a dependency.
