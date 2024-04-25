// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

/// The OpenTelemetry SDKs require a mechanism for propagating context and the
/// OpenTelemetry specification outlines the requirements for this context
/// implementation: https://github.com/open-telemetry/opentelemetry-specification/blob/master/specification/context/context.md
///
/// The spec notes that "languages are expected to use the single, widely used
/// Context implementation if one exists for them." Fortunately, the Dart SDK
/// provides just that with [Zone] - a representation of "an environment that
/// remains stable across asynchronous calls." [Zone] also meets the core
/// requirements of immutability and being able to read and write values:
///
/// - Immutable: a Zone's values are set when the Zone is created and cannot be
/// changed afterwards.
/// - Reading and writing values: a Zone implements the `[]` operator, allowing
/// values to be read directly from it like a [Map], and writing values is
/// possible only by forking another Zone and providing values to add/override
/// (the rest of the values will be inherited from the forked Zone).
///
/// This library provides a simple abstraction over [Zone] for the purpose of
/// implementing the rest of the Context specification. OpenTelemetry SDKs and
/// instrumentation libraries should use this [ZoneJsParentContext] API instead of a [Zone]
/// directly. Other users should usually not interact with Context at all and
/// should instead manipulate it through cross-cutting concerns APIs provided by
/// OpenTelemetry SDKs.
import 'dart:async';

import 'package:logging/logging.dart';
import 'package:opentelemetry/src/sdk/context/zone_js_interop.dart';

import '../../../api.dart' as api;
import '../../api/context/context.dart';
import '../../api/trace/nonrecording_span.dart';
import 'package:js/js.dart';

/// [ContextKey] used to store spans in a [ZoneJsParentContext].
final ContextKey spanKey = ZoneJsParentContext.createKey('OpenTelemetry Context Key SPAN');

class ZoneJsParentContext implements api.Context {
  final Zone _zone;

  ZoneJsParentContext._(this._zone);

  /// The active context.
  /// 
  static ZoneJsParentContext get current => getActive();

  static getActive() {
    var z = ZoneJsParentContext._(Zone.current);
    var v = z.getValue(spanKey);
    print("Zone Span: $v");
    Logger("zone_js_parent_context").info("Zone Span: $v");
    if(v == null){
      // If no span is found on the dart side, check the js side.
      var jsContext = JsContextAPI.active();
      print("jsContext: $jsContext");
      var span = jsContext.getValue(JsSymbol.SymbolFromRegistry(spanKey.name));
      var traceId = span.spanContext().traceId;
      print("span: $traceId");
      var sc = api.SpanContext(
        api.TraceId.fromString(span.spanContext().traceId),
        api.SpanId.fromString(span.spanContext().spanId),
        span.spanContext().traceFlags,
        api.TraceState.empty());
              
      var s = NonRecordingSpan(sc);
      return z.setValue(spanKey, s);
    }

    return z;
  }

  static JsSpanContext getActiveAsJs() {
    var z = ZoneJsParentContext._(Zone.current);
    var span = z.getValue(spanKey);
    print("Zone Span: $span");
    if(span == null){
      return JsSpanContext(
        traceId: "",
        spanId: "",
        traceFlags: 0);
    }

    return JsSpanContext(
            traceId: span.spanContext.traceId.toString(),
            spanId: span.spanContext.spanId.toString(),
            traceFlags: span.spanContext.traceFlags);
  }

  /// The root context which all other contexts are derived from.
  ///
  /// It should generally not be required to use the root [ZoneJsParentContext] directly -
  /// instead, use [ZoneJsParentContext.current] to operate on the current [ZoneJsParentContext].
  /// Only use this context if you are certain you need to disregard the
  /// current [ZoneJsParentContext].  For example, when instrumenting an asynchronous
  /// event handler which may fire while an unrelated [ZoneJsParentContext] is "current".
  static ZoneJsParentContext get root => ZoneJsParentContext._(Zone.root);

  /// Returns a key to be used to read and/or write values to a context.
  ///
  /// [name] is for debug purposes only and does not uniquely identify the key.
  /// Multiple calls to this function with the same [name] will not return
  /// identical keys.
  static ContextKey createKey(String name) => ContextKey(name);

  /// Returns the value from this context identified by [key], or null if no
  /// such value is set.
  @override
  T? getValue<T>(ContextKey key) => _zone[key];

  /// Returns a new context created from this one with the given key/value pair
  /// set.
  ///
  /// If [key] was already set in this context, it will be overridden. The rest
  /// of the context values will be inherited.
  @override
  ZoneJsParentContext setValue(ContextKey key, Object value) =>
      ZoneJsParentContext._(_zone.fork(zoneValues: {key: value}));

  /// Returns a new [ZoneJsParentContext] created from this one with the given [api.Span]
  /// set.
  @override
  ZoneJsParentContext withSpan(api.Span span) => setValue(spanKey, span);

  /// Execute a function [fn] within this [ZoneJsParentContext] and return its result.
  @override
  R execute<R>(R Function() fn) => _zone.run(fn);

  /// Get the [api.Span] attached to this [ZoneJsParentContext], or an invalid, [api.Span] if no such
  /// [api.Span] exists.
  @override
  api.Span get span =>
      getValue(spanKey) ?? NonRecordingSpan(api.SpanContext.invalid());

  /// Get the [api.SpanContext] from this [ZoneJsParentContext], or an invalid [api.SpanContext] if no such
  /// [api.SpanContext] exists.
  @override
  api.SpanContext get spanContext =>
      (getValue(spanKey) ?? NonRecordingSpan(api.SpanContext.invalid()))
          .spanContext;
}
