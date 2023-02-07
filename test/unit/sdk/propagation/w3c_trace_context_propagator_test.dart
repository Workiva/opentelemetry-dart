// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/sdk/instrumentation_library.dart';
import 'package:opentelemetry/src/sdk/resource/resource.dart';
import 'package:opentelemetry/src/sdk/trace/propagation/w3c_trace_context_propagator.dart';
import 'package:opentelemetry/src/sdk/trace/span.dart';
import 'package:opentelemetry/src/sdk/trace/span_context.dart';
import 'package:opentelemetry/src/sdk/trace/trace_state.dart';
import 'package:test/test.dart';

class TestingInjector implements api.TextMapSetter<Map> {
  @override
  void set(Map carrier, String key, String value) {
    carrier[key] = value;
  }
}

class TestingExtractor implements api.TextMapGetter<Map> {
  @override
  String? get(Map carrier, String key) {
    return carrier[key];
  }

  @override
  Iterable<String> keys(Map carrier) {
    return carrier.keys as Iterable<String>;
  }
}

void main() {
  test('extract trace context', () {
    final testPropagator = W3CTraceContextPropagator();
    final testCarrier = {};

    TestingInjector()
      ..set(testCarrier, 'traceparent',
          '00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01')
      ..set(
          testCarrier, 'tracestate', 'rojo=00f067aa0ba902b7,congo=t61rcWkgMzE');
    final resultContext = testPropagator.extract(
        api.Context.current, testCarrier, TestingExtractor());
    final resultSpan = resultContext.span!;

    expect(resultSpan.parentSpanId.toString(), equals('0000000000000000'));
    expect(resultSpan.spanContext!.isValid, isTrue);
    expect(
        resultSpan.spanContext!.spanId.toString(), equals('00f067aa0ba902b7'));
    expect(resultSpan.spanContext!.traceId.toString(),
        equals('4bf92f3577b34da6a3ce929d0e0e4736'));
    expect(resultSpan.spanContext!.traceFlags & api.TraceFlags.sampled,
        equals(api.TraceFlags.sampled));
    expect(resultSpan.spanContext!.traceState.toString(),
        equals('rojo=00f067aa0ba902b7,congo=t61rcWkgMzE'));
  });

  test('extract invalid trace parent', () {
    final testPropagator = W3CTraceContextPropagator();
    final testCarrier = {};

    TestingInjector()
      ..set(testCarrier, 'traceparent',
          '00-00000000000000000000000000000000-0000000000000000-ff')
      ..set(
          testCarrier, 'tracestate', 'rojo=00f067aa0ba902b7,congo=t61rcWkgMzE');
    final resultContext = testPropagator.extract(
        api.Context.current, testCarrier, TestingExtractor());
    final resultSpan = resultContext.span!;

    expect(resultSpan.parentSpanId.toString(), equals('0000000000000000'));
    expect(resultSpan.spanContext!.isValid, isFalse);
    expect(
        resultSpan.spanContext!.spanId.toString(), equals('0000000000000000'));
    expect(resultSpan.spanContext!.traceId.toString(),
        equals('00000000000000000000000000000000'));
    expect(resultSpan.spanContext!.traceFlags & api.TraceFlags.sampled,
        equals(api.TraceFlags.sampled));
    expect(resultSpan.spanContext!.traceState.toString(),
        equals('rojo=00f067aa0ba902b7,congo=t61rcWkgMzE'));
  });

  test('extract missing trace parent', () {
    final testPropagator = W3CTraceContextPropagator();
    final testCarrier = {};

    final resultContext = testPropagator.extract(
        api.Context.current, testCarrier, TestingExtractor());
    final resultSpan = resultContext.span;

    expect(resultSpan, isNull);
  });

  test('extract malformed trace parent', () {
    final testPropagator = W3CTraceContextPropagator();
    final testCarrier = {};

    TestingInjector()
      ..set(testCarrier, 'traceparent',
          '00-4bf92^3577b34da6q3ce929d0e0e4736-00f@67aa0bak02b7-01')
      ..set(
          testCarrier, 'tracestate', 'rojo=00f067aa0ba902b7,congo=t61rcWkgMzE');
    final resultContext = testPropagator.extract(
        api.Context.current, testCarrier, TestingExtractor());
    final resultSpan = resultContext.span;

    // Extract should not allow a Span with malformed IDs to be attached to
    // a Context.  Thus, there should be no Span on this context.
    expect(resultSpan, isNull);
  });

  test('extract malformed trace state', () {
    final testPropagator = W3CTraceContextPropagator();
    final testCarrier = {};

    TestingInjector()
      ..set(testCarrier, 'traceparent',
          '00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01')
      ..set(testCarrier, 'tracestate',
          'rojo=00f067aa,0ba902b7,con@go=t61rcWk=gMzE');
    final resultSpan = testPropagator
        .extract(api.Context.current, testCarrier, TestingExtractor())
        .span!;

    expect(resultSpan.parentSpanId.toString(), equals('0000000000000000'));
    expect(resultSpan.spanContext!.isValid, isTrue);
    expect(
        resultSpan.spanContext!.spanId.toString(), equals('00f067aa0ba902b7'));
    expect(resultSpan.spanContext!.traceId.toString(),
        equals('4bf92f3577b34da6a3ce929d0e0e4736'));
    expect((resultSpan.spanContext as sdk.SpanContext).traceFlags,
        equals(api.TraceFlags.sampled));
    // Extract should not allow a TraceState with malformed IDs to be attached to
    // a Context.  Thus, there should be an empty TraceState on this context.
    expect(resultSpan.spanContext!.traceState.toString(), equals(''));
  });

  test('inject trace parent', () {
    final testSpan = Span(
        'TestSpan',
        SpanContext(
            api.TraceId.fromString('4bf92f3577b34da6a3ce929d0e0e4736'),
            api.SpanId.fromString('0000000000c0ffee'),
            api.TraceFlags.sampled,
            TraceState.fromString('rojo=00f067aa0ba902b7,congo=t61rcWkgMzE')),
        api.SpanId.fromString('00f067aa0ba902b7'),
        [],
        sdk.DateTimeTimeProvider(),
        Resource([]),
        InstrumentationLibrary('library_name', 'library_version'));
    final testCarrier = {};
    final testContext = api.Context.current.withSpan(testSpan);

    W3CTraceContextPropagator()
        .inject(testContext, testCarrier, TestingInjector());

    expect(testCarrier['traceparent'],
        equals('00-4bf92f3577b34da6a3ce929d0e0e4736-0000000000c0ffee-01'));
    expect(testCarrier['tracestate'],
        equals('rojo=00f067aa0ba902b7,congo=t61rcWkgMzE'));
  });

  test('inject invalid trace parent', () {
    final testSpan = Span(
        'TestSpan',
        SpanContext(
            api.TraceId.fromString('00000000000000000000000000000000'),
            api.SpanId.fromString('0000000000000000'),
            api.TraceFlags.none,
            TraceState.fromString('rojo=00f067aa0ba902b7,congo=t61rcWkgMzE')),
        api.SpanId.fromString('0000000000c0ffee'),
        [],
        sdk.DateTimeTimeProvider(),
        Resource([]),
        InstrumentationLibrary('library_name', 'library_version'));
    final testCarrier = {};
    final testContext = api.Context.current.withSpan(testSpan);

    W3CTraceContextPropagator()
        .inject(testContext, testCarrier, TestingInjector());

    expect(testCarrier['traceparent'],
        equals('00-00000000000000000000000000000000-0000000000000000-00'));
    expect(testCarrier['tracestate'],
        equals('rojo=00f067aa0ba902b7,congo=t61rcWkgMzE'));
  });

  test('header regex, valid input', () {
    const traceParentHeader =
        '00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01';
    final parentHeaderMatch = W3CTraceContextPropagator.traceParentHeaderRegEx
        .firstMatch(traceParentHeader)!;
    final parentHeaderFields = Map<String, String?>.fromIterable(
        parentHeaderMatch.groupNames,
        key: (element) => element.toString(),
        value: (element) => parentHeaderMatch.namedGroup(element));

    expect(
        parentHeaderFields,
        equals({
          'version': '00',
          'traceid': '4bf92f3577b34da6a3ce929d0e0e4736',
          'parentid': '00f067aa0ba902b7',
          'traceflags': '01'
        }));
  });
  test('header regex, invalid trace and parent IDs', () {
    const traceParentHeader =
        '00-00000000000000000000000000000000-0000000000000000-00';
    final parentHeaderMatch = W3CTraceContextPropagator.traceParentHeaderRegEx
        .firstMatch(traceParentHeader)!;
    final parentHeaderFields = Map<String, String?>.fromIterable(
        parentHeaderMatch.groupNames,
        key: (element) => element.toString(),
        value: (element) => parentHeaderMatch.namedGroup(element));

    expect(
        parentHeaderFields,
        equals({
          'version': '00',
          'traceid': '00000000000000000000000000000000',
          'parentid': '0000000000000000',
          'traceflags': '00'
        }));
  });
  test('header regex, malformed trace and parent IDs', () {
    const traceParentHeader =
        '00-4bf92^3577b34da6q3ce929d0e0e4736-00f@67aa0bak02b7-01';
    final parentHeaderMatch = W3CTraceContextPropagator.traceParentHeaderRegEx
        .firstMatch(traceParentHeader);

    expect(parentHeaderMatch, isNull);
  });
}
