// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:opentelemetry/api.dart';
import 'package:opentelemetry/src/sdk/context/zone_context_manager.dart';

abstract class ContextManager {
  static ContextManager _current = ZoneContextManager();
  Context get rootContext;
  Context get activeContext;

  static void registerContextManager(ContextManager contextManager) {
    _current = contextManager;
  }

  static Context get current {
    return _current.activeContext;
  }

  static Context get root {
    return _current.rootContext;
  }
}
