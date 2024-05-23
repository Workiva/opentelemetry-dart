// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'context.dart';
import 'context_manager.dart';
import 'map_context.dart';

final MapContext _rootContext = MapContext();

class NoopContextManager implements ContextManager {
  @override
  Context get root => _rootContext;

  @override
  Context get active => _rootContext;
}
