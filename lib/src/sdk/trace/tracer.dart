import 'dart:async';

import '../../../api.dart' as api;
import '../../api/trace/sampler.dart';
import '../../api/trace/sampling_result.dart';
import '../common/attribute.dart';
import '../common/attributes.dart';
import '../instrumentation_library.dart';
import '../resource/resource.dart';
import 'id_generator.dart';
import 'span.dart';
import 'span_context.dart';
import 'span_id.dart';
import 'trace_flags.dart';
import 'trace_id.dart';
import 'trace_state.dart';

/// An interface for creating [Span]s and propagating context in-process.
class Tracer implements api.Tracer {
  final List<api.SpanProcessor> _processors;
  final Resource _resource;
  final Sampler _sampler;
  final IdGenerator _idGenerator;
  final InstrumentationLibrary _instrumentationLibrary;

  Tracer(this._processors, this._resource, this._sampler, this._idGenerator,
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
    final spanId = SpanId.fromIdGenerator(_idGenerator);
    TraceId traceId;
    TraceState traceState;
    SpanId parentSpanId;

    if (parent != null) {
      parentSpanId = parent.spanContext.spanId;
      traceId = parent.spanContext.traceId;
      traceState = parent.spanContext.traceState;
    } else {
      parentSpanId = SpanId.root();
      traceId = TraceId.fromIdGenerator(_idGenerator);
      traceState = TraceState.empty();
    }

    final samplerResult =
        _sampler.shouldSample(context, traceId, name, false, attributes);
    final traceFlags = (samplerResult.decision == Decision.recordAndSample)
        ? TraceFlags(api.TraceFlags.sampledFlag)
        : TraceFlags(api.TraceFlags.none);
    final spanContext = SpanContext(traceId, spanId, traceFlags, traceState);

    return Span(name, spanContext, parentSpanId, _processors, _resource,
        _instrumentationLibrary,
        attributes: attributes);
  }

  /// Records a span of the given [name] for the given function and marks the
  /// span as errored if an exception occurs.
  FutureOr<R> trace<R>(String name, FutureOr<R> Function() fn,
      {api.Context context}) {
    final operationContext = context ?? api.Context.current;

    return operationContext.execute(() async {
      final span = startSpan(name, context: operationContext);
      try {
        return await operationContext.withSpan(span).execute(fn);
      } catch (e, s) {
        span.setStatus(api.StatusCode.error, description: e.toString());
        span.attributes.addAll([
          Attribute.fromBoolean('error', true),
          Attribute.fromString('exception', e.toString()),
          Attribute.fromString('stacktrace', s.toString()),
        ]);
        rethrow;
      } finally {
        span.end();
      }
    });
  }
}
