// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/sdk/trace/tracer.dart';
import 'package:test/test.dart';

void main() {
  test('startSpan new trace', () {
    final tracer = Tracer([],
        sdk.Resource([]),
        sdk.AlwaysOnSampler(),
        sdk.DateTimeTimeProvider(),
        sdk.IdGenerator(),
        sdk.InstrumentationLibrary('name', 'version'));

    final span = tracer.startSpan('foo');

    expect(span.startTime, isNotNull);
    expect(span.endTime, isNull);
    expect(span.spanContext!.traceId, isNotNull);
    expect(span.spanContext!.spanId, isNotNull);
  });

  test('startSpan child span', () {
    final tracer = Tracer([],
        sdk.Resource([]),
        sdk.AlwaysOnSampler(),
        sdk.DateTimeTimeProvider(),
        sdk.IdGenerator(),
        sdk.InstrumentationLibrary('name', 'version'));

    final parentSpan = tracer.startSpan('foo');
    final context = api.Context.current.withSpan(parentSpan);

    final childSpan = tracer.startSpan('bar', context: context);

    expect(childSpan.startTime, isNotNull);
    expect(childSpan.endTime, isNull);
    expect(childSpan.spanContext!.traceId,
        equals(parentSpan.spanContext!.traceId));
    expect(childSpan.spanContext!.traceState,
        equals(parentSpan.spanContext!.traceState));
    expect(childSpan.spanContext!.spanId,
        allOf([isNotNull, isNot(equals(parentSpan.spanContext!.spanId))]));
  });
}
