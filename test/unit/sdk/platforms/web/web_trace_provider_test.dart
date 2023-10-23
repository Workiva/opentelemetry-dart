// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('chrome')
import 'package:mockito/mockito.dart';
import 'package:opentelemetry/src/api/context/context.dart';
import 'package:opentelemetry/src/sdk/trace/span.dart';
import 'package:opentelemetry/src/sdk/trace/span_processors/span_processor.dart';
import 'package:opentelemetry/src/sdk/platforms/web/trace/web_tracer_provider.dart';
import 'package:test/test.dart';

import '../../../mocks.dart';

void main() {
  test('getTracer stores tracers by name', () {
    final provider = WebTracerProvider();
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

  test('browserTracerProvider custom span processors', () {
    final mockProcessor1 = MockSpanProcessor();
    final mockProcessor2 = MockSpanProcessor();
    final provider =
        WebTracerProvider(processors: [mockProcessor1, mockProcessor2]);

    expect(provider.spanProcessors, [mockProcessor1, mockProcessor2]);
  });

  test('browserTracerProvider force flushes all processors', () {
    final mockProcessor1 = MockSpanProcessor();
    final mockProcessor2 = MockSpanProcessor();
    WebTracerProvider(processors: [mockProcessor1, mockProcessor2])
        .forceFlush();

    verify(mockProcessor1.forceFlush()).called(1);
    verify(mockProcessor2.forceFlush()).called(1);
  });

  test('browserTracerProvider shuts down all processors', () {
    final mockProcessor1 = MockSpanProcessor();
    final mockProcessor2 = MockSpanProcessor();
    WebTracerProvider(processors: [mockProcessor1, mockProcessor2]).shutdown();

    verify(mockProcessor1.shutdown()).called(1);
    verify(mockProcessor2.shutdown()).called(1);
  });

  test('browserTracerProvider creates a tracer which can create valid spans',
      () async {
    final Span span = WebTracerProvider(processors: [MockSpanProcessor()])
        .getTracer('testTracer')
        .startSpan('testSpan', context: Context.root)
      ..end();

    expect(span.startTime, lessThanOrEqualTo(span.endTime));
  });
}
