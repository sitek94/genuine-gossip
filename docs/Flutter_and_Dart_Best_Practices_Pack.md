# Flutter and Dart Best Practices Pack

Validated against current official Flutter docs, Dart docs, and current package docs consulted on 2026-05-03. The Flutter docs pages used here reflect Flutter 3.41.5, and the Dart docs pages used here reflect Dart 3.11.0. Package-specific guidance is limited to current package docs and active repos that were cross-checked against official Flutter/Dart guidance before inclusion. citeturn0search6turn4search1turn13search1turn14search0turn0search2turn3search0turn3search1

## Core pack

**flutter-best-practices.md**

Prefer the current stable Flutter SDK, enable `flutter_lints`, keep the app on Material 3, and optimize for small, testable units. Flutter’s own docs recommend `flutter_lints` for Flutter apps, Material 3 is the default, and the official architecture guidance centers on separation of concerns, clear boundaries, and testability. citeturn14search0turn1search0turn1search7turn1search1

Use this default posture:

- Split app code into UI and Data layers. Add a Domain or Logic layer only when complexity or reuse justifies it. citeturn1search1turn32view0
- Keep state ownership explicit and as local as possible. Lift state only when more than one widget, route, or feature truly needs it. Flutter performance docs also recommend localizing rebuild scope. citeturn11search1turn1search1
- Favor small widgets over giant screens; prefer reusable widgets to helper functions for reusable UI. Flutter docs explicitly call out small `build()` methods, `StatelessWidget` where possible, and `const` constructors as performance-friendly defaults. citeturn11search1
- Keep `build()` pure. No network calls, disk I/O, parsing, or controller creation in `build()`. Futures and streams should be obtained earlier, not created during `build()`. citeturn10search0turn10search7
- Prefer constructor injection. Repositories go into business-logic holders; services go into repositories. citeturn1search4turn1search1turn32view0
- Test at the right level: unit for logic, widget for UI, integration only for critical end-to-end flows. citeturn0search6turn7search7turn7search1
- Use lazy list/grid builders for larger collections, avoid unnecessary intrinsic layout work, and avoid expensive work in hot UI paths. citeturn11search1
- For app packages, commit `pubspec.lock`; for reusable packages, do not. citeturn5search0

**dart-rules.md**

Follow Effective Dart first, then add stricter local rules only where they clearly improve maintainability. Dart’s official guidance covers naming, typing, async style, imports, docs, error handling, and class modifiers. citeturn2search0turn2search1turn13search6turn13search1

Use these rules:

- File names: `lower_snake_case.dart`. Types and extensions: `UpperCamelCase`. Variables, parameters, methods, and functions: `lowerCamelCase`. citeturn0search3turn2search0
- Prefer meaningful names. Avoid vague names like `helper`, `utils`, `manager`, or `service` unless the role is truly generic and justified. This is a synthesis on top of Effective Dart’s consistency and naming clarity rules. citeturn2search0
- Keep null safety strict. Non-nullable by default, use `required` named parameters for non-optional inputs, and avoid nullable types unless absence is real domain meaning. citeturn13search1turn13search2turn13search8
- Prefer `final` by default, `const` when compile-time constant, and explicit types for public APIs and non-obvious declarations. citeturn2search0turn2search1
- Prefer `async` and `await` over raw future chains. Use `Future<void>` for async members without values. Keep fire-and-forget explicit with `unawaited(...)` only when intentional. citeturn2search0turn2search1turn2search5
- Avoid broad catches. Catch only the exception types you can actually handle; rethrow when needed. citeturn2search0
- Use class modifiers only when they earn their keep. `sealed` is especially useful for finite UI state and result hierarchies; `final` or `base` can help constrain extension points. citeturn13search6turn13search5turn4search0
- Avoid positional boolean parameters. Prefer named parameters or richer types. citeturn13search7
- Avoid `part` for ordinary code splitting. The Dart team recommends small libraries instead; keep `part` mainly for unavoidable generation workflows. citeturn5search2turn2search0
- Within one package, prefer relative imports when staying inside `lib/`; use `package:` imports when importing from outside `lib/` or across library boundaries. Never import another package’s `lib/src`. citeturn5search0

## Architecture and structure pack

**architecture.md**

Default architecture: feature-first, layered, and boring. Flutter’s official architecture guide recommends UI and Data layers, with an optional Domain or Logic layer. The most useful third-party AI-readable pack I found that stays close to those docs is the `architecture-feature-first` skill in `evanca/flutter-ai-rules`; its best ideas only made it into this pack where they matched official guidance. citeturn1search1turn32view0turn23view0

