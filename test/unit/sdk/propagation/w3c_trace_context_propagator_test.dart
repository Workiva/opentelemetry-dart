import 'package:frugal/frugal.dart';
import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/src/api/context/context.dart';
import 'package:opentelemetry/src/api/trace/context_utils.dart';
import 'package:opentelemetry/src/sdk/instrumentation_library.dart';
import 'package:opentelemetry/src/sdk/trace/id_generator.dart';
import 'package:opentelemetry/src/sdk/trace/propagation/extractors/fcontext_extractor.dart';
import 'package:opentelemetry/src/sdk/trace/propagation/injectors/fcontext_injector.dart';
import 'package:opentelemetry/src/sdk/trace/propagation/w3c_trace_context_propagator.dart';
import 'package:opentelemetry/src/sdk/trace/span.dart';
import 'package:opentelemetry/src/sdk/trace/span_context.dart';
import 'package:opentelemetry/src/sdk/trace/span_id.dart';
import 'package:opentelemetry/src/sdk/trace/trace_flags.dart';
import 'package:opentelemetry/src/sdk/trace/trace_id.dart';
import 'package:opentelemetry/src/sdk/trace/trace_state.dart';
import 'package:opentelemetry/src/sdk/trace/tracer.dart';
import 'package:test/test.dart';

