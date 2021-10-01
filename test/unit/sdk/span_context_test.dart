import 'package:opentelemetry/src/sdk/trace/span_context.dart';
import 'package:opentelemetry/src/sdk/trace/span_id.dart';
import 'package:opentelemetry/src/sdk/trace/trace_flags.dart';
import 'package:opentelemetry/src/api/trace/trace_flags.dart' as api;
import 'package:opentelemetry/src/sdk/trace/trace_id.dart';
import 'package:opentelemetry/src/sdk/trace/trace_state.dart';
import 'package:test/test.dart';

void main() {
  test('spanContext getters', () {
    final spanId = SpanId([4, 5, 6]);
    final traceId = TraceId([1, 2, 3]);
    final traceFlags = TraceFlags(api.TraceFlags.NONE);
    final traceState = TraceState.empty();

    final spanContext = SpanContext(traceId, spanId, traceFlags, traceState);

    expect(spanContext.traceId, same(traceId));
    expect(spanContext.spanId, same(spanId));
    expect(spanContext.traceFlags, same(traceFlags));
    expect(spanContext.traceState, same(traceState));
  });
}
