// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'dart:async';

import 'package:opentelemetry/api.dart';
import 'package:opentelemetry/sdk.dart'
    show ConsoleExporter, SimpleSpanProcessor, TracerProviderBase;

void main() {
  final tp = TracerProviderBase(
          processors: [SimpleSpanProcessor(ConsoleExporter())]),
      tracer = tp.getTracer('instrumentation-name');

  final span = tracer.startSpan('root-zone-attached-span')..end();
  final token = attach(contextWithSpan(active, span));

  final completer = Completer();

  // zone A
  zoneWithContext(active).run(() {
    final span = tracer.startSpan('zone-a-attached-span')..end();
    final context = contextWithSpan(active, span);

    // zone B
    zoneWithContext(context).run(() {
      tracer.startSpan('zone-b-span').end();
      completer.future.then((_) {
        tracer.startSpan('zone-b-post-detach-span').end();
      });
    });

    final token = attach(context);
    tracer.startSpan('zone-a-attached-child-span').end();
    if (!detach(token)) {
      throw Exception('Failed to detach context');
    }

    tracer.startSpan('zone-a-post-detach-span').end();
  });

  if (!detach(token)) {
    throw Exception('Failed to detach context');
  }

  completer.complete();

  tracer.startSpan('root-zone-post-detach-span').end();
}
