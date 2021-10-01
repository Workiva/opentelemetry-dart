import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/src/api/context/context.dart';
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
  final testSpanContext = SpanContext(TraceId([1, 2, 3]), SpanId([7, 8, 9]),
      TraceFlags(api.TraceFlags.NONE), TraceState.empty());
  final testSpan = Span('foo', testSpanContext, SpanId([4, 5, 6]), [],
      Tracer('bar', [], IdGenerator(), InstrumentationLibrary()));

  group('getSpan', () {
    test('returns Span when exists', () {
      final childContext = Context.current.withSpan(testSpan);

      expect(childContext.getSpan(), same(testSpan));
    });

    test('returns null when not exists', () {
      final context = Context.current;

      expect(context.getSpan(), isNull);
    });
  });

  group('getSpanContext', () {
    test('returns SpanContext when Span exists', () {
      final testContext = Context.current.withSpan(testSpan);

      expect(testContext.getSpanContext(), same(testSpanContext));
    });

    test('returns null when Span not exists', () {
      final testContext = Context.current;

      expect(testContext.getSpanContext(), isNull);
    });
  });
}
