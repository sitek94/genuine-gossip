# Anti-Patterns

Refuse these. They violate either project rules in `.agents/project/*` or general Flutter/Dart guidance.

## Architecture

- Widgets calling network, storage, or platform APIs directly. UI talks to a business-logic holder; the holder talks to data.
- Repositories knowing about each other. Combine data in the layer above (notifier / view model / session).
- Inventing a domain layer (use cases, interactors) before there is real domain complexity.
- Adding generic `core/` / `utils/` / `helpers/` / `common/` / `services/` / `managers/` folders.
- Splitting a small app into many Dart packages "for modularity".
- Adding a state-management or routing package without a concrete pain point that justifies it.

## `build()` and rendering

- Creating a `Future` or `Stream` inline inside a `FutureBuilder` / `StreamBuilder` `build()`. It re-runs on every rebuild.
- Performing I/O, parsing, or controller construction in `build()`.
- Storing derived state that could be cheaply computed in `build()`.
- Using helper methods returning `Widget` for genuinely reusable UI; prefer a real widget so `const` and rebuild scoping work.

## State

- Lifting state up "just in case" before two consumers exist.
- Mutating state objects in place where the rest of the app expects immutable snapshots.
- Mixing multiple primary state libraries in the same app.
- Hiding singletons inside `static` fields or service locators that widgets reach into directly.

## Dart style

- Catch-all `try / catch` with no `on` clause and no rethrow.
- Empty `catch` blocks that swallow errors silently.
- Vague names: `helper`, `util`, `manager`, `service`, `data`, `info`, `tmp`.
- Positional boolean parameters (`SomeWidget(true, false)`).
- `dynamic` where a real type is available.
- Inline / lazy imports. Imports stay at the top of the file.

## Process

- Adding code generation by default.
- Adding dependencies without a task that justifies them.
- Duplicating instructions across `AGENTS.md`, `CLAUDE.md`, `.cursor/rules/*`, `README.md`. One canonical location; everything else points at it.
- Silently expanding MVP scope. If a request implies a Forbidden item from `.agents/project/scope.md`, surface it instead of implementing it.
