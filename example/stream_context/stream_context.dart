// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'dart:async';

import 'package:opentelemetry/api.dart';
import 'package:opentelemetry/sdk.dart'
    show ConsoleExporter, SimpleSpanProcessor, TracerProviderBase;

mixin EventContext {
  final Context context = Context.current;
}

class MyEvent with EventContext {
  MyEvent();
}

void main() async {
  final tp = TracerProviderBase(
          processors: [SimpleSpanProcessor(ConsoleExporter())]),
      tracer = tp.getTracer('instrumentation-name');

  final controller = StreamController<MyEvent>();

  traceSync('zone-a-parent', () {
    tracer.startSpan('zone-a-child').end();

    controller.stream.listen((e) {
      tracer.startSpan('new-root').end();
      tracer.startSpan('event-child', context: e.context).end();
    });
  }, tracer: tracer);

  traceSync('event-parent', () => controller.add(MyEvent()), tracer: tracer);

  await controller.close();
}
