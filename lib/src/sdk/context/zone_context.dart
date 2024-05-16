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
/// instrumentation libraries should use this [ZoneContext] API instead of a [Zone]
/// directly. Other users should usually not interact with Context at all and
/// should instead manipulate it through cross-cutting concerns APIs provided by
/// OpenTelemetry SDKs.
import 'dart:async';

import '../../../api.dart';

/// [ContextKey] used to store spans in a [ZoneContext].
final ContextKey spanKey =
    ZoneContext.createKey('OpenTelemetry Context Key SPAN');

class ZoneContext implements Context {
  final Zone _zone;

  ZoneContext._(this._zone);

  /// The active context.
  static ZoneContext get current => ZoneContext._(Zone.current);

  /// The root context which all other contexts are derived from.
  ///
  /// It should generally not be required to use the root [ZoneContext] directly -
  /// instead, use [ZoneContext.current] to operate on the current [ZoneContext].
  /// Only use this context if you are certain you need to disregard the
  /// current [ZoneContext].  For example, when instrumenting an asynchronous
  /// event handler which may fire while an unrelated [ZoneContext] is "current".
  @Deprecated(
      'We are planning to remove this in the future, please use Context.current instead.')
  static ZoneContext get root => ZoneContext._(Zone.root);

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
  ZoneContext setValue(ContextKey key, Object value) =>
      ZoneContext._(_zone.fork(zoneValues: {key: value}));

  /// Returns a new [ZoneContext] created from this one with the given [Span]
  /// set.
  @override
  ZoneContext withSpan(Span span) => setValue(spanKey, span);

  /// Execute a function [fn] within this [ZoneContext] and return its result.
  @override
  R execute<R>(R Function() fn) => _zone.run(fn);

  /// Get the [Span] attached to this [ZoneContext], or an invalid, [Span] if no such
  /// [Span] exists.
  @override
  Span get span => getValue(spanKey) ?? NonRecordingSpan(SpanContext.invalid());

  /// Get the [SpanContext] from this [ZoneContext], or an invalid [SpanContext] if no such
  /// [SpanContext] exists.
  @override
  SpanContext get spanContext => span.spanContext;
}
