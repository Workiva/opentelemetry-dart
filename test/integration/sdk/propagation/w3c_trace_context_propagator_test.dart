import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/src/api/context/context.dart';
import 'package:opentelemetry/src/sdk/instrumentation_library.dart';
import 'package:opentelemetry/src/sdk/trace/id_generator.dart';
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

class TestingInjector implements api.TextMapSetter<Map> {
  @override
  void set(Map carrier, String key, String value) {
    if (carrier != null) {
      carrier[key] = value;
    }
  }
}

class TestingExtractor implements api.TextMapGetter<Map> {
  @override
  String get(Map carrier, String key) {
    return (carrier == null) ? null : carrier[key];
  }

  @override
  Iterable<String> keys(Map carrier) {
    return carrier.keys;
  }
}

void main() {
  test('inject and extract trace context', () {
    final testIdGenerator = IdGenerator();
    final testSpan = Span(
        'TestSpan',
        SpanContext(
            TraceId.fromString('4bf92f3577b34da6a3ce929d0e0e4736'),
            SpanId.fromString('0000000000c0ffee'),
            TraceFlags(api.TraceFlags.sampledFlag),
            TraceState.fromString('rojo=00f067aa0ba902b7,congo=t61rcWkgMzE')),
        SpanId.fromString('00f067aa0ba902b7'),
        [],
        Tracer('TestTracer', [], testIdGenerator, InstrumentationLibrary()));
    final testPropagator = W3CTraceContextPropagator();
    final testCarrier = {};
    final testContext = Context.current.withSpan(testSpan);

    testPropagator.inject(testContext, testCarrier, TestingInjector());
    final resultSpan = testPropagator
        .extract(testContext, testCarrier, TestingExtractor())
        .span;

    expect(resultSpan.parentSpanId.toString(), equals('0000000000000000'));
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
            TraceFlags(api.TraceFlags.invalid),
            TraceState.fromString('rojo=00f067aa0ba902b7,congo=t61rcWkgMzE')),
        SpanId.fromString('0000000000000000'),
        [],
        Tracer('TestTracer', [], testIdGenerator, InstrumentationLibrary()));
    final testPropagator = W3CTraceContextPropagator();
    final testCarrier = {};
    final testContext = Context.current.withSpan(testSpan);

    testPropagator.inject(testContext, testCarrier, TestingInjector());
    final resultSpan = testPropagator
        .extract(testContext, testCarrier, TestingExtractor())
        .span;

    expect(resultSpan.parentSpanId.toString(), equals('0000000000000000'));
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
            TraceFlags(api.TraceFlags.sampledFlag),
            TraceState.fromString('rojo=00f067aa0ba902b7,congo=t61rcWkgMzE')),
        SpanId.fromString('00f067aa0ba902b7'),
        [],
        Tracer('TestTracer', [], testIdGenerator, InstrumentationLibrary()));
    final tracer =
        TracerProvider(processors: []).getTracer('appName', version: '1.0.0');
    final testPropagator = W3CTraceContextPropagator();
    final testCarrier = {};

    // Inject and extract a test Span from a Context, as when an outbound
    // call is made and received by another service.
    final testContext = Context.current.withSpan(testSpan);
    testPropagator.inject(testContext, testCarrier, TestingInjector());
    final parentSpan = testPropagator
        .extract(testContext, testCarrier, TestingExtractor())
        .span;

    // Use the transmitted Span as a receiver.
    Span resultSpan;
    Context.current.withSpan(parentSpan).execute(() {
      resultSpan = tracer.startSpan('doWork')..end();
    });

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
