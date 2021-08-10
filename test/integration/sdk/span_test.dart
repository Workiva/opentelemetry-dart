import 'package:opentelemetry/src/sdk/trace/span.dart';
import 'package:opentelemetry/src/sdk/trace/span_context.dart';
import 'package:opentelemetry/src/sdk/trace/trace_state.dart';
import 'package:test/test.dart';

void main() {
  test('span set and end time', () {
    final span = Span('foo', SpanContext('trace123', '789', TraceState()), 'span456');

    expect(span.startTime, isA<int>());
    expect(span.endTime, isNull);

    span.end();
    expect(span.startTime, isA<int>());
    expect(span.endTime, isA<int>());
    expect(span.endTime, greaterThan(span.startTime));
  });
}
