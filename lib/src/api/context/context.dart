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

class Context {
  /// The active context.
  static Context get current => _current ?? Context._(Zone.current);
  static Context _current;

  /// Returns a key to be used to read and/or write values to a context.
  ///
  /// [name] is for debug purposes only and does not uniquely identify the key.
  /// Multiple calls to this function with the same [name] will not return
  /// identical keys.
  static ContextKey createKey(String name) => ContextKey(name);

  /// Makes [context] the active context (such that [current] returns this given
  /// context) and returns a scope that should closed by passing it to [detach].
  ///
  /// Every call to [attach] should result in a corresponding call to [detach].
  static Scope attach(Context context) {
    if (context == null) {
      // Null context not allowed, so ignore it.
      return Scope._noop;
    }

    if (context._zone == _current?._zone) {
      return Scope._noop;
    }

    final prev = _current;
    _current = context;
    return Scope._(() {
      _current = prev;
    });
  }

  /// Resets the active context to the value that was active before attaching
  /// the context associated with [scope].
  ///
  /// If [scope] is associated with a context that is not the active one, an
  /// error will be logged.
  void detach(Scope scope) {
    scope._close();
  }

  /// The implicit "context" that is used to implement the APIs on this class.
  final Zone _zone;

  Context._(this._zone);

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
}

class ContextKey {
  /// name of the context key.
  final String name;

  /// construct a [ContextKey] with a given [name].
  ContextKey(this.name);
}

class Scope {
  static final Scope _noop = Scope._(() {});
  final void Function() _close;
  Scope._(this._close);
}
