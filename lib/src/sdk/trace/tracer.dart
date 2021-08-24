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

    final Span parent = api.getSpan(context);

    // If a Span is present in the context, use it as this Span's parent.
    // If not, create a root Span, which has no parent, with a new Trace ID
    // and default state.
    final parentSpanId = parent?.spanContext?.spanId ?? SpanId.root();
    final SpanContext spanContext = SpanContext(
            parent?.spanContext?.traceId ??
                TraceId.fromIdGenerator(_idGenerator),
            SpanId.fromIdGenerator(_idGenerator),
            parent?.spanContext?.traceFlags ?? TraceFlags(api.TraceFlags.NONE),
            parent?.spanContext?.traceState) ??
        TraceState.empty();

    return Span(name, spanContext, parentSpanId, _processors, this,
        attributes: attributes);
  }
}
