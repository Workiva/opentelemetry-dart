import 'dart:async';

import '../../../api.dart' as api;
import '../../../sdk.dart' as sdk;

/// An interface for creating [api.Span]s and propagating context in-process.
class Tracer implements api.Tracer {
  final List<api.SpanProcessor> _processors;
  final api.Resource _resource;
  final api.Sampler _sampler;
  final api.IdGenerator _idGenerator;
  final api.InstrumentationLibrary _instrumentationLibrary;

  Tracer(this._processors, this._resource, this._sampler, this._idGenerator,
      this._instrumentationLibrary);

  @override
  api.Span startSpan(String name,
      {api.Context context, api.Attributes attributes}) {
    context ??= api.Context.current;
    attributes ??= api.Attributes.empty();

    // If a valid, active Span is present in the context, use it as this Span's
    // parent.  If the Context does not contain an active parent Span, create
    // a root Span with a new Trace ID and default state.
    // See https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/trace/api.md#determining-the-parent-span-from-a-context
    final parent = context.span;
    final spanId = api.SpanId.fromIdGenerator(_idGenerator);
    api.TraceId traceId;
    api.TraceState traceState;
    api.SpanId parentSpanId;

    if (parent != null) {
      parentSpanId = parent.spanContext.spanId;
      traceId = parent.spanContext.traceId;
      traceState = parent.spanContext.traceState;
    } else {
      parentSpanId = api.SpanId.root();
      traceId = api.TraceId.fromIdGenerator(_idGenerator);
      traceState = sdk.TraceState.empty();
    }

    final samplerResult =
        _sampler.shouldSample(context, traceId, name, false, attributes);
    final traceFlags = (samplerResult.decision == api.Decision.recordAndSample)
        ? api.TraceFlags.sampled
        : api.TraceFlags.none;
    final spanContext =
        sdk.SpanContext(traceId, spanId, traceFlags, traceState);

    return sdk.Span(name, spanContext, parentSpanId, _processors, _resource,
        _instrumentationLibrary,
        attributes: attributes);
  }

  /// Records a span of the given [name] for the given synchronous function
  /// and marks the span as errored if an exception occurs.
  @override
  R traceSync<R>(String name, R Function() fn, {api.Context context}) {
    final operationContext = context ?? api.Context.current;
    final span = startSpan(name, context: operationContext);

    try {
      return operationContext.withSpan(span).execute(fn);
    } catch (e, s) {
      span.setStatus(api.StatusCode.error, description: e.toString());
      span.attributes.addAll([
        api.Attribute.fromBoolean('error', true),
        api.Attribute.fromString('exception', e.toString()),
        api.Attribute.fromString('stacktrace', s.toString()),
      ]);
      rethrow;
    } finally {
      span.end();
    }
  }

  /// Records a span of the given [name] for the given asynchronous function
  /// and marks the span as errored if an exception occurs.
  @override
  Future<R> traceAsync<R>(String name, Future<R> Function() fn,
      {api.Context context}) async {
    final operationContext = context ?? api.Context.current;
    final span = startSpan(name, context: operationContext);

    try {
      return await operationContext.withSpan(span).execute(fn);
    } catch (e, s) {
      span.setStatus(api.StatusCode.error, description: e.toString());
      span.attributes.addAll([
        api.Attribute.fromBoolean('error', true),
        api.Attribute.fromString('exception', e.toString()),
        api.Attribute.fromString('stacktrace', s.toString()),
      ]);
      rethrow;
    } finally {
      span.end();
    }
  }
}
