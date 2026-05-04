# Widgets and UI

## Composition

- Build screens by composing small widgets.
- Prefer **widgets** (not helper methods returning `Widget`) when extracting reusable UI. A widget gets its own element, can be `const`, and rebuilds independently.
- Prefer `StatelessWidget` unless local mutable state is genuinely needed.
- Use `const` constructors wherever the constructor arguments are compile-time constant. This is the cheapest performance win in Flutter.

## `build()` discipline

- `build()` must be pure and side-effect-free.
- Do not perform I/O, parse data, create futures/streams, or instantiate controllers in `build()`.
- Move expensive computation out of `build()` (precompute in `initState`, in a notifier, or pass it in).

## Layout

- Reach for higher-level widgets first: `ListTile`, `ListView`, `GridView`, `Wrap`. Drop down to `Row` / `Column` / custom layouts only when needed.
- Use lazy builders (`ListView.builder`, `GridView.builder`, `SliverList`) for non-trivial collections.
- Avoid intrinsic-size measurement (`IntrinsicHeight`, `IntrinsicWidth`) unless layout truly needs it.

## Theming

- Drive styling from `ThemeData`, `ColorScheme`, and component themes defined at app root.
- In widgets, read from `Theme.of(context)` rather than hardcoding colors and text styles.
- Override locally only when the design genuinely diverges from the theme.

## State boundaries inside widgets

- A widget that owns mutable state should also own the `setState` calls that mutate it.
- Don't pass `setState` callbacks down through many widget layers; instead lift the stateful logic up or extract a small state-holding widget.
- Use `Key`s when widget identity matters across reorder / list mutation.

## When to extract a widget

Extract when **any** of these is true:

- The same UI appears in two places.
- A `build()` method is hard to scan in one screen of editor.
- A subtree has its own non-trivial state or lifecycle.
- A subtree benefits from `const` and currently can't because its parent changes often.

Don't extract just to make a file shorter.
