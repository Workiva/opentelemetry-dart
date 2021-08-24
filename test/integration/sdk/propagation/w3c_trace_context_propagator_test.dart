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
import 'package:opentelemetry/src/sdk/trace/tracer_provider.dart';
import 'package:test/test.dart';

void main() {
  test('inject and extract trace context', () {
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
    final testPropagator = W3CTraceContextPropagator();
    final testCarrier = FContext();
    final testContext = api.setSpan(Context.current, testSpan);

    testPropagator.inject(testContext, testCarrier, FContextInjector());
    final Span resultSpan = getSpan(
        testPropagator.extract(testContext, testCarrier, FContextExtractor()));

    expect(resultSpan.parentSpanId, isNull);
    expect(resultSpan.spanContext.isValid, isTrue);
    expect(
        resultSpan.spanContext.spanId.toString(), equals('0000000000c0ffee'));
    expect(resultSpan.spanContext.traceId.toString(),
        equals('4bf92f3577b34da6a3ce929d0e0e4736'));
    expect(resultSpan.spanContext.traceFlags.isValid, isTrue);
    expect(resultSpan.spanContext.traceFlags.sampled, isTrue);
    expect(resultSpan.spanContext.traceState.toString(),
        equals('rojo=00f067aa0ba902b7,congo=t61rcWkgMzE'));
  });

  test('inject and extract invalid trace parent', () {
    final testIdGenerator = IdGenerator();
    final testSpan = Span(
        'TestSpan',
        SpanContext(
            TraceId.fromString('00000000000000000000000000000000'),
            SpanId.fromString('0000000000c0ffee'),
            TraceFlags(api.TraceFlags.INVALID),
            TraceState.fromString('rojo=00f067aa0ba902b7,congo=t61rcWkgMzE')),
        SpanId.fromString('0000000000000000'),
        [],
        Tracer('TestTracer', [], testIdGenerator, InstrumentationLibrary()));
    final testPropagator = W3CTraceContextPropagator();
    final testCarrier = FContext();
    final testContext = api.setSpan(Context.current, testSpan);

    testPropagator.inject(testContext, testCarrier, FContextInjector());
    final Span resultSpan = getSpan(
        testPropagator.extract(testContext, testCarrier, FContextExtractor()));

    expect(resultSpan.parentSpanId, isNull);
    expect(resultSpan.spanContext.isValid, isFalse);
    expect(
        resultSpan.spanContext.spanId.toString(), equals('0000000000c0ffee'));
    expect(resultSpan.spanContext.traceId.toString(),
        equals('00000000000000000000000000000000'));
    expect(resultSpan.spanContext.traceFlags.isValid, isFalse);
    expect(resultSpan.spanContext.traceFlags.sampled, isFalse);
    expect(resultSpan.spanContext.traceState.toString(),
        equals('rojo=00f067aa0ba902b7,congo=t61rcWkgMzE'));
  });

  test('extract and inject with child span', () {
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
    final tracer =
        TracerProvider(processors: []).getTracer('appName', version: '1.0.0');
    final testPropagator = W3CTraceContextPropagator();
    final testCarrier = FContext();

    // Inject and extract a test Span from a Context, as when an outbound
    // call is made and received by another service.
    final testContext = api.setSpan(Context.current, testSpan);
    testPropagator.inject(testContext, testCarrier, FContextInjector());
    final Span parentSpan = getSpan(
        testPropagator.extract(testContext, testCarrier, FContextExtractor()));

    // Use the transmitted Span as a receiver.
    Span resultSpan;
    withContext(setSpan(Context.current, parentSpan), () {
      resultSpan = tracer.startSpan('doWork')..end();
    });

    // Verify that the original Span is set as the parent.
    expect(resultSpan.parentSpanId.toString(),
        equals(testSpan.spanContext.spanId.toString()));
    expect(resultSpan.spanContext.traceId.toString(),
        equals(testSpan.spanContext.traceId.toString()));
    expect(resultSpan.spanContext.traceState.toString(),
        equals(testSpan.spanContext.traceState.toString()));
    expect(resultSpan.spanContext.traceFlags.toString(),
        equals(testSpan.spanContext.traceFlags.toString()));
  });
}
