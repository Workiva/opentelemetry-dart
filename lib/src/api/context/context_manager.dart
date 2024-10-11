// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'context.dart' show Context;
import 'context.dart' as global show active, root;

/// The [ContextManager] is responsible for managing the current [Context].
/// Different implementations of [ContextManager] can be registered to use
/// different underlying storage mechanisms.
@Deprecated('This class will be removed in 0.19.0 without replacement.')
class ContextManager {
  @Deprecated(
      'This method will be removed in 0.19.0. Use the API global function '
      '[root] instead.')
  Context get root => global.root;

  @Deprecated(
      'This method will be removed in 0.19.0. Use the API global function '
      '[active] instead.')
  Context get active => global.active;
}

final ContextManager _noopContextManager = ContextManager();
ContextManager _contextManager = _noopContextManager;

@Deprecated('This method will be removed in 0.19.0. Use the API global '
    'function [active] instead.')
ContextManager get globalContextManager => _contextManager;

@Deprecated('This method will be removed in 0.19.0 without replacement.')
void registerGlobalContextManager(ContextManager contextManager) {
  if (_contextManager != _noopContextManager) {
    throw StateError(
        'Global context manager is already registered, registerContextManager '
        'must be called only once.');
  }

  _contextManager = contextManager;
}
