// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')

import 'package:opentelemetry/api.dart';
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/sdk/trace/span.dart' as sdk show Span;
import 'package:opentelemetry/src/sdk/trace/tracer.dart' as sdk show Tracer;
import 'package:test/test.dart';

void main() {
  final tracer = sdk.Tracer([],
      sdk.Resource([]),
      sdk.AlwaysOnSampler(),
      sdk.DateTimeTimeProvider(),
      sdk.IdGenerator(),
      sdk.InstrumentationScope('name', 'version', 'url://schema', []),
      sdk.SpanLimits());

  test('trace starts and ends span', () async {
    final span = await trace('span', () async {
      return spanFromContext(Context.current);
    }, tracer: tracer) as sdk.Span;

    expect(span.startTime, isNotNull);
    expect(span.endTime, isNotNull);
  });

  test('traceSync starts and ends span', () {
    final span = traceSync('span', () {
      return spanFromContext(Context.current);
    }, tracer: tracer) as sdk.Span;

    expect(span.startTime, isNotNull);
    expect(span.endTime, isNotNull);
  });

  test('trace propagates context', () {
    final parent = tracer.startSpan('parent')..end();

    trace('child', () async {
      final child = spanFromContext(Context.current);

      expect(child.parentSpanId.toString(),
          equals(parent.spanContext.spanId.toString()));
    }, tracer: tracer, context: contextWithSpan(Context.current, parent));
  });

  test('traceSync propagates context', () {
    final parent = tracer.startSpan('parent')..end();

    traceSync('span', () {
      final child = spanFromContext(Context.current);

      expect(child.parentSpanId.toString(),
          equals(parent.spanContext.spanId.toString()));
    }, tracer: tracer, context: contextWithSpan(Context.current, parent));
  });

  test('trace catches, records, and rethrows exception', () async {
    late sdk.Span span;
    var caught = false;
    try {
      await trace('span', () async {
        span = spanFromContext(Context.current) as sdk.Span;
        throw Exception('Bang!');
      }, tracer: tracer);
    } catch (e) {
      caught = true;
    } finally {
      expect(caught, isTrue);
      expect(span.endTime, isNotNull);
      expect(span.status.code, equals(StatusCode.error));
      expect(span.status.description, equals('Exception: Bang!'));
      expect(span.events, [
        hasExceptionEvent({
          SemanticAttributes.exceptionType: '_Exception',
          SemanticAttributes.exceptionMessage: 'Exception: Bang!',
          SemanticAttributes.exceptionStacktrace: anything,
          SemanticAttributes.exceptionEscaped: true,
        })
      ]);
    }
  });

  test('traceSync catches, records, and rethrows exception', () async {
    late sdk.Span span;
    var caught = false;
    try {
      traceSync('span', () {
        span = spanFromContext(Context.current) as sdk.Span;
        throw Exception('Bang!');
      }, tracer: tracer);
    } catch (e) {
      caught = true;
    } finally {
      expect(caught, isTrue);
      expect(span.endTime, isNotNull);
      expect(span.status.code, equals(StatusCode.error));
      expect(span.status.description, equals('Exception: Bang!'));
      expect(span.events, [
        hasExceptionEvent({
          SemanticAttributes.exceptionType: '_Exception',
          SemanticAttributes.exceptionMessage: 'Exception: Bang!',
          SemanticAttributes.exceptionStacktrace: anything,
          SemanticAttributes.exceptionEscaped: true,
        })
      ]);
    }
  });
}

Matcher hasExceptionEvent(Map<String, Object> attributes) =>
    isA<SpanEvent>().having(
        (e) => e.attributes,
        'attributes',
        isA<Iterable<Attribute>>().having(
            (a) => a.map((e) => [e.key, e.value]),
            'attributes',
            containsAll(attributes.entries.map((e) => [e.key, e.value]))));
