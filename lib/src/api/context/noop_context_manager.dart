// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'context.dart';
import 'context_manager.dart';
import 'map_context.dart';

class NoopContextManager implements ContextManager {
  final MapContext _rootContext = MapContext();
  final MapContext _activeContext = MapContext();

  @override
  @Deprecated(
      'We are planning to remove this in the future, please use Context.current instead.')
  Context get root => _rootContext;

  @override
  Context get active => _activeContext;
}

/// The default implementation is [NoopContextManager], which uses Dart zones to store the current [Context].
ContextManager _contextManager = NoopContextManager();

void registerContextManager(ContextManager contextManager) {
  _contextManager = contextManager;
}

ContextManager getContextManager() {
  return _contextManager;
}
