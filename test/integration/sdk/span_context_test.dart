import 'package:opentelemetry/src/sdk/trace/span_id.dart';
import 'package:opentelemetry/src/sdk/trace/trace_flags.dart';
import 'package:opentelemetry/src/sdk/trace/trace_id.dart';
import 'package:opentelemetry/src/sdk/trace/trace_state.dart';
import 'package:test/test.dart';
import 'package:opentelemetry/src/sdk/trace/span_context.dart';
import 'package:opentelemetry/api.dart' as api;

void main() {
  test('valid context evaluates as valid', () {
    final spanId = SpanId([1, 2, 3]);
    final traceId = TraceId([4, 5, 6]);
    final traceFlags = TraceFlags(api.TraceFlags.sampledFlag);
    final traceState = TraceState.empty();

    final testSpanContext =
        SpanContext(traceId, spanId, traceFlags, traceState);

    expect(testSpanContext.isValid, isTrue);
    expect(testSpanContext.traceId, same(traceId));
    expect(testSpanContext.spanId, same(spanId));
    expect(testSpanContext.traceFlags, same(traceFlags));
    expect(testSpanContext.traceState, same(traceState));
  });

  test('invalid parsed parent span ID from header creates an invalid context',
      () {
    final spanId = SpanId.fromString('0000000000000000');
    final traceId = TraceId([4, 5, 6]);
    final traceFlags = TraceFlags(api.TraceFlags.sampledFlag);
    final traceState = TraceState.empty();

    final testSpanContext =
        SpanContext(traceId, spanId, traceFlags, traceState);

    expect(testSpanContext.isValid, isFalse);
    expect(testSpanContext.traceId, same(traceId));
    expect(testSpanContext.spanId, same(spanId));
    expect(testSpanContext.traceFlags, same(traceFlags));
    expect(testSpanContext.traceState, same(traceState));
  });

  test('invalid parsed trace ID from header creates an invalid context', () {
    final spanId = SpanId([1, 2, 3]);
    final traceId = TraceId.fromString('00000000000000000000000000000000');
    final traceFlags = TraceFlags(api.TraceFlags.sampledFlag);
    final traceState = TraceState.empty();

    final testSpanContext =
        SpanContext(traceId, spanId, traceFlags, traceState);

    expect(testSpanContext.isValid, isFalse);
    expect(testSpanContext.traceId, same(traceId));
    expect(testSpanContext.spanId, same(spanId));
    expect(testSpanContext.traceFlags, same(traceFlags));
    expect(testSpanContext.traceState, same(traceState));
  });

  test('valid context evaluates as valid', () {
    final testSpanContext = SpanContext.invalid();

    expect(testSpanContext.isValid, isFalse);
    expect(testSpanContext.traceId.isValid, isFalse);
    expect(testSpanContext.isValid, isFalse);
    expect(testSpanContext.traceFlags.isValid, isFalse);
    expect(testSpanContext.traceState.isEmpty, isTrue);
  });
}
