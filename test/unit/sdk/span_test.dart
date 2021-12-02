import 'package:opentelemetry/src/api/trace/trace_flags.dart' as api;
import 'package:opentelemetry/src/sdk/instrumentation_library.dart';
import 'package:opentelemetry/src/sdk/common/attributes.dart';
import 'package:opentelemetry/src/sdk/resource/resource.dart';
import 'package:opentelemetry/src/sdk/trace/span.dart';
import 'package:opentelemetry/src/sdk/trace/span_context.dart';
import 'package:opentelemetry/src/sdk/trace/span_id.dart';
import 'package:opentelemetry/src/sdk/trace/trace_flags.dart';
import 'package:opentelemetry/src/sdk/trace/trace_id.dart';
import 'package:opentelemetry/src/sdk/trace/trace_state.dart';
import 'package:test/test.dart';

void main() {
  test('span change name', () {
    final span = Span(
        'foo',
        SpanContext(TraceId([1, 2, 3]), SpanId([7, 8, 9]),
            TraceFlags(api.TraceFlags.none), TraceState.empty()),
        SpanId([4, 5, 6]),
        [],
        Resource(Attributes.empty()),
        InstrumentationLibrary('library_name', 'library_version'),
        null);
    expect(span.name, 'foo');

    span.name = 'bar';
    expect(span.name, 'bar');
  });
}
