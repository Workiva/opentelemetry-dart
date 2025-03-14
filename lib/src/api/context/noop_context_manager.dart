// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import '../../../api.dart' show Context;
import '../../experimental_api.dart' show ContextManager;
import 'map_context.dart' show createMapContext;

final _root = createMapContext();

@Deprecated('This class will be removed in 0.19.0 without replacement.')
class NoopContextManager implements ContextManager {
  @override
  Context get root => _root;

  @override
  Context get active => _root;
}
