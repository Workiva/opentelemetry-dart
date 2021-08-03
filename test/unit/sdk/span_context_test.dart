import 'package:opentelemetry/src/sdk/trace/span_context.dart';
import 'package:opentelemetry/src/sdk/trace/trace_state.dart';
import 'package:test/test.dart';

void main() {
  test('spanContext getters', () {
    final traceState = TraceState();
    final spanContext = SpanContext('trace123', 'span456', traceState);

    expect(spanContext.traceId, equals('trace123'));
    expect(spanContext.spanId, equals('span456'));
    expect(spanContext.traceState, same(traceState));
  });
}
