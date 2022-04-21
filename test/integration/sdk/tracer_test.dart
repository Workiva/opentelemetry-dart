import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:test/test.dart';

void main() {
  test('startSpan new trace', () {
    final tracer = sdk.Tracer([], sdk.Resource([]), sdk.AlwaysOnSampler(),
        sdk.IdGenerator(), sdk.InstrumentationLibrary('name', 'version'));

    final span = tracer.startSpan('foo');

    expect(span.startTime, isNotNull);
    expect(span.endTime, isNull);
    expect(span.spanContext.traceId, isNotNull);
    expect(span.spanContext.spanId, isNotNull);
  });

  test('startSpan child span', () {
    final tracer = sdk.Tracer([], sdk.Resource([]), sdk.AlwaysOnSampler(),
        sdk.IdGenerator(), sdk.InstrumentationLibrary('name', 'version'));

    final parentSpan = tracer.startSpan('foo');
    final context = api.Context.current.withSpan(parentSpan);

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
