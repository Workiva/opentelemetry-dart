// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:fixnum/fixnum.dart';

import '../../../api.dart' as api;
import '../../../sdk.dart' as sdk;
import 'span.dart';

/// An interface for creating [api.Span]s and propagating context in-process.
class Tracer implements api.Tracer {
  final List<api.SpanProcessor> _processors;
  final sdk.Resource _resource;
  final sdk.Sampler _sampler;
  final sdk.TimeProvider _timeProvider;
  final api.IdGenerator _idGenerator;
  final api.InstrumentationLibrary _instrumentationLibrary;
  final sdk.SpanLimits _spanLimits;

  Tracer(this._processors, this._resource, this._sampler, this._timeProvider,
      this._idGenerator, this._instrumentationLibrary,
      {sdk.SpanLimits? spanLimits})
      : _spanLimits = spanLimits ?? sdk.SpanLimits();

  @override
  api.Span startSpan(String name,
      {api.Context? context,
      api.SpanKind? kind,
      List<api.Attribute>? attributes,
      List<api.SpanLink>? links,
      Int64? startTime}) {
    context ??= api.Context.current;

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
      parentSpanId = parent.spanContext!.spanId;
      traceId = parent.spanContext!.traceId;
      traceState = parent.spanContext!.traceState;
    } else {
      parentSpanId = api.SpanId.root();
      traceId = api.TraceId.fromIdGenerator(_idGenerator);
      traceState = sdk.TraceState.empty();
    }

    final samplerResult =
        _sampler.shouldSample(context, traceId, name, kind, attributes, links);
    final traceFlags = (samplerResult.decision == sdk.Decision.recordAndSample)
        ? api.TraceFlags.sampled
        : api.TraceFlags.none;
    final spanContext =
        sdk.SpanContext(traceId, spanId, traceFlags, traceState);

    return Span(name, spanContext, parentSpanId, _processors, _timeProvider,
        _resource, _instrumentationLibrary,
        kind: kind,
        attributes: attributes,
        links: links,
        parentContext: context,
        limits: _spanLimits,
        startTime: startTime);
  }
}
