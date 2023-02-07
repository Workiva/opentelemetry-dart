// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'dart:async';

import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
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
        sdk.InstrumentationLibrary('name', 'version'));
    Span? span;

    api.traceSync('syncTrace', () {
      span = api.Context.current.span as Span?;
    }, tracer: tracer);

    expect(
        span!.endTime,
        lessThan(DateTime.now().microsecondsSinceEpoch *
            sdk.TimeProvider.nanosecondsPerMicrosecond));
  });

  test('trace synchronous looped execution timing', () {
    final tracer = Tracer([],
        sdk.Resource([]),
        sdk.AlwaysOnSampler(),
        sdk.DateTimeTimeProvider(),
        sdk.IdGenerator(),
        sdk.InstrumentationLibrary('name', 'version'));
    final spans = <Span?>[];

    for (var i = 0; i < 5; i++) {
      api.traceSync('syncTrace', () {
        spans.add(api.Context.current.span as Span?);
      }, tracer: tracer);
    }

    for (var i = 1; i < spans.length; i++) {
      expect(spans[i]!.startTime, greaterThan(spans[i - 1]!.startTime));
      expect(spans[i]!.endTime, greaterThan(spans[i - 1]!.endTime!));
    }
  });

  test('trace synchronous execution with error', () {
    final tracer = Tracer([],
        sdk.Resource([]),
        sdk.AlwaysOnSampler(),
        sdk.DateTimeTimeProvider(),
        sdk.IdGenerator(),
        sdk.InstrumentationLibrary('name', 'version'));
    Span? span;

    expect(
        () => api.traceSync('syncTrace', () {
              span = api.Context.current.span as Span?;
              throw Exception('Oh noes!');
            }, tracer: tracer),
        throwsException);
    expect(span!.endTime, isNotNull);
    expect(span!.status.code, equals(api.StatusCode.error));
    expect(span!.status.description, equals('Exception: Oh noes!'));
    expect(span!.attributes.get(api.SemanticAttributes.exceptionType),
        equals('_Exception'));
    expect(span!.attributes.get(api.SemanticAttributes.exceptionMessage),
        equals('Exception: Oh noes!'));
  });

  test('trace asynchronous execution', () async {
    final tracer = Tracer([],
        sdk.Resource([]),
        sdk.AlwaysOnSampler(),
        sdk.DateTimeTimeProvider(),
        sdk.IdGenerator(),
        sdk.InstrumentationLibrary('name', 'version'));
    Span? span;

    await api.trace('asyncTrace', () async {
      span = api.Context.current.span as Span?;
    }, tracer: tracer);

    expect(
        span!.endTime,
        lessThan(DateTime.now().microsecondsSinceEpoch *
            sdk.TimeProvider.nanosecondsPerMicrosecond));
  });

  test('trace asynchronous looped execution timing', () async {
    final tracer = Tracer([],
        sdk.Resource([]),
        sdk.AlwaysOnSampler(),
        sdk.DateTimeTimeProvider(),
        sdk.IdGenerator(),
        sdk.InstrumentationLibrary('name', 'version'));
    final spans = <Span?>[];

    for (var i = 0; i < 5; i++) {
      await api.trace('asyncTrace', () async {
        spans.add(api.Context.current.span as Span?);
      }, tracer: tracer);
    }

    for (var i = 1; i < spans.length; i++) {
      expect(spans[i]!.startTime, greaterThan(spans[i - 1]!.startTime));
      expect(spans[i]!.endTime, greaterThan(spans[i - 1]!.endTime!));
    }
  });

  test('trace asynchronous execution with thrown error', () async {
    final tracer = Tracer([],
        sdk.Resource([]),
        sdk.AlwaysOnSampler(),
        sdk.DateTimeTimeProvider(),
        sdk.IdGenerator(),
        sdk.InstrumentationLibrary('name', 'version'));
    Span? span;

    try {
      await api.trace('asyncTrace', () async {
        span = api.Context.current.span as Span?;
        throw Exception('Oh noes!');
      }, tracer: tracer);
    } catch (e) {
      expect(e.toString(), equals('Exception: Oh noes!'));
    }
    expect(span!.endTime, isNotNull);
    expect(span!.status.code, equals(api.StatusCode.error));
    expect(span!.status.description, equals('Exception: Oh noes!'));
    expect(span!.attributes.get(api.SemanticAttributes.exceptionType),
        equals('_Exception'));
    expect(span!.attributes.get(api.SemanticAttributes.exceptionMessage),
        equals('Exception: Oh noes!'));
  });

  test('trace asynchronous execution completes with error', () async {
    final tracer = Tracer([],
        sdk.Resource([]),
        sdk.AlwaysOnSampler(),
        sdk.DateTimeTimeProvider(),
        sdk.IdGenerator(),
        sdk.InstrumentationLibrary('name', 'version'));
    Span? span;

    try {
      await api.trace('asyncTrace', () async {
        span = api.Context.current.span as Span?;
        return Future.error(Exception('Oh noes!'));
      }, tracer: tracer);
    } catch (e) {
      expect(e.toString(), equals('Exception: Oh noes!'));
    }

    expect(span!.endTime, isNotNull);
    expect(span!.status.code, equals(api.StatusCode.error));
    expect(span!.status.description, equals('Exception: Oh noes!'));
    expect(span!.attributes.get(api.SemanticAttributes.exceptionType),
        equals('_Exception'));
    expect(span!.attributes.get(api.SemanticAttributes.exceptionMessage),
        equals('Exception: Oh noes!'));
  });
}