Recommended default:

- UI layer: views plus state/business-logic holder for that UI. The holder can be a view model, notifier, provider, cubit, or bloc. citeturn1search1turn32view0
- Data layer: repositories and services. Repositories are the source of truth for app data; services are stateless wrappers around external APIs, local storage, platform APIs, or files. citeturn1search1turn32view0
- Domain or Logic layer: optional. Add use cases or interactors only when business logic is complex, reused across features, or combines multiple repositories. Do not add it to simple CRUD or toy apps. citeturn1search1turn32view0
- Only adjacent layers should talk to each other. UI must not call services directly. citeturn1search1turn32view0
- Keep data mutation in repositories, not in widgets and not in view models. citeturn1search1turn32view0
- Prefer unidirectional flow: user events go inward; state comes back outward. This is a synthesis consistent with Flutter’s architecture and builder APIs. citeturn1search1turn10search2

Practical default for a greenfield app:

- Start with UI + Data only.
- Add one repository per distinct data concern.
- Add one service per external data source.
- Add a domain or use-case layer only after the second real case of cross-repository orchestration or heavy business logic.
- Do not add “clean architecture theater” layers just to say you have them.

**project-structure.md**

Prefer a single app package first. Split into multiple packages only for truly shared code, separately versioned modules, plugins, or code intended for reuse beyond the app. Dart package docs encourage small focused libraries and documented package boundaries; Flutter’s architecture docs encourage coherent responsibility boundaries. citeturn5search0turn5search2turn1search1

Recommended app layout:

- `lib/app/` for app bootstrap, dependency wiring, app-level routing, theme, and environment setup.
- `lib/ui/` for pure shared UI: design tokens, theme helpers, app-wide reusable widgets, and platform-neutral presentation primitives.
- `lib/features/<feature_name>/` for feature code. Collocate feature screens, widgets, state, repositories, and models when that keeps ownership obvious.
- `test/` for unit and widget tests.
- `integration_test/` only for a small number of critical user journeys. citeturn5search0turn7search7

Inside a feature, keep the smallest useful shape. A good default is:

- `presentation/` or direct colocated screen files for screens, feature widgets, and feature state holder.
- `data/` for repository impls, DTOs, mappers, and services if feature-scoped.
- `domain/` only if complexity warrants it.

Rules:

- If a widget is used by one feature, keep it in that feature.
- If a widget is pure UI and reused across features, move it to `ui/`.
- Avoid `lib/utils/`, `lib/helpers/`, or `lib/common/` dumping grounds.
- Prefer many small files over a few giant files, but not one class per file as a religion.
- Keep generated files at the edge of the feature they belong to; do not organize the whole project around generators.

Module boundaries:

- Shared UI module only for presentation-only components.
- Shared core module only for clearly cross-cutting concerns like app config, logging abstractions, or shared primitives.
- If code is reused once, copy it.
- If it is reused twice and stable, extract it.
- If reuse is speculative, leave it where it is.

## UI, state, and navigation pack

**widgets-and-ui.md**

Flutter layouts are built by composing widgets, and Flutter’s docs explicitly encourage composing simple widgets into more complex ones. Material 3 is now the default, and theming should flow from app-level `ThemeData`, `ColorScheme`, and component themes. citeturn11search0turn1search3turn1search0turn1search2

Use these UI rules:

- Prefer composition over inheritance. Build screens from small widgets.
- Prefer widgets over helper methods when extracting reusable UI. Flutter’s performance guidance explicitly prefers reusable UI as widgets, especially with `const`, over plain helper functions. citeturn11search1
- Prefer `StatelessWidget` unless local mutable state is genuinely needed. citeturn11search1
- Keep `build()` simple, side-effect-free, and focused on presentation. citeturn10search2turn11search1
- Use higher-level widgets like `ListTile` or `ListView` when they fit; do not rebuild low-level layout by default. Flutter layout docs explicitly call out higher-level widgets as often sufficient. citeturn11search0
- Theme centrally. Use `ThemeData`, `ColorScheme`, and component themes for app-wide styling, then override locally only when truly needed. Flutter docs document theme inheritance and override order. citeturn1search2turn1search0
- Assume Material 3. If you are using Material widgets, design for Material 3 components and tokens first. citeturn1search0turn1search3turn1search7
- Use lazy builders for long lists and large grids. Avoid unnecessary intrinsic layout passes and expensive visual effects in scroll-heavy or animation-heavy views. citeturn11search1
- Avoid work in build that would make the tree rebuild-expensive. Split widgets based on how they change. citeturn11search1

