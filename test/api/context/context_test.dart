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

  group('contextWithSpan', () {
    test('returns a new Context with the Span', () {
      final context = api.contextWithSpan(api.active, testSpan);
      expect(api.active, isNot(same(context)));
      expect(api.spanFromContext(context), same(testSpan));
    });
  });

  group('contextWithSpanContext', () {
    test('returns a new Context with the SpanContext', () {
      final context = api.contextWithSpanContext(api.active, testSpanContext);
      expect(api.active, isNot(same(context)));
      expect(api.spanContextFromContext(context), same(testSpanContext));
    });
  });

  group('spanFromContext', () {
    test('returns Span when exists', () {
      final context = api.contextWithSpan(api.active, testSpan);
      expect(api.spanFromContext(context), same(testSpan));
    });

    test('returns an invalid Span when Span doesn\'t exist', () {
      final context = api.active;
      expect(api.spanFromContext(context), isA<NonRecordingSpan>());
      expect(api.spanContextFromContext(context).isValid, isFalse);
    });
  });

  group('spanContextFromContext', () {
    test('returns SpanContext when Span exists', () {
      final testContext = api.contextWithSpan(api.active, testSpan);
      expect(api.spanContextFromContext(testContext), same(testSpanContext));
    });

    test('returns an invalid SpanContext when Span doesn\'t exist', () {
      expect(api.spanContextFromContext(api.active).isValid, isFalse);
    });
  });

  group('active', () {
    test('returns root context', () {
      expect(api.active, same(api.root));
    });

    test('returns zone context', () {
      final context = api.contextWithSpan(api.active, testSpan);
      api.zoneWithContext(context).run(() => expect(api.active, same(context)));
    });

    test('returns attached context', () {
      final context = api.contextWithSpan(api.active, testSpan);
      api.attach(context);
      expect(api.active, same(context));
    });
  });

  group('detach', () {
    test('returns true on match', () {
      final token = api.attach(api.active);
      expect(api.detach(token), isTrue);
    });

    test('returns false on mismatch', () {
      final token = api.attach(api.active);
      api.attach(api.active);
      expect(api.detach(token), isFalse);
    });
  });
}
