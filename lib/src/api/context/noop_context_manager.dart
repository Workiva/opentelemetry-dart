// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import '../../../api.dart' show Context;
import '../../experimental_api.dart' show ContextManager;
import 'map_context.dart' show MapContext;

final MapContext _rootContext = MapContext();

class NoopContextManager implements ContextManager {
  @override
  Context get root => _rootContext;

  @override
  Context get active => _rootContext;
}
