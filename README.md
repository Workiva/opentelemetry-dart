# OpenTelemetry for Dart

This repo is intended to be the Dart implementation of the OpenTelemetry project, with a 
long-term goal of being open sourced.

All contributions and designs should follow the 
[OpenTelemetry specification](https://github.com/open-telemetry/opentelemetry-specification) 
in an effort to be consistent with [all other languages](https://github.com/open-telemetry).

## Getting Started

```
// pubspec.yaml

...
dependencies:
  opentelemetry: ^0.0.0
...
```

```
import 'package:opentelemetry/api.dart';
import 'package:opentelemetry/sdk.dart' as otel_sdk;

final otel_sdk.ConsoleExporter exporter = otel_sdk.ConsoleExporter();
final otel_sdk.TracerProvider provider = otel_sdk.TracerProvider([
  otel_sdk.SimpleSpanProcessor(exporter)
]);
final Tracer tracer = provider.getTracer('appName', version: '1.0.0');

doWork() {
  Span parent = getSpan(Context.current);

  withContext(setSpan(Context.current, parent), () {
    Span span = tracer.startSpan('doWork');
    ...
    span.end();
  });
}

doMoreWork() async {
  Span parent = getSpan(Context.current);

  await withContext(setSpan(Context.current, parent), () async {
    Span span = tracer.startSpan('doMoreWork');
    ...
    span.end();
  });
}

main() async {
  // parent span
  Span span = tracer.startSpan('work-setup');

  // force all enclosed new spans will be a child of the parent span.
  withContext(setSpan(Context.current, span), () {
    doWork();
  });

  await withContext(setSpan(Context.current, span), () async {
    await doMoreWork();
  });

  span.end();
}
```