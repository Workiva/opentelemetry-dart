// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:fixnum/fixnum.dart';
import 'package:meta/meta.dart';

import '../../../api.dart' as api;
import '../../../sdk.dart' as sdk;
import './logg.dart';
import '../common/limits.dart' show applyLinkLimits;

/// An interface for creating [api.Span]s and propagating context in-process.
class LoggTracer implements api.LogTracer {
   final List<sdk.LogRecordProcessor> _processors;
   final sdk.Resource _resource;
   final sdk.TimeProvider _timeProvider;
   final sdk.InstrumentationScope _instrumentationScope;
   final sdk.LogLimits _limits;
   final api.IdGenerator _idGenerator;
   final sdk.Sampler _sampler;
   Logg? logg;


   @protected
   LoggTracer(
      this._processors,
      this._resource,
      this._timeProvider,
      this._instrumentationScope,
      this._idGenerator,
       this._sampler,
       this._limits);

  @override
   setLog(
      DateTime? observedTimestamp,
      String name,
      {api.Context? context,
        api.SpanKind kind = api.SpanKind.internal,
        List<api.Attribute> attributes = const [],
        List<api.SpanLink> links = const [],
        Int64? startTime})
  {
    context ??= api.Context.current;
    startTime ??= _timeProvider.now;

    // If a valid, active Span is present in the context, use it as this Span's
    // parent.  If the Context does not contain an active parent Span, create
    // a root Span with a new Trace ID and default state.
    // See https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/trace/api.md#determining-the-parent-span-from-a-context
    final spanId = api.SpanId.fromIdGenerator(_idGenerator);
    final traceState = context.spanContext.traceState;
    final traceId = context.spanContext.isValid
        ? context.spanContext.traceId
        : api.TraceId.fromIdGenerator(_idGenerator);
    final parentSpanId = context.spanContext.isValid
        ? context.spanContext.spanId
        : api.SpanId.root();

    final samplerResult =
    _sampler.shouldSample(context, traceId, name, kind, attributes, links);
    final traceFlags = (samplerResult.decision == sdk.Decision.recordAndSample)
        ? api.TraceFlags.sampled
        : api.TraceFlags.none;
    final spanContext =
    api.SpanContext(traceId, spanId, traceFlags, traceState);

    logg = sdk.Logg(
        observedTimestamp ?? DateTime.now(),
        observedTimestamp ?? DateTime.now(),
        name,
        spanContext,
        parentSpanId,
        _processors,
        _timeProvider,
        _resource,
        _instrumentationScope,
        _limits);


    return logg!;
  }
}
