// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'package:opentelemetry/api.dart' as api;
import 'package:test/test.dart';

void main() {
  test('valid context evaluates as valid', () {
    final spanId = api.SpanId([1, 2, 3]);
    final traceId = api.TraceId([4, 5, 6]);
    const traceFlags = api.TraceFlags.sampled;
    final traceState = api.TraceState.empty();

    final testSpanContext =
        api.SpanContext(traceId, spanId, traceFlags, traceState);

    expect(testSpanContext.isValid, isTrue);
    expect(testSpanContext.traceId, same(traceId));
    expect(testSpanContext.spanId, same(spanId));
    expect(testSpanContext.traceFlags, same(traceFlags));
    expect(testSpanContext.traceState, same(traceState));
  });

  test('invalid parsed parent span ID from header creates an invalid context',
      () {
    final spanId = api.SpanId.fromString('0000000000000000');
    final traceId = api.TraceId([4, 5, 6]);
    const traceFlags = api.TraceFlags.sampled;
    final traceState = api.TraceState.empty();

    final testSpanContext =
        api.SpanContext(traceId, spanId, traceFlags, traceState);

    expect(testSpanContext.isValid, isFalse);
    expect(testSpanContext.traceId, same(traceId));
    expect(testSpanContext.spanId, same(spanId));
    expect(testSpanContext.traceFlags, same(traceFlags));
    expect(testSpanContext.traceState, same(traceState));
  });

  test('invalid parsed trace ID from header creates an invalid context', () {
    final spanId = api.SpanId([1, 2, 3]);
    final traceId = api.TraceId.fromString('00000000000000000000000000000000');
    const traceFlags = api.TraceFlags.sampled;
    final traceState = api.TraceState.empty();

    final testSpanContext =
        api.SpanContext(traceId, spanId, traceFlags, traceState);

    expect(testSpanContext.isValid, isFalse);
    expect(testSpanContext.traceId, same(traceId));
    expect(testSpanContext.spanId, same(spanId));
    expect(testSpanContext.traceFlags, same(traceFlags));
    expect(testSpanContext.traceState, same(traceState));
  });

  test('invalid context evaluates as invalid', () {
    final testSpanContext = api.SpanContext.invalid();

    expect(testSpanContext.isValid, isFalse);
    expect(testSpanContext.traceId.isValid, isFalse);
    expect(testSpanContext.isValid, isFalse);
    expect(testSpanContext.traceFlags, equals(api.TraceFlags.none));
    expect(testSpanContext.traceState.isEmpty, isTrue);
  });
}
