import 'dart:async';

import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:test/test.dart';

void main() {
  test('trace synchronous execution', () {
    final tracer = sdk.Tracer([], sdk.Resource([]), sdk.AlwaysOnSampler(),
        sdk.IdGenerator(), sdk.InstrumentationLibrary('name', 'version'));
    sdk.Span span;

    sdk.trace('syncTrace', () {
      span = api.Context.current.span;
    }, tracer: tracer);

    expect(span.endTime, lessThan(DateTime.now().microsecondsSinceEpoch));
  });

  test('trace synchronous looped execution timing', () {
    final tracer = sdk.Tracer([], sdk.Resource([]), sdk.AlwaysOnSampler(),
        sdk.IdGenerator(), sdk.InstrumentationLibrary('name', 'version'));
    final spans = <sdk.Span>[];

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
    final tracer = sdk.Tracer([], sdk.Resource([]), sdk.AlwaysOnSampler(),
        sdk.IdGenerator(), sdk.InstrumentationLibrary('name', 'version'));
    sdk.Span span;

    expect(
        () => sdk.trace('syncTrace', () {
              span = api.Context.current.span;
              throw Exception('Oh noes!');
            }, tracer: tracer),
        throwsException);
    expect(span.endTime, isNotNull);
    expect(span.status.code, equals(api.StatusCode.error));
    expect(span.status.description, equals('Exception: Oh noes!'));
    expect(span.attributes.get('error'), isTrue);
    expect(span.attributes.get('exception'), equals('Exception: Oh noes!'));
  });

  test('trace asynchronous execution', () async {
    final tracer = sdk.Tracer([], sdk.Resource([]), sdk.AlwaysOnSampler(),
        sdk.IdGenerator(), sdk.InstrumentationLibrary('name', 'version'));
    sdk.Span span;

    await sdk.trace('asyncTrace', () async {
      span = api.Context.current.span;
    }, tracer: tracer);

    expect(span.endTime, lessThan(DateTime.now().microsecondsSinceEpoch));
  });

  test('trace asynchronous looped execution timing', () async {
    final tracer = sdk.Tracer([], sdk.Resource([]), sdk.AlwaysOnSampler(),
        sdk.IdGenerator(), sdk.InstrumentationLibrary('name', 'version'));
    final spans = <sdk.Span>[];

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
    final tracer = sdk.Tracer([], sdk.Resource([]), sdk.AlwaysOnSampler(),
        sdk.IdGenerator(), sdk.InstrumentationLibrary('name', 'version'));
    sdk.Span span;

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
    expect(span.attributes.get('error'), isTrue);
    expect(span.attributes.get('exception'), equals('Exception: Oh noes!'));
  });

  test('trace asynchronous execution completes with error', () async {
    final tracer = sdk.Tracer([], sdk.Resource([]), sdk.AlwaysOnSampler(),
        sdk.IdGenerator(), sdk.InstrumentationLibrary('name', 'version'));
    sdk.Span span;

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
    expect(span.attributes.get('error'), isTrue);
    expect(span.attributes.get('exception'), equals('Exception: Oh noes!'));
  });
}
