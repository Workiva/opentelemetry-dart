// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'package:fixnum/src/int64.dart';
import 'package:mocktail/mocktail.dart';
import 'package:opentelemetry/src/sdk/time_providers/time_provider.dart';
import 'package:opentelemetry/src/sdk/trace/read_only_span.dart';
import 'package:opentelemetry/src/sdk/trace/span_processors/span_processor.dart';
import 'package:opentelemetry/src/sdk/trace/tracer_provider.dart';
import 'package:test/test.dart';

import '../mocks.dart';

void main() {
  test('getTracer stores tracers by name', () {
    final provider = TracerProviderBase();
    final fooTracer = provider.getTracer('foo');
    final barTracer = provider.getTracer('bar');
    final fooWithVersionTracer = provider.getTracer('foo', version: '1.0');

    expect(
        fooTracer,
        allOf([
          isNot(barTracer),
          isNot(fooWithVersionTracer),
          same(provider.getTracer('foo'))
        ]));

    expect(provider.spanProcessors, isA<List<SpanProcessor>>());
  });

  test('tracerProvider custom span processors', () {
    final mockProcessor1 = MockSpanProcessor();
    final mockProcessor2 = MockSpanProcessor();
    final provider =
        TracerProviderBase(processors: [mockProcessor1, mockProcessor2]);

    expect(provider.spanProcessors, [mockProcessor1, mockProcessor2]);
  });

  test('traceProvider custom timeProvider', () {
    final mockTimeProvider = FakeTimeProvider(now: Int64(123));
    final provider = TracerProviderBase(timeProvider: mockTimeProvider);
    final span = provider.getTracer('foo').startSpan('bar') as ReadOnlySpan;
    expect(span.startTime, Int64(123));
  });

  test('tracerProvider force flushes all processors', () {
    final mockProcessor1 = MockSpanProcessor();
    final mockProcessor2 = MockSpanProcessor();
    TracerProviderBase(processors: [mockProcessor1, mockProcessor2])
        .forceFlush();

    verify(() => mockProcessor1.forceFlush()).called(1);
    verify(() => mockProcessor2.forceFlush()).called(1);
  });

  test('tracerProvider shuts down all processors', () {
    final mockProcessor1 = MockSpanProcessor();
    final mockProcessor2 = MockSpanProcessor();
    TracerProviderBase(processors: [mockProcessor1, mockProcessor2]).shutdown();

    verify(() => mockProcessor1.shutdown()).called(1);
    verify(() => mockProcessor2.shutdown()).called(1);
  });
}

class FakeTimeProvider extends Mock implements TimeProvider {
  FakeTimeProvider({required Int64 now}) : _now = now;
  final Int64 _now;

  @override
  Int64 get now => _now;
}