**state-management.md**

There is no single official “one true” state library. Flutter’s own docs and samples still demonstrate `ChangeNotifier`-style patterns; Riverpod, Provider, and Bloc all remain active and widely used packages with current docs and releases. The right rule for an AI agent is: choose the simplest sufficient tool and only one main state approach per app. citeturn1search1turn3search4turn3search0turn3search1turn36search0

Use this decision order:

- Use local widget state first for ephemeral UI-only concerns: toggles, selected index, text input, focus, animation coordination, and temporary visuals. No global or shared library needed.
- Use Provider plus `ChangeNotifier` when the app is small to medium, the team wants a very light dependency, or you want to stay close to Flutter’s official architecture examples. Provider describes itself as a wrapper around `InheritedWidget`, and Flutter samples/docs still use this family of patterns. citeturn3search4turn36search0turn1search1
- Use Riverpod when you want stronger dependency wiring, ergonomic async/error/loading handling, and testable state that is less coupled to widget `BuildContext`. Riverpod’s current package docs emphasize async handling, separation from UI, and testability. This is my preferred default for non-trivial greenfield shared state in 2026. citeturn3search0turn3search3
- Use Bloc or Cubit when the app benefits from explicit state transitions, event-driven orchestration, and a stricter presentation-to-logic boundary. The current `flutter_bloc` docs emphasize builder/listener separation, provider scoping, and immutable selected state patterns. citeturn3search1turn3search2

Hard rules:

- Do not introduce global app state until at least two routes or features need the same source of truth.
- Keep state ownership obvious. Every piece of state should have one owner.
- Keep derived UI state derived; do not store what can be calculated cheaply. citeturn2search0
- Do not mix multiple primary state libraries in the same app without a compelling migration reason.
- Repositories own app data. UI state holders own presentation state.
- Prefer immutable state objects for shared state and feature state; that plays best with Provider selectors, Riverpod providers, and Bloc builders. citeturn3search1turn3search4

**routing-and-navigation.md**

Flutter’s official docs say named routes are not recommended in most applications. Use plain `Navigator` for simple push/pop flows; use Router-based navigation, most often `go_router`, when you need deep links, redirects, nested navigators, or URL-shaped routing state. `go_router` is maintained by the Flutter team and its package docs cover ShellRoute, deep linking, redirection, error handling, restoration, and type-safe routes. citeturn1search6turn0search2

Use these routing rules:

- For a tiny app with simple page transitions: use `Navigator`.
- For any app with login redirects, reusable app shells, tabs with nested stacks, app links, or web parity: use `go_router`. citeturn1search6turn0search2
- Keep route definitions close to app bootstrap, but move feature route builders or route data next to the feature once the route graph grows.
- Avoid raw route-name strings scattered through widgets. Centralize route construction.
- Prefer typed route arguments and dedicated route objects over passing loosely structured maps.
- For localized multi-step flows, a nested `Navigator` owned by the flow widget is a good fit. Flutter’s official nested-navigation recipe explicitly recommends delegating such flows to a nested navigator for local control. citeturn9search0
- Use `PopScope` and explicit exit handling for flows that may lose progress. Flutter’s nested-flow recipe demonstrates this pattern. citeturn9search0

## Data, forms, and quality pack

**async-and-data.md**

Repositories are the source of truth; services are stateless async wrappers; UI reacts to async state but does not create async work in `build()`. Dart’s official guidance prefers `async` and `await`, and Flutter’s `FutureBuilder` and `StreamBuilder` docs explicitly say futures and streams should be obtained earlier than `build()`. citeturn1search1turn10search0turn10search7turn2search0

Use these rules:

