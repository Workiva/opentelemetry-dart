// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:opentelemetry/api.dart';

import 'zone_context_manager.dart';

/// The [ContextManager] is responsible for managing the current [Context].
/// Different implementations of [ContextManager] can be registered to use different underlying storage mechanisms.
abstract class ContextManager {
  @Deprecated(
      'We are planning to remove this in the future, please use Context.current instead.')
  Context get root;

  Context get active;
}

/// The default implementation is [ZoneContextManager], which uses Dart zones to store the current [Context].
/// in the future, this will be replaced with noop context manager which maintains map context.
final ContextManager _noopcontextManager = ZoneContextManager();
ContextManager _contextManager = _noopcontextManager;

ContextManager get globalContextManager => _contextManager;

void registerGlobalContextManager(ContextManager contextManager) {
  if (_contextManager != _noopcontextManager) {
    throw StateError(
        'Global context manager is already registered, registerContextManager must be called only once before any calls to the getter globalContextManager.');
  }

  _contextManager = contextManager;
}
