import 'dart:async';

import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:test/test.dart';

void main() {
  test('startSpan new trace', () {
    final tracer = sdk.Tracer([],
        sdk.Resource(api.Attributes.empty()),
        sdk.AlwaysOnSampler(),
        sdk.IdGenerator(),
        sdk.InstrumentationLibrary('name', 'version'));

    final span = tracer.startSpan('foo');

    expect(span.startTime, isNotNull);
    expect(span.endTime, isNull);
    expect(span.spanContext.traceId, isNotNull);
    expect(span.spanContext.spanId, isNotNull);
  });

  test('startSpan child span', () {
    final tracer = sdk.Tracer([],
        sdk.Resource(api.Attributes.empty()),
        sdk.AlwaysOnSampler(),
        sdk.IdGenerator(),
        sdk.InstrumentationLibrary('name', 'version'));

    final parentSpan = tracer.startSpan('foo');
    final context = api.Context.current.withSpan(parentSpan);

    final childSpan = tracer.startSpan('bar', context: context);

    expect(childSpan.startTime, isNotNull);
    expect(childSpan.endTime, isNull);
    expect(
        childSpan.spanContext.traceId, equals(parentSpan.spanContext.traceId));
    expect(childSpan.spanContext.traceState,
        equals(parentSpan.spanContext.traceState));
    expect(childSpan.spanContext.spanId,
        allOf([isNotNull, isNot(equals(parentSpan.spanContext.spanId))]));
  });

  test('trace synchronous execution', () {
    final tracer = sdk.Tracer([],
        sdk.Resource(api.Attributes.empty()),
        sdk.AlwaysOnSampler(),
        sdk.IdGenerator(),
        sdk.InstrumentationLibrary('name', 'version'));
    sdk.Span span;

    tracer.trace('syncTrace', () {
      span = api.Context.current.span;
    });

    expect(span.endTime, lessThan(DateTime.now().microsecondsSinceEpoch));
  });

  test('trace synchronous looped execution timing', () {
    final tracer = sdk.Tracer([],
        sdk.Resource(api.Attributes.empty()),
        sdk.AlwaysOnSampler(),
        sdk.IdGenerator(),
        sdk.InstrumentationLibrary('name', 'version'));
    final spans = <sdk.Span>[];

    for (var i = 0; i < 5; i++) {
      tracer.trace('syncTrace', () {
        spans.add(api.Context.current.span);
      });
    }

    for (var i = 1; i < spans.length; i++) {
      expect(spans[i].startTime, greaterThan(spans[i - 1].startTime));
      expect(spans[i].endTime, greaterThan(spans[i - 1].endTime));
    }
  });

  test('trace synchronous execution with error', () {
    final tracer = sdk.Tracer([],
        sdk.Resource(api.Attributes.empty()),
        sdk.AlwaysOnSampler(),
        sdk.IdGenerator(),
        sdk.InstrumentationLibrary('name', 'version'));
    sdk.Span span;

    expect(
        () => tracer.trace('syncTrace', () {
              span = api.Context.current.span;
              throw Exception('Oh noes!');
            }),
        throwsException);
    expect(span.endTime, isNotNull);
    expect(span.status.code, equals(api.StatusCode.error));
    expect(span.status.description, equals('Exception: Oh noes!'));
    expect(span.attributes.get('error'), isTrue);
    expect(span.attributes.get('exception'), equals('Exception: Oh noes!'));
  });

  test('trace asynchronous execution', () async {
    final tracer = sdk.Tracer([],
        sdk.Resource(api.Attributes.empty()),
        sdk.AlwaysOnSampler(),
        sdk.IdGenerator(),
        sdk.InstrumentationLibrary('name', 'version'));
    sdk.Span span;

    await tracer.trace('asyncTrace', () async {
      span = api.Context.current.span;
    });

    expect(span.endTime, lessThan(DateTime.now().microsecondsSinceEpoch));
  });

  test('trace asynchronous looped execution timing', () async {
    final tracer = sdk.Tracer([],
        sdk.Resource(api.Attributes.empty()),
        sdk.AlwaysOnSampler(),
        sdk.IdGenerator(),
        sdk.InstrumentationLibrary('name', 'version'));
    final spans = <sdk.Span>[];

    for (var i = 0; i < 5; i++) {
      await tracer.trace('asyncTrace', () async {
        spans.add(api.Context.current.span);
      });
    }

    for (var i = 1; i < spans.length; i++) {
      expect(spans[i].startTime, greaterThan(spans[i - 1].startTime));
      expect(spans[i].endTime, greaterThan(spans[i - 1].endTime));
    }
  });

  test('trace asynchronous execution with thrown error', () async {
    final tracer = sdk.Tracer([],
        sdk.Resource(api.Attributes.empty()),
        sdk.AlwaysOnSampler(),
        sdk.IdGenerator(),
        sdk.InstrumentationLibrary('name', 'version'));
    sdk.Span span;

    try {
      await tracer.trace('asyncTrace', () async {
        span = api.Context.current.span;
        throw Exception('Oh noes!');
      });
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
    final tracer = sdk.Tracer([],
        sdk.Resource(api.Attributes.empty()),
        sdk.AlwaysOnSampler(),
        sdk.IdGenerator(),
        sdk.InstrumentationLibrary('name', 'version'));
    sdk.Span span;

    try {
      await tracer.trace('asyncTrace', () async {
        span = api.Context.current.span;
        return Future.error(Exception('Oh noes!'));
      });
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