- Prefer `async` and `await`.
- Never create a `Future` or `Stream` inline in `build()` for `FutureBuilder` or `StreamBuilder`. Obtain it in state setup or from injected logic. citeturn10search0turn10search7
- Keep async UI builders pure. Builder callbacks should only return widgets. citeturn10search2
- Inject HTTP clients or data sources into services for testability. Flutter’s JSON parsing recipe explicitly passes an `http.Client` for easier testing and environment flexibility. citeturn10search3
- For expensive parsing or compute-heavy transformation, move work off the main isolate. Flutter’s official recipe calls out background parsing to avoid jank once work exceeds frame budget. citeturn10search3turn11search1
- Prefer explicit result types at layer boundaries for recoverable failures in larger apps. Flutter’s architecture docs show a sealed `Result<T>` pattern to force callers to handle success vs error. citeturn4search0
- If command-style async action state becomes repetitive in view models, a command wrapper is reasonable; Flutter’s architecture docs provide such a pattern, but it should stay optional, not mandatory. citeturn4search1
- If intentionally not awaiting a future, mark that explicitly with `unawaited()` and only do it when failures are either impossible or handled elsewhere. citeturn2search5

**forms-and-validation.md**

Default to simple, typed, local forms first. Flutter’s samples repository includes a dedicated `form_app` sample for forms best practices, while package docs show two viable “heavier” paths when forms become complex: `reactive_forms` for model-driven forms and `formz` for reusable typed validation inputs. citeturn38view0turn12search0turn12search1

Use these rules:

- Keep small forms simple. Do not add a package for a login form, search bar, or two-field settings page.
- Keep field parsing and validation typed. Convert raw strings to typed values as early as practical.
- Keep validation rules near the field model or form state holder, not scattered across widgets.
- Show validation messages after user interaction or after submit, not immediately on first paint.
- Debounce async validation and keep it in the business-logic holder, not directly inside the widget tree.
- Disable or guard submit while already submitting.
- For large dynamic or strongly model-driven forms, `reactive_forms` is a legitimate option; its docs focus on model-driven forms, typed controls, synchronous and asynchronous validators, and composition. citeturn12search0
- For Dart-first reusable input validation, especially alongside Bloc-style state, `formz` is a lightweight option; its docs position it as a unified form representation in Dart. citeturn12search1
- Do not force either package unless the built-in approach is becoming repetitive or brittle.

**testing.md**

Flutter’s official testing guidance is clear: use unit tests, widget tests, and integration tests at the level each problem deserves. The `integration_test` package exposes `flutter_test`-style APIs and can run on devices, emulators, and Firebase Test Lab. citeturn0search6turn7search7turn7search1

Use this strategy:

- Unit test repositories, mappers, validators, use cases, and view-model/notifier/cubit logic.
- Widget test screens, reusable widgets, error/loading/empty states, navigation triggers, and form behavior.
- Keep integration tests few and high-value: app launch, auth, checkout/submit, or any critical end-to-end happy path and one major failure path.
- Prefer fake or mock dependencies at lower layers; keep platform/device dependence mostly inside integration tests.
- For networked code, inject clients so unit tests can fake responses cleanly. citeturn10search3
- Verify loading, success, empty, and error states explicitly.
- Do not chase a coverage number at the expense of useful tests. Test risk, behavior, and boundaries.

**anti-patterns.md**

Do not do these:

- Widgets calling services directly. The official architecture guidance says UI should talk to business-logic holders, and services live at the lowest layer. citeturn1search1turn32view0
- Repositories talking to each other casually. Flutter’s architecture guide explicitly says repositories should not be aware of each other; combine data in the view model or domain layer. citeturn1search1
- Creating futures or streams in `build()`. citeturn10search0turn10search7
- Giant global `utils/`, `helpers/`, `managers/`, or `services/` folders.
- Inventing a domain layer before you have domain complexity.
- Scattering route strings through widgets.
- Catch-all exception swallowing. Dart explicitly advises against catches without `on` clauses and against discarding caught errors. citeturn2search0
- Overusing inheritance for widgets or feature logic.
- Adding code generation by default.
- Splitting a simple app into many Dart packages too early.
- Choosing a state library before understanding the actual state-sharing problem.
- Storing derived state that should be computed.

## Maintenance and agent workflow pack

**refactor-checklist.md**

Before refactoring:

- Identify the owner of each state variable.
- Identify whether the logic is UI-only, feature-level, or data-layer logic.
- Identify public APIs, route contracts, and serialized model boundaries.
- Identify existing tests that should protect the change.

During refactoring:

- Move business logic out of widgets first.
- Reduce indirection; do not replace one giant file with five pointless wrappers.
- Keep behavior stable before making architecture more “clean”.
- Prefer constructor injection over service locators hidden deep in code.
- Leave code more local, not more magical.

After refactoring:

