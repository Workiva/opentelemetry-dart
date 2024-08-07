// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'dart:async';

import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/api/trace/span_event.dart';
import 'package:opentelemetry/src/sdk/trace/span.dart';
import 'package:opentelemetry/src/sdk/trace/tracer.dart';
import 'package:test/test.dart';

void main() {
  test('trace synchronous execution', () {
    final tracer = Tracer([],
        sdk.Resource([]),
        sdk.AlwaysOnSampler(),
        sdk.DateTimeTimeProvider(),
        sdk.IdGenerator(),
        sdk.InstrumentationScope('name', 'version', 'url://schema', []),
        sdk.SpanLimits());
    late Span span;

    api.traceContextSync('syncTrace', (context) {
      span = api.spanFromContext(context) as Span;
    }, tracer: tracer);

    expect(span, isNotNull);
    expect(
        span.endTime,
        lessThan(DateTime.now().microsecondsSinceEpoch *
            sdk.TimeProvider.nanosecondsPerMicrosecond));
  });

  test('trace synchronous looped execution timing', () {
    final tracer = Tracer([],
        sdk.Resource([]),
        sdk.AlwaysOnSampler(),
        sdk.DateTimeTimeProvider(),
        sdk.IdGenerator(),
        sdk.InstrumentationScope('name', 'version', 'url://schema', []),
        sdk.SpanLimits());
    final spans = <Span>[];

    for (var i = 0; i < 5; i++) {
      api.traceContextSync('syncTrace', (context) {
        spans.add(api.spanFromContext(context) as Span);
      }, tracer: tracer);
    }

    for (var i = 1; i < spans.length; i++) {
      expect(spans[i].endTime, isNotNull);
      expect(spans[i].startTime, greaterThan(spans[i - 1].startTime));
      expect(spans[i].endTime, greaterThan(spans[i - 1].endTime!));
    }
  });

  test('trace synchronous execution with error', () {
    final tracer = Tracer([],
        sdk.Resource([]),
        sdk.AlwaysOnSampler(),
        sdk.DateTimeTimeProvider(),
        sdk.IdGenerator(),
        sdk.InstrumentationScope('name', 'version', 'url://schema', []),
        sdk.SpanLimits());
    late Span span;

    expect(
        () => api.traceContextSync('syncTrace', (context) {
              span = api.spanFromContext(context) as Span;
              throw Exception('Oh noes!');
            }, tracer: tracer),
        throwsException);
    expect(span.endTime, isNotNull);
    expect(span.status.code, equals(api.StatusCode.error));
    expect(span.status.description, equals('Exception: Oh noes!'));
    expect(span.events, [
      hasExceptionEvent({
        api.SemanticAttributes.exceptionType: '_Exception',
        api.SemanticAttributes.exceptionMessage: 'Exception: Oh noes!',
        api.SemanticAttributes.exceptionStacktrace: anything,
        api.SemanticAttributes.exceptionEscaped: true,
      })
    ]);
  });

  test('trace asynchronous execution', () async {
    final tracer = Tracer([],
        sdk.Resource([]),
        sdk.AlwaysOnSampler(),
        sdk.DateTimeTimeProvider(),
        sdk.IdGenerator(),
        sdk.InstrumentationScope('name', 'version', 'url://schema', []),
        sdk.SpanLimits());
    late Span span;

    await api.traceContext('asyncTrace', (context) async {
      span = api.spanFromContext(context) as Span;
    }, tracer: tracer);

    expect(
        span.endTime,
        lessThan(DateTime.now().microsecondsSinceEpoch *
            sdk.TimeProvider.nanosecondsPerMicrosecond));
  });

  test('trace asynchronous looped execution timing', () async {
    final tracer = Tracer([],
        sdk.Resource([]),
        sdk.AlwaysOnSampler(),
        sdk.DateTimeTimeProvider(),
        sdk.IdGenerator(),
        sdk.InstrumentationScope('name', 'version', 'url://schema', []),
        sdk.SpanLimits());
    final spans = <Span>[];

    for (var i = 0; i < 5; i++) {
      await api.traceContext('asyncTrace', (context) async {
        spans.add(api.spanFromContext(context) as Span);
      }, tracer: tracer);
    }

    for (var i = 1; i < spans.length; i++) {
      expect(spans[1].endTime, isNotNull);
      expect(spans[i].startTime, greaterThan(spans[i - 1].startTime));
      expect(spans[i].endTime, greaterThan(spans[i - 1].endTime!));
    }
  });

  test('trace asynchronous execution with thrown error', () async {
    final tracer = Tracer([],
        sdk.Resource([]),
        sdk.AlwaysOnSampler(),
        sdk.DateTimeTimeProvider(),
        sdk.IdGenerator(),
        sdk.InstrumentationScope('name', 'version', 'url://schema', []),
        sdk.SpanLimits());
    late Span span;

    try {
      await api.traceContext('asyncTrace', (context) async {
        span = api.spanFromContext(context) as Span;
        throw Exception('Oh noes!');
      }, tracer: tracer);
    } catch (e) {
      expect(e.toString(), equals('Exception: Oh noes!'));
    }
    expect(span, isNotNull);
    expect(span.endTime, isNotNull);
    expect(span.status.code, equals(api.StatusCode.error));
    expect(span.status.description, equals('Exception: Oh noes!'));
    expect(span.events, [
      hasExceptionEvent({
        api.SemanticAttributes.exceptionType: '_Exception',
        api.SemanticAttributes.exceptionMessage: 'Exception: Oh noes!',
        api.SemanticAttributes.exceptionStacktrace: anything,
        api.SemanticAttributes.exceptionEscaped: true,
      })
    ]);
  });

  test('trace asynchronous execution completes with error', () async {
    final tracer = Tracer([],
        sdk.Resource([]),
        sdk.AlwaysOnSampler(),
        sdk.DateTimeTimeProvider(),
        sdk.IdGenerator(),
        sdk.InstrumentationScope('name', 'version', 'url://schema', []),
        sdk.SpanLimits());
    late Span span;

    try {
      await api.traceContext('asyncTrace', (context) async {
        span = api.spanFromContext(context) as Span;
        return Future.error(Exception('Oh noes!'));
      }, tracer: tracer);
    } catch (e) {
      expect(e.toString(), equals('Exception: Oh noes!'));
    }
    expect(span, isNotNull);
    expect(span.endTime, isNotNull);
    expect(span.status.code, equals(api.StatusCode.error));
    expect(span.status.description, equals('Exception: Oh noes!'));
    expect(span.events, [
      hasExceptionEvent({
        api.SemanticAttributes.exceptionType: '_Exception',
        api.SemanticAttributes.exceptionMessage: 'Exception: Oh noes!',
        api.SemanticAttributes.exceptionStacktrace: anything,
        api.SemanticAttributes.exceptionEscaped: true,
      })
    ]);
  });
}

Matcher hasExceptionEvent(Map<String, Object> attributes) =>
    isA<SpanEvent>().having(
        (e) => e.attributes,
        'attributes',
        isA<Iterable<api.Attribute>>().having(
            (a) => a.map((e) => [e.key, e.value]),
            'attributes',
            containsAll(attributes.entries.map((e) => [e.key, e.value]))));
