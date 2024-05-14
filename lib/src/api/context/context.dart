// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information
import 'package:opentelemetry/src/sdk/context/zone_context_manager.dart';

import '../../../api.dart' as api;
import 'context_manager.dart';

/// [ContextKey] used to store spans in a [Context].
final ContextKey spanKey = Context.createKey('OpenTelemetry Context Key SPAN');

/// The [ContextManager] is responsible for managing the current [Context].
/// Different implementations of [ContextManager] can be registered to use different underlying storage mechanisms.
/// The default implementation is [ZoneContextManager], which uses Dart zones to store the current [Context].
ContextManager _contextManager = ZoneContextManager();

abstract class Context {
  static void RegisterContextManager(ContextManager contextManager) {
    _contextManager = contextManager;
  }

  /// The active context.
  static Context get current => _contextManager.active;

  /// The root context which all other contexts are derived from.
  ///
  /// It should generally not be required to use the root [Context] directly -
  /// instead, use [Context.current] to operate on the current [Context].
  /// Only use this context if you are certain you need to disregard the
  /// current [Context].  For example, when instrumenting an asynchronous
  /// event handler which may fire while an unrelated [Context] is "current".
  @Deprecated(
      'We are planning to remove this in the future, please use Context.current instead.')
  static Context get root => _contextManager.root;

  /// Returns a key to be used to read and/or write values to a context.
  ///
  /// [name] is for debug purposes only and does not uniquely identify the key.
  /// Multiple calls to this function with the same [name] will not return
  /// identical keys.
  static ContextKey createKey(String name) => ContextKey(name);

  /// Returns the value from this context identified by [key], or null if no
  /// such value is set.
  T? getValue<T>(ContextKey key);

  /// Returns a new context created from this one with the given key/value pair
  /// set.
  ///
  /// If [key] was already set in this context, it will be overridden. The rest
  /// of the context values will be inherited.
  Context setValue(ContextKey key, Object value);

  /// Returns a new [Context] created from this one with the given [api.Span]
  /// set.
  Context withSpan(api.Span span);

  /// Execute a function [fn] within this [Context] and return its result.
  R execute<R>(R Function() fn);

  /// Get the [api.Span] attached to this [Context], or an invalid, [api.Span] if no such
  /// [api.Span] exists.
  api.Span get span;

  /// Get the [api.SpanContext] from this [Context], or an invalid [api.SpanContext] if no such
  /// [api.SpanContext] exists.
  api.SpanContext get spanContext;
}

class ContextKey {
  /// Name of the context key.
  final String name;

  /// Construct a [ContextKey] with a given [name].
  ContextKey(this.name);
}