- Run `dart format`.
- Run `flutter analyze`.
- Run the affected unit and widget tests; run integration tests if navigation or app wiring changed.
- Remove dead code and stale exports.
- Re-check naming, file placement, and ownership. Flutter’s AGENTS guidance for first-party packages centers on formatting, linting, and relevant tests after changes. citeturn29view3turn14search0turn0search6

**review-checklist.md**

Review code with these questions:

- Is state ownership obvious?
- Is the simplest sufficient state approach being used?
- Are widgets presentation-only, or is business logic leaking into them?
- Is async work created outside `build()`?
- Are loading, empty, and error states handled?
- Are repository and service boundaries respected?
- Are names meaningful and Dart-conventional?
- Is routing centralized enough to avoid stringly typed chaos?
- Is the theme used instead of hard-coded styling?
- Did this change add a package without clear value?
- Did this change increase abstraction count without reducing complexity?
- Are tests added or updated at the right level?

**ai-agent-rules.md**

This file is deliberately neutral Markdown, but it is written for any coding agent. It is based most strongly on the `flutter/packages` AGENTS guide, the open `AGENTS.md` format work, and the best Flutter-specific public rules repo found during research. citeturn29view3turn16search1turn23view0turn32view0

Rules for an AI coding agent:

- Read the nearest relevant files before editing.
- Prefer the smallest working change that fits existing architecture.
- Do not introduce a new state library, router package, generator, or folder taxonomy unless the task truly needs it.
- Follow the app’s existing state approach unless the task explicitly changes architecture.
- For new features, keep code inside the feature first; extract shared code only after real reuse appears.
- Keep widgets presentation-focused; place business logic in the feature’s state holder.
- Prefer constructor injection.
- Do not put network, storage, or parsing logic in widgets.
- Do not create futures or streams in `build()`.
- Run formatting, analysis, and relevant tests after changes. Flutter’s first-party AGENTS guide makes format plus lint/analyze/tests mandatory. citeturn29view3
- When adding dependencies, prefer widely adopted, actively maintained packages with current Dart and Flutter support. Current package pages show active maintenance for `go_router`, `flutter_riverpod`, `provider`, `flutter_bloc`, and `very_good_analysis`. citeturn0search2turn3search0turn3search4turn3search1turn35search0
- If a package requires generation, generate only the needed artifacts and keep them close to the feature that owns them.
- Do not add a domain layer, base class, or global utility module “for future use”.
- When unsure, choose the KISS path:
  - local state before shared state,
  - repository before use case,
  - explicit code before clever abstractions,
  - one good test before many shallow tests.

## sources.md

**Ranked source list**

**Flutter app architecture guide and case-study pages**  
Type: official docs. Link: Flutter architecture guide and related architecture pages. citeturn1search1turn1search4turn4search0turn4search1  
Stars/adoption: not a GitHub repo; official Flutter documentation.  
Why useful: highest-confidence source for modern Flutter layering, repositories/services, constructor DI, optional domain layer, and explicit error/action patterns.  
Weaknesses: intentionally framework-neutral about third-party state libraries; not feature-first by itself.  
Score: 10/10.  
Influenced final pack: yes.

**Effective Dart, class modifiers, null safety, lints, and package layout docs**  
Type: official docs. Link: Effective Dart, class modifiers, null safety, lints, package layout, and pub docs. citeturn2search0turn2search1turn13search6turn13search1turn2search3turn5search0turn5search3  
Stars/adoption: not a GitHub repo; official Dart documentation.  
Why useful: canonical source for naming, typing, async, imports, null safety, and package/module boundaries.  
Weaknesses: not Flutter-architecture-specific.  
Score: 10/10.  
Influenced final pack: yes.

**Flutter navigation, theming, performance, layout, testing, and async widget docs**  
Type: official docs and API reference. Link: navigation docs, theming docs, performance best practices, layout docs, testing docs, `FutureBuilder`, and `StreamBuilder`. citeturn1search6turn1search2turn11search1turn11search0turn0search6turn10search0turn10search7  
Stars/adoption: not a GitHub repo; official Flutter docs.  
Why useful: best source for `build()` purity, Builder rules, Material 3 defaults, lazy lists, and testing levels.  
Weaknesses: spread across multiple pages.  
Score: 9.5/10.  
Influenced final pack: yes.

**go_router package docs**  
Type: package docs. Link: `go_router` package page. citeturn0search2  
Stars/adoption: package page showed 5.7k likes and 2.57M downloads; published by `flutter.dev`.  
Why useful: current official-package source for Router-based navigation, shell routes, deep linking, redirection, state restoration, and type-safe routes.  
Weaknesses: package-specific; does not replace understanding Navigator basics.  
Score: 9/10.  
Influenced final pack: yes.

