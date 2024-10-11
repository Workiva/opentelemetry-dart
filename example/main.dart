// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'dart:async';

import 'package:opentelemetry/api.dart';
import 'package:opentelemetry/sdk.dart';

/// Applications use a tracer to create sets of spans that constitute a trace.
/// There are several components needed to get a tracer:

/// An exporter is needed to send ended spans to a backend such as the dev
/// console.
final exporter = ConsoleExporter();

/// A processor is needed to handle starting and ending spans. The
/// [SimpleSpanProcessor] doesn't do any processing and immediately forwards
/// ended spans to the exporter. This is in contrast to the [BatchSpanProcessor]
/// which will batch spans together before forwarding them to the exporter.
final processor = SimpleSpanProcessor(exporter);

/// Finally, a [TracerProvider] is configured with any number of processors.
/// [TracerProviderBase] is suitable for applications run in the VM whereas
/// a WebTracerProvider is suited for applications transpiled to JavaScript to
/// run in a browser.
final provider = TracerProviderBase(processors: [processor]);

// The [TracerProvider] is the mechanism used to get a [Tracer].
final tracer = provider.getTracer('instrumentation-name');

/// Demonstrates creating a trace with a parent and child span.
void main() async {
  // The current active context is available via the global getter, [active].
  var context = active;

  // A trace starts with a root span which has no parent.
  final parentSpan = tracer.startSpan('parent-span');

  // A new context can be created in order to propagate context manually.
  context = contextWithSpan(context, parentSpan);

  // The [trace] and [traceSync] functions will automatically propagate
  // context, capture errors, and end the span.
  await trace('child-span', () {
    tracer.startSpan('grandchild-span').end();
    return Future.delayed(Duration(milliseconds: 100));
  }, context: context, tracer: tracer);

  // Spans must be ended or they will not be exported.
  parentSpan.end();
}
