# opentelemetry (deprecated)

This package has been renamed to [`opentelemetry_wk`](https://pub.dev/packages/opentelemetry_wk).

`opentelemetry` now only re-exports `opentelemetry_wk`, so `package:opentelemetry/...` and `package:opentelemetry_wk/...`
resolve to the same classes and the same global tracer provider. Code using either import can be mixed freely while
packages migrate.

## Migrating

1. Replace `opentelemetry` with `opentelemetry_wk` in `pubspec.yaml`.
2. Replace `package:opentelemetry/` with `package:opentelemetry_wk/` in imports.

No other changes are needed; the APIs are identical.

## Publishing New Versions

Only Workiva maintainers can publish new versions of opentelemetry-dart. See [Publishing opentelemetry-dart](https://github.com/Workiva/Observability/blob/master/doc/publishing_opentelemetry_dart.md)
