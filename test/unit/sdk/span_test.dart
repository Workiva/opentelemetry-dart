import 'package:opentelemetry/src/sdk/trace/span.dart';
import 'package:opentelemetry/src/sdk/trace/span_context.dart';
import 'package:opentelemetry/src/sdk/trace/trace_state.dart';
import 'package:test/test.dart';

void main() {
  test('span change name', () {
    final span = Span('foo', SpanContext('trace123', '789', TraceState()), 'span456', []);
    expect(span.name, 'foo');

    span.name = 'bar';
    expect(span.name, 'bar');
  });
}
