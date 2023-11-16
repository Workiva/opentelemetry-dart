# OpenTelemetry for Dart

This repo is intended to be the Dart implementation of the OpenTelemetry project, with a
long-term goal of being open sourced.

All contributions and designs should follow the
[OpenTelemetry specification](https://github.com/open-telemetry/opentelemetry-specification)
in an effort to be consistent with [all other languages](https://github.com/open-telemetry).

## Getting Started

First, you will need to configure at least one exporter.  An exporter determines what happens to the spans you collect.
The current options are:

| Exporter | Description |
| -------- | ----------- |
| [CollectorExporter](#collectorexporter) | Sends Spans to a configured opentelemetry-collector. |
| [ConsoleExporter](#consoleexporter) | Prints Spans to the console. |

### Span Exporters

#### CollectorExporter

The CollectorExporter requires a Uri of the opentelemetry-collector instance's trace collector.

```dart
import 'package:opentelemetry/sdk.dart' as otel_sdk;

final exporter = otel_sdk.CollectorExporter(Uri.parse('https://my-collector.com/v1/traces'));
```

#### ConsoleExporter

The ConsoleExporter has no requirements, and has no configuration options.

```dart
import 'package:opentelemetry/sdk.dart' as otel_sdk;

final exporter = otel_sdk.ConsoleExporter();
```

### Span Processors

Next, you will need at least one span processor.  A span processor is responsible for collecting the spans you create and feeding them to the exporter.
The current options are:

| SpanProcessor | Description |
| -------- | ----------- |
| [BatchSpanProcessor](#batchspanprocessor) | Batches spans to be exported on a configured time interval. |
| [SimpleSpanProcessor](#simplespanprocessor) | Executes the provided exporter immediately upon closing the span. |

#### BatchSpanProcessor

BatchSpanProcessors collect up to 2048 spans per interval, and executes the provided exporter on a timer.
| Option | Description | Default |
| ------ | ----------- | ------- |
| maxExportBatchSize | At most, how many spans are processed per batch. | 512 |
| scheduledDelayMillis | How long to collect spans before processing them. | 5000 ms |

```dart
import 'package:opentelemetry/sdk.dart' as otel_sdk;

final exporter = otel_sdk.ConsoleExporter();
final processor = otel_sdk.BatchSpanProcessor(exporter, scheduledDelayMillis: 10000);
```

#### SimpleSpanProcessor

A SimpleSpanProcessor has no configuration options, and executes the exporter when each span is closed.

```dart
import 'package:opentelemetry/sdk.dart' as otel_sdk;

final exporter = otel_sdk.ConsoleExporter();
final processor = otel_sdk.SimpleSpanProcessor(exporter);
```

### Tracer Provider

A trace provider registers your span processors, and is responsible for managing any tracers.
| Option | Description | Default |
| ------ | ----------- | ------- |
| processors | A list of SpanProcessors to register. | A [SimpleSpanProcessor](#simplespanprocessor) configured with a [ConsoleExporter](#consoleexporter). |

```dart
import 'package:opentelemetry/sdk.dart' as otel_sdk;
import 'package:opentelemetry/api.dart';

final exporter = otel_sdk.CollectorExporter(Uri.parse('https://my-collector.com/v1/traces'));
final processor = otel_sdk.BatchSpanProcessor(exporter);

// Send spans to a collector every 5 seconds
final provider = otel_sdk.TracerProviderBase(processors: [processor]);

// Optionally, multiple processors can be registered
final provider = otel_sdk.TracerProviderBase(processors: [
  otel_sdk.BatchSpanProcessor(otel_sdk.CollectorExporter(Uri.parse('https://my-collector.com/v1/traces'))),
  otel_sdk.SimpleSpanProcessor(otel_sdk.ConsoleExporter())
]);

registerGlobalTracerProvider(provider);

final tracer = provider.getTracer('instrumentation-name');
// or
final tracer = globalTracerProvider.getTracer('instrumentation-name');
```

#### Tracer Provider with Browser Performance Features

A web-specific trace provider is also available.  This trace provider makes available configurable options using the browser's performance API.

```dart
import 'package:opentelemetry/sdk.dart' as otel_sdk;
import 'package:opentelemetry/web_sdk.dart' as web_sdk;
import 'package:opentelemetry/api.dart';

final exporter = otel_sdk.CollectorExporter(Uri.parse('https://my-collector.com/v1/traces'));
final processor = otel_sdk.BatchSpanProcessor(exporter);

// This provider is configured to create tracers which use the browser's
// performance API instead of Dart's DateTime class when determining
// timestamps for any spans they create.
final provider = web_sdk.WebTracerProvider(
  processors: [processor],
  timeProvider: web_sdk.WebTimeProvider()
);

// This tracer has been configured to use the browser's performance API when
// determining timestamps for any spans it creates.
final tracer = provider.getTracer('instrumentation-name');

// Or, these trace providers can also be registered globally.
registerGlobalTracerProvider(provider);
final tracer = globalTracerProvider.getTracer('instrumentation-name');
```

Important Note: Span timestamps resulting from use of this trace provider may be inaccurate if the executing system is suspended for sleep.
See [https://github.com/open-telemetry/opentelemetry-js/issues/852](https://github.com/open-telemetry/opentelemetry-js/issues/852) for more information.

## Collecting Spans

To start a span, execute `startSpan` on the tracer with the name of what you are tracing.  When complete, call `end` on the span.

```dart
final span = tracer.startSpan('doingWork');
...
span.end();
```

To create children spans, you must set the parent span as "current", and execute work within `withContext`.

```dart
final checkoutSpan = tracer.startSpan('checkout');
withContext(setSpan(Context.current, checkoutSpan), () {
  final ringUpSpan = tracer.startSpan('ringUp');
  ...
  ringUpSpan.end();
  final receiveSpan = tracer.startSpan('receiveCash');
  ...
  receiveSpan.end();
  final returnSpan = tracer.startSpan('returnChange');
  ...
  returnSpan.end();
});
checkoutSpan.end();
```

To avoid needing to pass spans around as arguments to other functions, you can get the current span with `Context.current.span`.

```dart
doWork() {
  Span parentSpan = Context.current.span;

  Context.current.withSpan(parentSpan).execute(() {
    Span span = tracer.startSpan('doWork');
    ...
    span.end();
  });
}
```

### Span Events

A Span Event is a human-readable message on an Span that represents a discrete event with no duration that can be tracked by a single timestamp. You can think of it like a primitive log.

```dart
span.addEvent('Doing something');

const result = doWork();
```

You can also create Span Events with additional Attributes:
```dart
span.addEvent('some log', attributes: {
  'log.severity': 'error',
  'log.message': 'Data not found',
  'request.id': requestId,
});
```

## Development

In order to generate protobuf definitions, you must have [protoc](https://github.com/protocolbuffers/protobuf/releases) installed and available in your path.