void main() {
  test('extract trace context', () {
    final testPropagator = W3CTraceContextPropagator();
    final testCarrier = FContext();

    FContextInjector()
      ..set(testCarrier, 'traceparent',
          '00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01')
      ..set(
          testCarrier, 'tracestate', 'rojo=00f067aa0ba902b7,congo=t61rcWkgMzE');
    final resultContext = testPropagator.extract(
        Context.current, testCarrier, FContextExtractor());
    final Span resultSpan = getSpan(resultContext);

    expect(resultSpan.parentSpanId, isNull);
    expect(resultSpan.spanContext.isValid, isTrue);
    expect(
        resultSpan.spanContext.spanId.toString(), equals('00f067aa0ba902b7'));
    expect(resultSpan.spanContext.traceId.toString(),
        equals('4bf92f3577b34da6a3ce929d0e0e4736'));
    expect(resultSpan.spanContext.traceFlags.isValid, isTrue);
    expect(resultSpan.spanContext.traceFlags.sampled, isTrue);
    expect(resultSpan.spanContext.traceState.toString(),
        equals('rojo=00f067aa0ba902b7,congo=t61rcWkgMzE'));
  });

  test('extract invalid trace parent', () {
    final testPropagator = W3CTraceContextPropagator();
    final testCarrier = FContext();

    FContextInjector()
      ..set(testCarrier, 'traceparent',
          '00-00000000000000000000000000000000-0000000000000000-ff')
      ..set(
          testCarrier, 'tracestate', 'rojo=00f067aa0ba902b7,congo=t61rcWkgMzE');
    final resultContext = testPropagator.extract(
        Context.current, testCarrier, FContextExtractor());
    final Span resultSpan = getSpan(resultContext);

    expect(resultSpan.parentSpanId, isNull);
    expect(resultSpan.spanContext.isValid, isFalse);
    expect(
        resultSpan.spanContext.spanId.toString(), equals('0000000000000000'));
    expect(resultSpan.spanContext.traceId.toString(),
        equals('00000000000000000000000000000000'));
    expect(resultSpan.spanContext.traceFlags.isValid, isFalse);
    expect(resultSpan.spanContext.traceFlags.sampled, isFalse);
    expect(resultSpan.spanContext.traceState.toString(),
        equals('rojo=00f067aa0ba902b7,congo=t61rcWkgMzE'));
  });

  test('extract missing trace parent', () {
    final testPropagator = W3CTraceContextPropagator();
    final testCarrier = FContext();

    final resultContext = testPropagator.extract(
        Context.current, testCarrier, FContextExtractor());
    final Span resultSpan = getSpan(resultContext);

    expect(resultSpan, isNull);
  });

  test('extract malformed trace parent', () {
    final testPropagator = W3CTraceContextPropagator();
    final testCarrier = FContext();

    FContextInjector()
      ..set(testCarrier, 'traceparent',
          '00-4bf92^3577b34da6q3ce929d0e0e4736-00f@67aa0bak02b7-01')
      ..set(
          testCarrier, 'tracestate', 'rojo=00f067aa0ba902b7,congo=t61rcWkgMzE');
    final resultContext = testPropagator.extract(
        Context.current, testCarrier, FContextExtractor());
    final Span resultSpan = getSpan(resultContext);

    // Extract should not allow a Span with malformed IDs to be attached to
    // a Context.  Thus, there should be no Span on this context.
    expect(resultSpan, isNull);
  });

  test('extract malformed trace state', () {
    final testPropagator = W3CTraceContextPropagator();
    final testCarrier = FContext();

    FContextInjector()
      ..set(testCarrier, 'traceparent',
          '00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01')
      ..set(testCarrier, 'tracestate',
          'rojo=00f067aa,0ba902b7,con@go=t61rcWk=gMzE');
    final Span resultSpan = getSpan(testPropagator.extract(
        Context.current, testCarrier, FContextExtractor()));

    expect(resultSpan.parentSpanId, isNull);
    expect(resultSpan.spanContext.isValid, isTrue);
    expect(
        resultSpan.spanContext.spanId.toString(), equals('00f067aa0ba902b7'));
    expect(resultSpan.spanContext.traceId.toString(),
        equals('4bf92f3577b34da6a3ce929d0e0e4736'));
    expect(resultSpan.spanContext.traceFlags.isValid, isTrue);
    expect(resultSpan.spanContext.traceFlags.sampled, isTrue);
    // Extract should not allow a TraceState with malformed IDs to be attached to
    // a Context.  Thus, there should be an empty TraceState on this context.
    expect(resultSpan.spanContext.traceState.toString(), equals(''));
  });

  test('inject trace parent', () {
    final testIdGenerator = IdGenerator();
    final testSpan = Span(
        'TestSpan',
        SpanContext(
            TraceId.fromString('4bf92f3577b34da6a3ce929d0e0e4736'),
            SpanId.fromString('0000000000c0ffee'),
            TraceFlags(api.TraceFlags.SAMPLED_FLAG),
            TraceState.fromString('rojo=00f067aa0ba902b7,congo=t61rcWkgMzE')),
        SpanId.fromString('00f067aa0ba902b7'),
        [],
        Tracer('TestTracer', [], testIdGenerator, InstrumentationLibrary()));
    final testCarrier = FContext();
    final testContext = api.setSpan(Context.current, testSpan);

    W3CTraceContextPropagator()
        .inject(testContext, testCarrier, FContextInjector());

    expect(testCarrier.requestHeader('traceparent'),
        equals('00-4bf92f3577b34da6a3ce929d0e0e4736-0000000000c0ffee-01'));
    expect(testCarrier.requestHeader('tracestate'),
        equals('rojo=00f067aa0ba902b7,congo=t61rcWkgMzE'));
  });

  test('inject invalid trace parent', () {
    final testIdGenerator = IdGenerator();
    final testSpan = Span(
        'TestSpan',
        SpanContext(
            TraceId.fromString('00000000000000000000000000000000'),
            SpanId.fromString('0000000000000000'),
            TraceFlags(api.TraceFlags.INVALID),
            TraceState.fromString('rojo=00f067aa0ba902b7,congo=t61rcWkgMzE')),
        SpanId.fromString('0000000000c0ffee'),
        [],
        Tracer('TestTracer', [], testIdGenerator, InstrumentationLibrary()));
    final testCarrier = FContext();
    final testContext = api.setSpan(Context.current, testSpan);

    W3CTraceContextPropagator()
        .inject(testContext, testCarrier, FContextInjector());

    expect(testCarrier.requestHeader('traceparent'),
        equals('00-00000000000000000000000000000000-0000000000000000-ff'));
    expect(testCarrier.requestHeader('tracestate'),
        equals('rojo=00f067aa0ba902b7,congo=t61rcWkgMzE'));
  });

  test('header regex, valid input', () {
    const traceParentHeader =
        '00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01';
    final parentHeaderMatch = W3CTraceContextPropagator.traceParentHeaderRegEx
        .firstMatch(traceParentHeader);
    final parentHeaderFields = Map<String, String>.fromIterable(
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
        .firstMatch(traceParentHeader);
    final parentHeaderFields = Map<String, String>.fromIterable(
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
