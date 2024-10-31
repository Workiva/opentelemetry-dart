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
  final String name;

  MyEvent(this.name);
}

void main() async {
  final tp = TracerProviderBase(
          processors: [SimpleSpanProcessor(ConsoleExporter())]),
      tracer = tp.getTracer('instrumentation-name');

  final controller = StreamController<MyEvent>();
  final completer = Completer();

  // zone A
  traceContextSync('init-listener-span', (_context) {
    controller.stream.listen((e) {
      // the default active context will return the attached context from [traceContextSync]
      tracer.startSpan('automatic-child-span' /*, context: active */).end();

      // explicitly using zone context propagation and ignoring the attached
      // context still propagates the same context from [traceContextSync]
      tracer
          .startSpan('zone-child-span',
              context: contextFromZone() /*, context: _context */)
          .end();

      // manually passing the active context from where the event was added to
      // the stream will allow creating traces that follow processing the event
      tracer.startSpan('event-child-span', context: e.context).end();

      completer.complete();
    });
  }, tracer: tracer);

  // zone B
  traceContextSync('add-event-span', (_) => controller.add(MyEvent('foo')),
      tracer: tracer);

  await completer.future;
  await controller.close();
}