**Provider, Riverpod, and flutter_bloc package docs**  
Type: package docs. Link: `provider`, `flutter_riverpod`, and `flutter_bloc`. citeturn3search4turn3search0turn3search1  
Stars/adoption: Provider page showed 10.9k likes; Riverpod page showed 2.8k likes and 1.61M downloads; `flutter_bloc` page showed 8.0k likes and 1.44M downloads.  
Why useful: active, current package docs for the three most practical shared-state options.  
Weaknesses: each source naturally favors its own model; cross-comparison still required judgment.  
Score: 9/10.  
Influenced final pack: yes.

**flutter/packages AGENTS.md**  
Type: repo instruction file. Link: `flutter/packages` repository and its AGENTS guide. citeturn17view0turn29view3  
Stars/adoption: repository page showed 5.2k stars.  
Why useful: current, first-party, agent-readable guidance for Flutter package work; strongly reinforces “format, analyze, test, respect repo conventions”.  
Weaknesses: monorepo/package-maintainer oriented, not app-architecture oriented.  
Score: 8.5/10.  
Influenced final pack: yes, especially `ai-agent-rules.md` and maintenance checklists.

**flutter/samples and Compass app**  
Type: official repo. Link: `flutter/samples`. citeturn36search0turn38view0  
Stars/adoption: repository page showed 19.1k stars.  
Why useful: official, runnable examples; current repo includes `compass_app` for MVVM, `navigation_and_routing` for `go_router`, `form_app` for forms, and `testing_app` for testing.  
Weaknesses: sample repos are examples, not a full style guide.  
Score: 8.5/10.  
Influenced final pack: yes.

**evanca/flutter-ai-rules**  
Type: AI skill/rulepack repo. Link: repo, combined rules, and feature-first architecture skill. citeturn23view0turn26view0turn32view0  
Stars/adoption: GitHub page snapshots during research showed the repo in the low-500-star range.  
Why useful: the best Flutter-specific, agent-readable public rules pack found; modular, practical, and explicitly grounded in official docs.  
Weaknesses: not official; quality depends on curation; a few rule files flatten nuance.  
Score: 8/10.  
Influenced final pack: yes, but only where ideas matched official Flutter/Dart docs.

**Very Good templates and Very Good Analysis**  
Type: repo and package docs. Link: Very Good Open Source org, templates repo, CLI, and `very_good_analysis`. citeturn34search1turn33search2turn33search0turn35search0turn35search6  
Stars/adoption: org page showed `very_good_cli` at 2.3k stars, `very_good_analysis` repo at 432 stars, `very_good_templates` at 144 stars; `very_good_analysis` package page showed 751 likes and current Dart 3.11 support.  
Why useful: active, practical ecosystem tooling for linting, templates, and production workflow expectations.  
Weaknesses: opinionated and stricter than this pack’s goal; template architecture is broader than many hobby or mid-size apps need.  
Score: 7.5/10.  
Influenced final pack: partially, mostly around linting and workflow, not as the main architecture source.

**agentsmd/agents.md**  
Type: open standard / repo instruction format. Link: AGENTS standard repo. citeturn16search1turn16search4  
Stars/adoption: page showed 20.3k stars.  
Why useful: strongest neutral source for how an agent-readable instruction file should be structured.  
Weaknesses: not Flutter-specific.  
Score: 7/10.  
Influenced final pack: yes, structurally, for `ai-agent-rules.md`.

**brianegan/flutter_architecture_samples**  
Type: architecture repo. Link: repo page. citeturn37view0  
Stars/adoption: page showed 8.9k stars.  
Why useful: historically important comparison repo showing multiple Flutter architecture approaches side by side.  
Weaknesses: much older; includes outdated ecosystems and patterns like `scoped_model`, Redux-era conventions, and older package links, so it is not a safe direct template for 2026.  
Score: 5/10.  
Influenced final pack: no, except as historical context.

**Limitations**

- Public Flutter-specific AI rulepacks are still much weaker than the official Flutter/Dart docs. Most are thin wrappers around those docs, or they add unvalidated opinion.  
- Many popular Flutter architecture repos are old enough to be poor direct templates for 2026. I excluded several stale “clean architecture boilerplates” from influence for that reason. Historical popularity alone was not treated as quality. citeturn37view0turn15search1turn15search7