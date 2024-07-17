// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/experimental_api.dart';
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
      sdk.InstrumentationScope(
          'library_name', 'library_version', 'url://schema', []),
      api.SpanKind.client,
      [],
      sdk.SpanLimits(),
      sdk.DateTimeTimeProvider().now);

  group('spanFromContext', () {
    test('returns Span when exists', () {
      final context =
          api.contextWithSpan(api.globalContextManager.active, testSpan);

      expect(api.spanFromContext(context), same(testSpan));
    });

    test('returns an invalid Span when a Span does not exist in the Context',
        () {
      final context = api.globalContextManager.active;

      expect(api.spanFromContext(context), isA<NonRecordingSpan>());
      expect(api.spanContextFromContext(context).isValid, isFalse);
    });
  });

  group('spanContextFromContext', () {
    test('returns SpanContext when Span exists', () {
      final testContext =
          api.contextWithSpan(api.globalContextManager.active, testSpan);

      expect(api.spanContextFromContext(testContext), same(testSpanContext));
    });

    test(
        'returns an invalid SpanContext when a Span does not exist in the Context',
        () {
      expect(
          api.spanContextFromContext(api.globalContextManager.active).isValid,
          isFalse);
    });
  });
}
