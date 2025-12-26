// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import '../../../api.dart' as api;
import '../common/attributes.dart';

class Resource {
  final Attributes _attributes;

  Resource(List<api.Attribute> attributes)
      : _attributes = Attributes.empty()..addAll(attributes);

  Attributes get attributes => _attributes;
}
