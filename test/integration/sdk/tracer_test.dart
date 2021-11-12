import 'package:opentelemetry/src/api/context/context.dart';
import 'package:opentelemetry/src/sdk/common/attributes.dart';
import 'package:opentelemetry/src/sdk/instrumentation_library.dart';
import 'package:opentelemetry/src/sdk/resource/resource.dart';
import 'package:opentelemetry/src/sdk/trace/tracer.dart';
import 'package:opentelemetry/src/sdk/trace/id_generator.dart';
import 'package:test/test.dart';

void main() {
  test('startSpan new trace', () {
    final tracer = Tracer([], Resource(Attributes.empty()), IdGenerator(),
        InstrumentationLibrary('name', 'version'));

    final span = tracer.startSpan('foo');

    expect(span.startTime, isNotNull);
    expect(span.endTime, isNull);
    expect(span.spanContext.traceId, isNotNull);
    expect(span.spanContext.spanId, isNotNull);
  });

  test('startSpan child span', () {
    final tracer = Tracer([], Resource(Attributes.empty()), IdGenerator(),
        InstrumentationLibrary('name', 'version'));

    final parentSpan = tracer.startSpan('foo');
    final context = Context.current.withSpan(parentSpan);

    final childSpan = tracer.startSpan('bar', context: context);

    expect(childSpan.startTime, isNotNull);
    expect(childSpan.endTime, isNull);
    expect(
        childSpan.spanContext.traceId, equals(parentSpan.spanContext.traceId));
    expect(childSpan.spanContext.traceState,
        equals(parentSpan.spanContext.traceState));
    expect(childSpan.spanContext.spanId,
        allOf([isNotNull, isNot(equals(parentSpan.spanContext.spanId))]));
  });
}
