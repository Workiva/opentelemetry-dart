## 0.18.0

- Dart 3 support, primarily through dependency version ranges
  instead of hard pins.
- CI tests showing that the library works in Dart 2 and Dart 3.

## 0.17.0

- More closely adhere to OpenTelemetry spec.
- Use Dart 2.19 in continuous integration (CI).
- Use GitHub Actions for CI.

## 0.15.0

- Setup code exposed through API (no longer exposed through SDK). 
APIs that were moved:
    globalTextMapPropagator, 
    globalTracerProvider,
    registerGlobalTextMapPropagator,
    registerGlobalTracerProvider,
    trace,
    traceSync;

## 0.14.1

- Initial tag.