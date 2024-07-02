// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/experimental_api.dart';
import 'package:opentelemetry/src/sdk/trace/span.dart';
import 'package:test/test.dart';
import 'package:opentelemetry/src/api/context/map_context.dart';

void main() {
  final testSpanContext = api.SpanContext(api.TraceId([1, 2, 3]),
      api.SpanId([7, 8, 9]), api.TraceFlags.none, api.TraceState.empty());
  final testSpan = Span(
      'foo',
      testSpanContext,
      api.SpanId([4, 5, 6]),
      [],
      sdk.DateTimeTimeProvider(),
      sdk.Resource([]),
      sdk.InstrumentationScope(
          'library_name', 'library_version', 'url://schema', []),
      api.SpanKind.client,
      [],
      sdk.SpanLimits(),
      sdk.DateTimeTimeProvider().now);
  group('MapContext', () {
    test('getValue returns null if key is not set', () {
      final context = MapContext();
      final key = api.ContextKey();
      expect(context.getValue(key), isNull);
    });

    test('setValue returns a new context with the value set', () {
      final context = MapContext();
      final key = api.ContextKey();
      const value = 'testValue';
      final newContext = context.setValue(key, value);
      expect(newContext, isNot(same(context)));
      expect(context.getValue(key), isNull);
      expect(newContext.getValue(key), equals(value));
    });

    test('withSpan returns a new context with the span set', () {
      final context = MapContext();
      final newContext = context.withSpan(testSpan);
      expect(newContext, isNot(same(context)));
      expect(api.spanFromContext(newContext), equals(testSpan));
    });

    test('execute runs the given function', () {
      final context = MapContext();
      var ran = false;
      context.execute(() {
        ran = true;
      });
      expect(ran, isTrue);
    });

    test('span returns the span if set, or an invalid span if not', () {
      final context = MapContext();
      expect(context.span, isA<NonRecordingSpan>());
      final newContext = context.withSpan(testSpan);
      expect(api.spanFromContext(newContext), equals(testSpan));
    });
  });
}
