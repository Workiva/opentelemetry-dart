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
    // parent.  If the Context does not contain an active parent Span, create
    // a root Span with a new Trace ID and default state.
    // See https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/trace/api.md#determining-the-parent-span-from-a-context
    final parent = context.span;
    var parentSpanId;
    var spanContext;

    // TODO: O11Y-1027: A Sampler should update the trace flags here.

    if (parent != null && parent.endTime == null) {
      parentSpanId = parent.spanContext.spanId;
      spanContext = SpanContext(
          parent.spanContext.traceId,
          SpanId.fromIdGenerator(_idGenerator),
          parent.spanContext.traceFlags,
          parent.spanContext.traceState);
    } else {
      parentSpanId = SpanId.root();
      spanContext = SpanContext(
          TraceId.fromIdGenerator(_idGenerator),
          SpanId.fromIdGenerator(_idGenerator),
          TraceFlags(api.TraceFlags.sampledFlag),
          TraceState.empty());
    }

    return Span(name, spanContext, parentSpanId, _processors, this,
        attributes: attributes);
  }
}
