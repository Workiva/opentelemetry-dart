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
    Span span;

    sdk.trace('syncTrace', () {
      span = api.Context.current.span;
    }, tracer: tracer);

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
        sdk.InstrumentationLibrary('name', 'version'));
    final spans = <Span>[];

    for (var i = 0; i < 5; i++) {
      sdk.trace('syncTrace', () {
        spans.add(api.Context.current.span);
      }, tracer: tracer);
    }

    for (var i = 1; i < spans.length; i++) {
      expect(spans[i].startTime, greaterThan(spans[i - 1].startTime));
      expect(spans[i].endTime, greaterThan(spans[i - 1].endTime));
    }
  });

  test('trace synchronous execution with error', () {
    final tracer = Tracer([],
        sdk.Resource([]),
        sdk.AlwaysOnSampler(),
        sdk.DateTimeTimeProvider(),
        sdk.IdGenerator(),
        sdk.InstrumentationLibrary('name', 'version'));
    Span span;

    expect(
        () => sdk.trace('syncTrace', () {
              span = api.Context.current.span;
              throw Exception('Oh noes!');
            }, tracer: tracer),
        throwsException);
    expect(span.endTime, isNotNull);
    expect(span.status.code, equals(api.StatusCode.error));
    expect(span.status.description, equals('Exception: Oh noes!'));
    expect(span.attributes.get('exception.type'), equals('_Exception'));
    expect(span.attributes.get('exception.message'),
        equals('Exception: Oh noes!'));
  });

  test('trace asynchronous execution', () async {
    final tracer = Tracer([],
        sdk.Resource([]),
        sdk.AlwaysOnSampler(),
        sdk.DateTimeTimeProvider(),
        sdk.IdGenerator(),
        sdk.InstrumentationLibrary('name', 'version'));
    Span span;

    await sdk.trace('asyncTrace', () async {
      span = api.Context.current.span;
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
        sdk.InstrumentationLibrary('name', 'version'));
    final spans = <Span>[];

    for (var i = 0; i < 5; i++) {
      await sdk.trace('asyncTrace', () async {
        spans.add(api.Context.current.span);
      }, tracer: tracer);
    }

    for (var i = 1; i < spans.length; i++) {
      expect(spans[i].startTime, greaterThan(spans[i - 1].startTime));
      expect(spans[i].endTime, greaterThan(spans[i - 1].endTime));
    }
  });

  test('trace asynchronous execution with thrown error', () async {
    final tracer = Tracer([],
        sdk.Resource([]),
        sdk.AlwaysOnSampler(),
        sdk.DateTimeTimeProvider(),
        sdk.IdGenerator(),
        sdk.InstrumentationLibrary('name', 'version'));
    Span span;

    try {
      await sdk.trace('asyncTrace', () async {
        span = api.Context.current.span;
        throw Exception('Oh noes!');
      }, tracer: tracer);
    } catch (e) {
      expect(e.toString(), equals('Exception: Oh noes!'));
    }
    expect(span.endTime, isNotNull);
    expect(span.status.code, equals(api.StatusCode.error));
    expect(span.status.description, equals('Exception: Oh noes!'));
    expect(span.attributes.get('exception.type'), equals('_Exception'));
    expect(span.attributes.get('exception.message'),
        equals('Exception: Oh noes!'));
  });

  test('trace asynchronous execution completes with error', () async {
    final tracer = Tracer([],
        sdk.Resource([]),
        sdk.AlwaysOnSampler(),
        sdk.DateTimeTimeProvider(),
        sdk.IdGenerator(),
        sdk.InstrumentationLibrary('name', 'version'));
    Span span;

    try {
      await sdk.trace('asyncTrace', () async {
        span = api.Context.current.span;
        return Future.error(Exception('Oh noes!'));
      }, tracer: tracer);
    } catch (e) {
      expect(e.toString(), equals('Exception: Oh noes!'));
    }

    expect(span.endTime, isNotNull);
    expect(span.status.code, equals(api.StatusCode.error));
    expect(span.status.description, equals('Exception: Oh noes!'));
    expect(span.attributes.get('exception.type'), equals('_Exception'));
    expect(span.attributes.get('exception.message'),
        equals('Exception: Oh noes!'));
  });
}
