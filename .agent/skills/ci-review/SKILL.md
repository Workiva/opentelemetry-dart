---
name: ci-review
description: Repo-specific review criteria for opentelemetry-dart.
allowed-tools: Read, Grep, Glob, Bash(git:*)
---

# opentelemetry-dart — CI Review Criteria

## Do not flag — caught before the PR

CI enforces:
- `dart analyze` — zero warnings, enforced by `make analyze`
- `dart format .` — enforced by `make format` (CI fails if diff after format)
- `dart test` — full test suite on Dart 3.9 (pinned) and `stable`
- Coverage generated and proto files excluded via `remove_from_coverage`
- Tested on both Dart 3.9 and stable in parallel CI jobs

---

## Proto-generated files

- Files under `lib/src/sdk/proto/` are generated from protobuf definitions via `make init` (requires `protoc`); direct edits are wrong — they will be overwritten.
- A PR that modifies `*.pb.dart` / `*.pbjson.dart` / `*.pbserver.dart` without updating the submodule `.proto` source is likely an accidental manual edit.

## Public API surface

- `lib/api.dart` and `lib/sdk.dart` are stable public API — removals or incompatible changes require a semver major bump and CHANGELOG entry.
- `lib/src/experimental_api.dart` exports are explicitly unstable; flag new stable behavior added there instead of to `api.dart`.
- New SDK features (span processors, exporters, samplers) should have a matching interface in `lib/src/api/` before or alongside the implementation in `lib/src/sdk/`.

## OTel spec conformance

- Sampling logic must follow the [OTel sampling spec](https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/trace/sdk.md#sampling); flag deviations.
- `BatchSpanProcessor` behavior (queue size, export timeout, shutdown) must respect the spec's required fields.

## Test coverage

- New `lib/src/api/` or `lib/src/sdk/` files must have a corresponding test in `test/`.
- Tests must not import from `lib/src/sdk/proto/` directly.

## Context propagation

- W3C Trace Context (`traceparent`, `tracestate`) must remain the canonical propagation format.
- New propagators must implement `TextMapPropagator` and be tested for both inject and extract paths.
