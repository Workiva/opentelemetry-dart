// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/sdk/trace/span.dart';
import 'package:test/test.dart';

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
      sdk.InstrumentationLibrary('library_name', 'library_version'));

  group('get Span', () {
    test('returns Span when exists', () {
      final childContext = api.Context.current.withSpan(testSpan);

      expect(childContext.span, same(testSpan));
    });

    test('returns null when not exists', () {
      final context = api.Context.current;

      expect(context.span, isNull);
    });
  });

  group('get SpanContext', () {
    test('returns SpanContext when Span exists', () {
      final testContext = api.Context.current.withSpan(testSpan);

      expect(testContext.spanContext, same(testSpanContext));
    });

    test('returns null when Span not exists', () {
      final testContext = api.Context.current;

      expect(testContext.spanContext, isNull);
    });
  });
}
