---
name: flutter
description: Flutter and Dart implementation standards for small to medium Flutter apps. Use when creating, editing, reviewing, or refactoring Flutter/Dart code, widgets, routing, state management, tests, forms, async flows, project structure, or architecture decisions.
---

# Flutter Skill

Use this skill whenever you write or modify Flutter/Dart code in this repository. It encodes a small, opinionated, official-docs-aligned default. Project-specific rules in `.agents/project/*` always override this skill where they conflict.

## Default rules

- Prefer the simplest sufficient solution.
- Keep state ownership obvious. One owner per piece of state.
- Prefer local `StatefulWidget` state when state is local to one screen or widget.
- Separate UI from business/session logic. Widgets render; pure Dart objects decide.
- Keep reusable, cross-feature widgets in `lib/ui/`. Keep feature-specific widgets inside the feature.
- Avoid generated code unless it clearly reduces risk or boilerplate.
- Avoid new dependencies unless current scope demands them.
- Prefer composition over inheritance.
- Prefer small widgets and pure Dart functions over giant `build()` methods.
- Keep `build()` pure: no I/O, no future creation, no controller construction.
- Prefer `const` constructors wherever values are compile-time constant.
- Prefer named parameters with `required` over positional booleans / multi-arg positional lists.

## Material 3 + theming

- Material 3 is the default. Use `ThemeData`, `ColorScheme`, and component themes.
- Reach for theme tokens (`Theme.of(context).colorScheme.primary`, `textTheme.bodyMedium`) instead of hardcoding colors and text styles.

## Async

- Prefer `async` / `await`.
- Never create a `Future` or `Stream` inline in a `build()` for `FutureBuilder` / `StreamBuilder`. Obtain it from state setup or injected logic.
- Mark intentional fire-and-forget with `unawaited()`.

## Tests

- Unit-test logic-bearing pure Dart classes.
- Widget-test screens and reusable widgets.
- Reserve integration tests for genuinely critical end-to-end flows.

## Read deeper references on demand

Load these only when the task touches the topic:

- Dart conventions: `references/dart-rules.md`
- Widgets and UI composition: `references/widgets-and-ui.md`
- State management decision tree: `references/state-management.md`
- Testing patterns: `references/testing.md`
- Anti-patterns to refuse: `references/anti-patterns.md`

## Refusal cases

If a task implies any of the following without explicit user instruction, push back instead of implementing:

- Adding a state-management or routing package.
- Adding code generation or service locators.
- Introducing top-level `core/` / `utils/` / `helpers/` / `managers/` folders.
- Adding network, persistence, or platform-channel work to a project that does not currently have it.
- Replacing local widget state with global state "for future use".
