import 'package:opentelemetry/src/sdk/trace/span_context.dart';
import 'package:opentelemetry/src/sdk/trace/trace_state.dart';
import 'package:test/test.dart';

void main() {
  test('spanContext getters', () {
    final traceState = TraceState();
    final spanContext = SpanContext([1, 2, 3], [4, 5, 6], traceState);

    expect(spanContext.traceId, [1, 2, 3]);
    expect(spanContext.spanId, [4, 5, 6]);
    expect(spanContext.traceState, same(traceState));
  });
}
