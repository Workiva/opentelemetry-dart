// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import '../../../api.dart';
import '../../experimental_api.dart' show ZoneContextManager;

/// The [ContextManager] is responsible for managing the current [Context].
/// Different implementations of [ContextManager] can be registered to use different underlying storage mechanisms.
abstract class ContextManager {
  @Deprecated(
      'This method will be removed in 0.19.0. Use [globalContextManager.active] instead.')
  Context get root;

  Context get active;
}

/// The default implementation is [ZoneContextManager], which uses Dart zones to store the current [Context].
/// in the future, this will be replaced with noop context manager which maintains map context.
final ContextManager _noopContextManager = ZoneContextManager();
ContextManager _contextManager = _noopContextManager;

ContextManager get globalContextManager => _contextManager;

void registerGlobalContextManager(ContextManager contextManager) {
  if (_contextManager != _noopContextManager) {
    throw StateError(
        'Global context manager is already registered, registerContextManager must be called only once.');
  }

  _contextManager = contextManager;
}
