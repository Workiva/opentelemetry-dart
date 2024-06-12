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

import 'package:meta/meta.dart';

import '../../../api.dart';

class ZoneContext implements Context {
  final Zone _zone;

  @protected
  ZoneContext(this._zone);

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
  Context setValue(ContextKey key, Object value) =>
      ZoneContext(_zone.fork(zoneValues: {key: value}));

  /// Returns a new [ZoneContext] created from this one with the given [Span]
  /// set.
  @override
  Context withSpan(Span span) => contextWithSpan(this, span);

  /// Execute a function [fn] within this [ZoneContext] and return its result.
  @override
  R execute<R>(R Function() fn) => _zone.run(() => fn());

  /// Get the [Span] attached to this [ZoneContext], or an invalid, [Span] if no such
  /// [Span] exists.
  @override
  Span get span => spanFromContext(this);

  /// Get the [SpanContext] from this [ZoneContext], or an invalid [SpanContext] if no such
  /// [SpanContext] exists.
  @override
  SpanContext get spanContext => spanContextFromContext(this);
}
