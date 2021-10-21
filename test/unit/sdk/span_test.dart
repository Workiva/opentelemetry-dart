import 'package:opentelemetry/src/api/trace/trace_flags.dart' as api;
import 'package:opentelemetry/src/sdk/instrumentation_library.dart';
import 'package:opentelemetry/src/sdk/trace/id_generator.dart';
import 'package:opentelemetry/src/sdk/trace/span.dart';
import 'package:opentelemetry/src/sdk/trace/span_context.dart';
import 'package:opentelemetry/src/sdk/trace/span_id.dart';
import 'package:opentelemetry/src/sdk/trace/trace_flags.dart';
import 'package:opentelemetry/src/sdk/trace/trace_id.dart';
import 'package:opentelemetry/src/sdk/trace/trace_state.dart';
import 'package:opentelemetry/src/sdk/trace/tracer.dart';
import 'package:test/test.dart';

void main() {
  test('span change name', () {
    final span = Span(
        'foo',
        SpanContext(TraceId([1, 2, 3]), SpanId([7, 8, 9]),
            TraceFlags(api.TraceFlags.none), TraceState.empty()),
        SpanId([4, 5, 6]),
        [],
        Tracer('bar', [], IdGenerator(), InstrumentationLibrary()));
    expect(span.name, 'foo');

    span.name = 'bar';
    expect(span.name, 'bar');
  });
}
