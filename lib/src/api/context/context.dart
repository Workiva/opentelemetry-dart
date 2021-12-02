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
/// changed aftewards.
/// - Reading and writing values: a Zone implements the `[]` operator, allowing
/// values to be read directly from it like a [Map], and writing values is
/// possible only by forking another Zone and providing values to add/override
/// (the rest of the values will be inherited from the forked Zone).
///
/// This library provides a simple abstraction over [Zone] for the purpose of
/// implementing the rest of the Context specification. OpenTelemetry SDKs and
/// instrumentation libraries should use this [Context] API instead of a [Zone]
/// directly. Other users should usually not interact with Context at all and
/// should instead manipulate it through cross-cutting concerns APIs provided by
/// OpenTelemetry SDKs.
import 'dart:async';

import '../../sdk/common/attribute.dart';
import '../../sdk/trace/span.dart';
import '../../sdk/trace/span_context.dart';
import '../trace/span_status.dart';

/// [ContextKey] used to store spans in a [Context].
final ContextKey spanKey = Context.createKey('OpenTelemetry Context Key SPAN');

class Context {
  final Zone _zone;

  Context._(this._zone);

  /// The active context.
  static Context get current => Context._(Zone.current);

  /// The root context which all other contexts are derived from.
  ///
  /// It should generally not be required to use the root [Context] directly -
  /// instead, use [Context.current] to operate on the current [Context].
  /// Only use this context if you are certain you need to disregard the
  /// current [Context].  For example, when instrumenting an asynchronous
  /// event handler which may fire while an unrelated [Context] is "current".
  static Context get root => Context._(Zone.root);

  /// Returns a key to be used to read and/or write values to a context.
  ///
  /// [name] is for debug purposes only and does not uniquely identify the key.
  /// Multiple calls to this function with the same [name] will not return
  /// identical keys.
  static ContextKey createKey(String name) => ContextKey(name);

  /// Returns the value from this context identified by [key], or null if no
  /// such value is set.
  T getValue<T>(ContextKey key) => _zone[key];

  /// Returns a new context created from this one with the given key/value pair
  /// set.
  ///
  /// If [key] was already set in this context, it will be overridden. The rest
  /// of the context values will be inherited.
  Context setValue(ContextKey key, Object value) =>
      Context._(_zone.fork(zoneValues: {key: value}));

  /// Returns a new [Context] created from this one with the given [Span]
  /// set.
  Context withSpan(Span span) => setValue(spanKey, span);

  /// Execute a function [fn] within this [Context] and return its result.
  R execute<R>(R Function() fn) => _zone.run(fn);

  /// Records a span of the given [name] about the given function and marks the
  /// span as errored if an exception occurs.
  R trace<R>(String name, R Function() fn) {
    return execute(() {
      final child = span.tracer.startSpan(name);
      try {
        return withSpan(child).execute(fn);
      } catch (e) {
        // TODO: follow standard if exists and add stack trace
        span.setStatus(StatusCode.error);
        span.attributes.add(Attribute.fromString('exception', e.toString()));
        rethrow;
      } finally {
        child.end();
      }
    });
  }

  /// Get the [Span] attached to this [Context], or null if no such
  /// [Span] exists.
  Span get span => getValue(spanKey);

  /// Get the [SpanContext] from this [Context], or null if no such
  /// [SpanContext] exists.
  SpanContext get spanContext => getValue(spanKey)?.spanContext;
}

class ContextKey {
  /// Name of the context key.
  final String name;

  /// Construct a [ContextKey] with a given [name].
  ContextKey(this.name);
}
