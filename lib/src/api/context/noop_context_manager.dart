// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:opentelemetry/src/api/context/zone_context_manager.dart';

import 'context.dart';
import 'context_manager.dart';
import 'map_context.dart';

final MapContext _rootContext = MapContext();

class NoopContextManager implements ContextManager {
  @override
  @Deprecated(
      'We are planning to remove this in the future, please use Context.current instead.')
  Context get root => _rootContext;

  @override
  Context get active => _rootContext;
}

/// The default implementation is [ZoneContextManager], which uses Dart zones to store the current [Context].
/// in the future, this will be replaced with map context manager.
ContextManager _contextManager = ZoneContextManager();

void registerContextManager(ContextManager contextManager) {
  _contextManager = contextManager;
}

ContextManager getContextManager() {
  return _contextManager;
}
