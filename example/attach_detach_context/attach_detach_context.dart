// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:opentelemetry/api.dart';
import 'package:opentelemetry/sdk.dart'
    show ConsoleExporter, SimpleSpanProcessor, TracerProviderBase;

void main() {
  final tp = TracerProviderBase(
          processors: [SimpleSpanProcessor(ConsoleExporter())]),
      tracer = tp.getTracer('instrumentation-name');

  // Attach the root span to the current context (the root context) making the
  // span the current span until it is detached.
  final rootToken = Context.attach(
      contextWithSpan(Context.current, tracer.startSpan('root-1')..end()));

  // Starting a child span will automatically parent the span to the span held
  // by the attached context.
  final child1 = tracer.startSpan('child')..end();
  final context = contextWithSpan(Context.current, child1);

  // Starting a span doesn't automatically attach the span. So to make the
  // parent span actually parent a span, its context needs to be attached.
  final childToken = Context.attach(context);
  tracer.startSpan('grandchild-1').end();
  if (!Context.detach(childToken)) {
    throw Exception('Failed to detach context');
  }

  // Alternatively, manually specifying the desired parent context avoids the
  // need to attach and detach the context.
  tracer.startSpan('grandchild-2', context: context).end();

  if (!Context.detach(rootToken)) {
    throw Exception('Failed to detach context');
  }

  // Since the previous root span context was detached, spans will no longer be
  // automatically parented.
  tracer.startSpan('root-2').end();
}
