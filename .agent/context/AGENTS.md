# opentelemetry-dart — agent context

Workiva's Dart implementation of the OpenTelemetry specification, providing traces (Beta), metrics (Alpha), and context propagation for Dart and browser apps.

## Structure
| Path | Role |
|---|---|
| `lib/api.dart` | Public API surface: tracer, span, context, propagation interfaces |
| `lib/sdk.dart` | SDK implementation: TracerProviderBase, processors, exporters, samplers |
| `lib/web_sdk.dart` | Browser-specific SDK: WebTracerProvider, WebTimeProvider |
| `lib/src/experimental_api.dart` | Experimental/unstable API — subject to breaking changes |
| `lib/src/api/` | API layer: trace, context, metrics, logs, propagation, exporters |
| `lib/src/sdk/` | SDK layer: trace, metrics, resource, proto serialization |
| `lib/src/sdk/proto/` | Protobuf-generated files (DO NOT EDIT — regenerate with `make init`) |
| `test/` | Unit tests mirroring `lib/src/` structure |
| `example/` | Usage examples |
| `scripts/` | Helper scripts for proto generation and CI |

## Commands
| Task | Command |
|---|---|
| Test | `dart test` |
| Analyze | `dart analyze` |
| Format | `dart format .` |
| Full CI sequence | `make init format analyze test` |
| Regenerate protos | `make init` (requires `protoc` installed) |

## Patterns
- Three-layer barrel pattern: `lib/api.dart` (interfaces) → `lib/sdk.dart` (implementations) → `lib/web_sdk.dart` (browser overrides); consumers depend only on the layer they need.
- Span processors follow the `SpanProcessor` interface in `lib/src/sdk/trace/span_processors/span_processor.dart`; batch and simple variants exist.
- Context propagation uses W3C Trace Context via `TextMapPropagator`, `TextMapSetter`, `TextMapGetter` in `lib/src/api/propagation/`.
- Proto-generated files in `lib/src/sdk/proto/` are excluded from coverage and from direct editing.

## Conventions
- SDK constraint is `^3.9.0` (Dart 3.x); CI tests on both pinned 3.9 and `stable`.
- `workiva_analysis_options/v2.yaml` is the analysis baseline; `dart analyze` must pass with zero warnings.
- `lib/src/sdk/proto/` files carry generated headers — do not edit; regenerate with `make init`.
- New public API exports added to `lib/api.dart` or `lib/sdk.dart` are semver-significant.
- `lib/src/experimental_api.dart` exports may break without a major version bump — document clearly.
- Coverage excludes `lib/src/sdk/proto/opentelemetry/proto/**` via `remove_from_coverage`.

## Commit pre-flight
1. `dart format .` — auto-fixes style
2. `dart analyze` — must pass
3. If proto files changed: `make init` to regenerate, then commit

## Agent file conventions
All canonical agent context and skills live under `.agent/`. The directories `.claude/` and `.cursor/` contain only symlinks into `.agent/` and MUST NOT be edited directly. Always edit `.agent/` files.

**`update-agents-md`** — invoke after: new or removed modules, changed formatter/linter/test commands, new external dependencies, toolchain migrations, architectural restructuring, or CI workflow changes.
Skill: `https://github.com/Workiva/Observability/.agent/skills/update-agents-md/SKILL.md`

**`update-ci-review`** — invoke after: codebase structure changes, new conventions, new or deprecated patterns. Run AFTER `update-agents-md` if AGENTS.md is also stale.
Skill: `https://github.com/Workiva/Observability/.agent/skills/update-ci-review/SKILL.md`

## Notes
<!-- reserved for human annotation — agents must not modify this section -->
