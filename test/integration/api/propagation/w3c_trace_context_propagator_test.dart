// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/experimental_api.dart';
import 'package:opentelemetry/src/sdk/trace/span.dart';
import 'package:test/test.dart';

class TestingInjector implements api.TextMapSetter<Map<String, String>> {
  @override
  void set(Map<String, String> carrier, String key, String value) {
    carrier[key] = value;
  }
}

class TestingExtractor implements api.TextMapGetter<Map<String, String>> {
  @override
  String? get(Map<String, String> carrier, String key) {
    return carrier[key];
  }

  @override
  Iterable<String> keys(Map<String, String> carrier) {
    return carrier.keys;
  }
}

void main() {
  test('inject and extract trace context', () {
    final testSpan = Span(
        'TestSpan',
        api.SpanContext(
            api.TraceId.fromString('4bf92f3577b34da6a3ce929d0e0e4736'),
            api.SpanId.fromString('0000000000c0ffee'),
            api.TraceFlags.sampled,
            api.TraceState.fromString(
                'rojo=00f067aa0ba902b7,congo=t61rcWkgMzE')),
        api.SpanId.fromString('00f067aa0ba902b7'),
        [],
        sdk.DateTimeTimeProvider(),
        sdk.Resource([]),
        sdk.InstrumentationScope(
            'library_name', 'library_version', 'url://schema', []),
        api.SpanKind.client,
        [],
        sdk.SpanLimits(),
        sdk.DateTimeTimeProvider().now);
    final testPropagator = api.W3CTraceContextPropagator();
    final testCarrier = <String, String>{};
    final testContext =
        api.contextWithSpan(globalContextManager.active, testSpan);

    testPropagator.inject(testContext, testCarrier, TestingInjector());
    final resultSpan = api.spanFromContext(
        testPropagator.extract(testContext, testCarrier, TestingExtractor()));

    expect(resultSpan.parentSpanId.toString(), equals('0000000000000000'));
    expect(resultSpan.spanContext.isValid, isTrue);
    expect(
        resultSpan.spanContext.spanId.toString(), equals('0000000000c0ffee'));
    expect(resultSpan.spanContext.traceId.toString(),
        equals('4bf92f3577b34da6a3ce929d0e0e4736'));
    expect(resultSpan.spanContext.traceFlags, equals(api.TraceFlags.sampled));
    expect(resultSpan.spanContext.traceState.toString(),
        equals('rojo=00f067aa0ba902b7,congo=t61rcWkgMzE'));
  });

  test('inject and extract invalid trace parent', () {
    final testSpan = Span(
        'TestSpan',
        api.SpanContext(
            api.TraceId.fromString('00000000000000000000000000000000'),
            api.SpanId.fromString('0000000000c0ffee'),
            api.TraceFlags.none,
            api.TraceState.fromString(
                'rojo=00f067aa0ba902b7,congo=t61rcWkgMzE')),
        api.SpanId.fromString('0000000000000000'),
        [],
        sdk.DateTimeTimeProvider(),
        sdk.Resource([]),
        sdk.InstrumentationScope(
            'library_name', 'library_version', 'url://schema', []),
        api.SpanKind.client,
        [],
        sdk.SpanLimits(),
        sdk.DateTimeTimeProvider().now);
    final testPropagator = api.W3CTraceContextPropagator();
    final testCarrier = <String, String>{};
    final testContext =
        api.contextWithSpan(globalContextManager.active, testSpan);

    testPropagator.inject(testContext, testCarrier, TestingInjector());
    final resultSpan = api.spanFromContext(
        testPropagator.extract(testContext, testCarrier, TestingExtractor()));

    expect(resultSpan.parentSpanId.toString(), equals('0000000000000000'));
    expect(resultSpan.spanContext.isValid, isFalse);
    expect(
        resultSpan.spanContext.spanId.toString(), equals('0000000000c0ffee'));
    expect(resultSpan.spanContext.traceId.toString(),
        equals('00000000000000000000000000000000'));
    expect(resultSpan.spanContext.traceFlags, equals(api.TraceFlags.none));
    expect(resultSpan.spanContext.traceState.toString(),
        equals('rojo=00f067aa0ba902b7,congo=t61rcWkgMzE'));
  });

  test('extract and inject with child span', () {
    final testSpan = Span(
        'TestSpan',
        api.SpanContext(
            api.TraceId.fromString('4bf92f3577b34da6a3ce929d0e0e4736'),
            api.SpanId.fromString('0000000000c0ffee'),
            api.TraceFlags.sampled,
            api.TraceState.fromString(
                'rojo=00f067aa0ba902b7,congo=t61rcWkgMzE')),
        api.SpanId.fromString('00f067aa0ba902b7'),
        [],
        sdk.DateTimeTimeProvider(),
        sdk.Resource([]),
        sdk.InstrumentationScope(
            'library_name', 'library_version', 'url://schema', []),
        api.SpanKind.client,
        [],
        sdk.SpanLimits(),
        sdk.DateTimeTimeProvider().now);
    final tracer = sdk.TracerProviderBase(processors: [])
        .getTracer('appName', version: '1.0.0');
    final testPropagator = api.W3CTraceContextPropagator();
    final testCarrier = <String, String>{};

    // Inject and extract a test Span from a Context, as when an outbound
    // call is made and received by another service.
    final testContext =
        api.contextWithSpan(globalContextManager.active, testSpan);
    testPropagator.inject(testContext, testCarrier, TestingInjector());
    final parentSpan = api.spanFromContext(
        testPropagator.extract(testContext, testCarrier, TestingExtractor()));

    expect(parentSpan, isNotNull);

    // Use the transmitted Span as a receiver.
    final resultSpan = tracer.startSpan('doWork',
        context: api.contextWithSpan(globalContextManager.active, testSpan))
      ..end();

    // Verify that data from the original Span propagates to the child.
    expect(resultSpan.parentSpanId.toString(),
        testSpan.spanContext.spanId.toString());
    expect(resultSpan.spanContext.traceId.toString(),
        equals(testSpan.spanContext.traceId.toString()));
    expect(resultSpan.spanContext.traceState.toString(),
        equals(testSpan.spanContext.traceState.toString()));
    expect(resultSpan.spanContext.traceFlags.toString(),
        equals(testSpan.spanContext.traceFlags.toString()));
  });
}
