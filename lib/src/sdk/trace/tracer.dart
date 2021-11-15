import 'package:opentelemetry/src/sdk/resource/resource.dart';

import '../../../api.dart' as api;
import '../../api/span_processors/span_processor.dart';
import '../common/attributes.dart';
import '../instrumentation_library.dart';
import 'id_generator.dart';
import 'span.dart';
import 'span_context.dart';
import 'span_id.dart';
import 'trace_flags.dart';
import 'trace_id.dart';
import 'trace_state.dart';

/// An interface for creating [Span]s and propagating context in-process.
class Tracer implements api.Tracer {
  final List<SpanProcessor> _processors;
  final Resource _resource;
  final IdGenerator _idGenerator;
  final InstrumentationLibrary _instrumentationLibrary;

  Tracer(this._processors, this._resource, this._idGenerator,
      this._instrumentationLibrary);

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

    if (parent != null) {
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

    return Span(name, spanContext, parentSpanId, _processors, _resource,
        _instrumentationLibrary,
        attributes: attributes);
  }
}
