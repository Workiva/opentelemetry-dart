// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:opentelemetry/api.dart';

abstract class ContextManager {
  @Deprecated(
      'We are planning to remove this in the future, please use Context.current instead.')
  Context get root;

  Context get active;
}
