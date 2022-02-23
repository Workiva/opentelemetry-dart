import 'dart:async';
import 'dart:io';

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

  test('traceSync execution timing', () {
    final tracer = sdk.Tracer([],
        sdk.Resource(api.Attributes.empty()),
        sdk.AlwaysOnSampler(),
        sdk.IdGenerator(),
        sdk.InstrumentationLibrary('name', 'version'));
    final startTime = DateTime.now();
    final waitDuration = Duration(seconds: 1);
    Duration traceCallbackDuration;
    sdk.Span span;

    tracer.traceSync('syncTrace', () {
      span = api.Context.current.span;
      sleep(waitDuration);
      traceCallbackDuration = DateTime.now().difference(startTime);
    }, context: api.Context.root);
    final traceExecutionDuration = DateTime.now().difference(startTime);

    expect(traceExecutionDuration, greaterThan(traceCallbackDuration));
    expect(traceExecutionDuration, greaterThan(waitDuration));
    expect((span.endTime - span.startTime).toInt() / 1000000,
        closeTo(waitDuration.inSeconds, 0.02));
  });

  test('traceSync looped execution timing', () {
    final tracer = sdk.Tracer([],
        sdk.Resource(api.Attributes.empty()),
        sdk.AlwaysOnSampler(),
        sdk.IdGenerator(),
        sdk.InstrumentationLibrary('name', 'version'));
    final waitDuration = Duration(seconds: 1);
    final spans = <sdk.Span>[];

    for (var i = 0; i < 5; i++) {
      tracer.traceSync('syncTrace', () {
        spans.add(api.Context.current.span);
        sleep(waitDuration);
      });
    }

    for (final span in spans) {
      expect((span.endTime - span.startTime).toInt() / 1000000,
          closeTo(waitDuration.inSeconds, 0.02));
    }
  });

  test('traceSync execution with error', () {
    final tracer = sdk.Tracer([],
        sdk.Resource(api.Attributes.empty()),
        sdk.AlwaysOnSampler(),
        sdk.IdGenerator(),
        sdk.InstrumentationLibrary('name', 'version'));
    sdk.Span span;

    expect(
        () => tracer.traceSync('syncTrace', () {
              span = api.Context.current.span;
              throw Exception('Oh noes!');
            }, context: api.Context.root),
        throwsException);
    expect(span.endTime, isNotNull);
    expect(span.status.code, equals(api.StatusCode.error));
    expect(span.status.description, equals('Exception: Oh noes!'));
    expect(span.attributes.get('error'), isTrue);
    expect(span.attributes.get('exception'), equals('Exception: Oh noes!'));
  });

  test('traceAsync execution timing', () async {
    final tracer = sdk.Tracer([],
        sdk.Resource(api.Attributes.empty()),
        sdk.AlwaysOnSampler(),
        sdk.IdGenerator(),
        sdk.InstrumentationLibrary('name', 'version'));
    final startTime = DateTime.now();
    final waitDuration = Duration(seconds: 1);
    Duration traceCallbackDuration;
    sdk.Span span;

    final asyncTrace = tracer.traceAsync('asyncTrace', () async {
      span = api.Context.current.span;
      await Future.delayed(waitDuration);
      traceCallbackDuration = DateTime.now().difference(startTime);
    }, context: api.Context.root);
    final traceRegistrationDuration = DateTime.now().difference(startTime);
    await asyncTrace;

    expect(traceRegistrationDuration, lessThan(traceCallbackDuration));
    expect(traceRegistrationDuration, lessThan(waitDuration));
    expect((span.endTime - span.startTime).toInt() / 1000000,
        closeTo(waitDuration.inSeconds, 0.02));
  });

  test('traceAsync looped execution timing', () async {
    final tracer = sdk.Tracer([],
        sdk.Resource(api.Attributes.empty()),
        sdk.AlwaysOnSampler(),
        sdk.IdGenerator(),
        sdk.InstrumentationLibrary('name', 'version'));
    final spans = <sdk.Span>[];

    for (var i = 0; i < 5; i++) {
      await tracer.traceAsync('asyncTrace', () async {
        spans.add(api.Context.current.span);
        await Future.delayed(Duration(seconds: 1));
      });
    }

    for (final span in spans) {
      expect(
          (span.endTime - span.startTime).toInt() / 1000000, closeTo(1, 0.02));
    }
  });

  test('traceAsync execution with thrown error', () async {
    final tracer = sdk.Tracer([],
        sdk.Resource(api.Attributes.empty()),
        sdk.AlwaysOnSampler(),
        sdk.IdGenerator(),
        sdk.InstrumentationLibrary('name', 'version'));
    sdk.Span span;

    try {
      await tracer.traceAsync('asyncTrace', () async {
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

  test('traceAsync execution completes with error', () async {
    final tracer = sdk.Tracer([],
        sdk.Resource(api.Attributes.empty()),
        sdk.AlwaysOnSampler(),
        sdk.IdGenerator(),
        sdk.InstrumentationLibrary('name', 'version'));
    sdk.Span span;

    try {
      await tracer.traceAsync('asyncTrace', () async {
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
