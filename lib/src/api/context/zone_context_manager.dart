// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'dart:async';

import '../../../api.dart' show Context;
import '../../experimental_api.dart' show ContextManager;
import 'zone_context.dart' show createZoneContext;

class ZoneContextManager implements ContextManager {
  @override
  Context get root => createZoneContext(Zone.root);

  @override
  Context get active => createZoneContext(Zone.current);
}
