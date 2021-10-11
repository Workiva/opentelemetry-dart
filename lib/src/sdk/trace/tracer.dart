import '../../../api.dart' as api;
import '../common/attributes.dart';
import '../instrumentation_library.dart';
import 'id_generator.dart';
import 'span.dart';
import 'span_context.dart';
import 'span_id.dart';
import 'span_processors/span_processor.dart';
import 'trace_flags.dart';
import 'trace_id.dart';
import 'trace_state.dart';

/// An interface for creating [Span]s and propagating context in-process.
class Tracer implements api.Tracer {
  final String _name;
  final List<SpanProcessor> _processors;
  final IdGenerator _idGenerator;
  final InstrumentationLibrary _libraryVersion; // ignore: unused_field

  @override
  String get name => _name;
  Tracer(this._name, this._processors, this._idGenerator, this._libraryVersion);

  @override
  Span startSpan(String name,
      {api.Context context, api.Attributes attributes}) {
    context ??= api.Context.current;
    attributes ??= Attributes.empty();

    // If a valid, active Span is present in the context, use it as this Span's
    // parent.  If the Context does not contain a parent Span, or contains a
    // parent Span which represents an operation which has already completed,
    // create a root Span with a new Trace ID and default state.
    final parent = context.getSpan();
    var parentSpanId;
    var spanContext;

    if (parent != null && parent.endTime == null) {
      // The Span on the Context is valid; Use it as this Span's parent.
      parentSpanId =
          (parent.isRecording) ? parent.spanContext.spanId : SpanId.root();
      spanContext = SpanContext(
          parent.spanContext.traceId,
          SpanId.fromIdGenerator(_idGenerator),
          parent.spanContext.traceFlags,
          parent.spanContext.traceState);
    } else {
      // The Span is not valid; Use default values.
      parentSpanId = SpanId.root();
      spanContext = SpanContext(
          TraceId.fromIdGenerator(_idGenerator),
          SpanId.fromIdGenerator(_idGenerator),
          TraceFlags(api.TraceFlags.SAMPLED_FLAG),
          TraceState.empty());
    }

    return Span(name, spanContext, parentSpanId, _processors, this,
        attributes: attributes);
  }
}
