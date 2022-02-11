import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/src/api/context/context.dart';
import 'package:opentelemetry/src/sdk/instrumentation_library.dart';
import 'package:opentelemetry/src/sdk/resource/resource.dart';
import 'package:opentelemetry/src/sdk/trace/span.dart';
import 'package:opentelemetry/src/sdk/trace/span_context.dart';
import 'package:opentelemetry/src/sdk/trace/span_id.dart';
import 'package:opentelemetry/src/sdk/trace/trace_id.dart';
import 'package:opentelemetry/src/sdk/trace/trace_state.dart';
import 'package:test/test.dart';

void main() {
  final testSpanContext = SpanContext(TraceId([1, 2, 3]), SpanId([7, 8, 9]),
      api.TraceFlags.none, TraceState.empty());
  final testSpan = Span(
      'foo',
      testSpanContext,
      SpanId([4, 5, 6]),
      [],
      Resource(api.Attributes.empty()),
      InstrumentationLibrary('library_name', 'library_version'));

  group('get Span', () {
    test('returns Span when exists', () {
      final childContext = Context.current.withSpan(testSpan);

      expect(childContext.span, same(testSpan));
    });

    test('returns null when not exists', () {
      final context = Context.current;

      expect(context.span, isNull);
    });
  });

  group('get SpanContext', () {
    test('returns SpanContext when Span exists', () {
      final testContext = Context.current.withSpan(testSpan);

      expect(testContext.spanContext, same(testSpanContext));
    });

    test('returns null when Span not exists', () {
      final testContext = Context.current;

      expect(testContext.spanContext, isNull);
    });
  });
}
