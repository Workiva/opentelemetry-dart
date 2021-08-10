import 'package:opentelemetry/src/api/context/context.dart';
import 'package:opentelemetry/src/api/trace/context_utils.dart';
import 'package:opentelemetry/src/sdk/trace/tracer.dart';
import 'package:test/test.dart';

void main() {
  test('startSpan new trace', () {
    final tracer = Tracer();

    final span = tracer.startSpan('foo');

    expect(span.startTime, isA<int>());
    expect(span.endTime, isNull);
    expect(span.spanContext.traceId, isA<String>());
    expect(span.spanContext.spanId, isA<String>());
  });

  test('startSpan child span', () {
    final tracer = Tracer();

    final parentSpan = tracer.startSpan('foo');
    final context = setSpan(Context.current, parentSpan);

    final childSpan = tracer.startSpan('bar', context: context);

    expect(childSpan.startTime, isA<int>());
    expect(childSpan.endTime, isNull);
    expect(childSpan.spanContext.traceId, equals(parentSpan.spanContext.traceId));
    expect(childSpan.spanContext.traceState, equals(parentSpan.spanContext.traceState));
    expect(childSpan.spanContext.spanId, allOf([
      isA<String>(),
      isNot(equals(parentSpan.spanContext.spanId))
    ]));
  });
}
