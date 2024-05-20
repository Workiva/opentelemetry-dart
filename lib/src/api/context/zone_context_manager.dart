// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import '../../../api.dart';
import '../../experimental_api.dart';
import 'zone_context.dart';

class ZoneContextManager implements ContextManager {
  @override
  Context get active => ZoneContext.current;

  @Deprecated(
      'We are planning to remove this in the future, please use Context.current instead.')
  @override
  Context get root => ZoneContext.root;
}
