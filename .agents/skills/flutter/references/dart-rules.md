# Dart Rules

Effective Dart first; project-specific rules in `.agents/project/*` win where they conflict.

## Naming

- Files: `lower_snake_case.dart`.
- Types, enums, typedefs, extensions: `UpperCamelCase`.
- Variables, parameters, methods, functions, named constructors: `lowerCamelCase`.
- Avoid vague names: `helper`, `util`, `manager`, `service`, `data`, `info`. Use the actual role (`QuestionSession`, `DeckCatalog`).

## Types and immutability

- Prefer `final` by default; `const` for compile-time constants.
- Be explicit about types on public APIs and on non-obvious declarations. `var` is fine for short, locally-obvious assignments.
- Use `required` named parameters for non-optional inputs.
- Avoid `dynamic`. Reach for it only when interop demands it.
- Prefer immutable model classes (`final` fields, `const` constructors) for data and state snapshots.

## Null safety

- Non-nullable by default. Make a type nullable only when "absent" carries real domain meaning.
- Prefer total functions: validate at boundaries, then operate on non-null values.
- Avoid `!` (bang) operators except where you have already proven non-null in the same scope.

## Async

- Prefer `async` / `await` over raw `.then()` chains.
- Use `Future<void>` for async members that return no value.
- Use `unawaited(...)` to make fire-and-forget explicit and intentional.
- Don't `await` inside tight render paths; precompute and pass values in.

## Errors

- Catch only types you can handle: `on FormatException catch (e)`.
- Don't write empty `catch` blocks. Rethrow when you can't handle.
- Don't use exceptions for control flow.

## Class modifiers

- Use modifiers when they earn their keep:
  - `final class` to forbid subclassing.
  - `sealed class` for finite state hierarchies (e.g. result types, finished/active session states).
  - `base class` to allow extension while preventing implementation.
- Don't sprinkle modifiers reflexively; default to plain classes.

## Imports

- Within the same package, use **relative** imports inside `lib/`.
- Use `package:` imports when crossing package boundaries.
- Never import another package's `lib/src` directly.
- Keep imports at the top of the file; do not use inline / lazy imports.

## Files and libraries

- Prefer many small libraries over a few giant files.
- Avoid `part` / `part of` for ordinary code splitting. Reserve `part` for unavoidable generation workflows.
- One logical concept per file is a good default; one class per file is not a religion.
