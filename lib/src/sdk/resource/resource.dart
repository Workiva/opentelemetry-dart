// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import '../../../api.dart' as api;
import '../common/attributes.dart';

class Resource {
  final Attributes _attributes = Attributes.empty();

  Resource(List<api.Attribute> attributes) {
    for (final attribute in attributes) {
      if (attribute.value is! String) {
        throw ArgumentError('Attributes value must be String.');
      }
    }
    _attributes.addAll(attributes);
  }

  Resource.empty();

  Attributes get attributes => _attributes;
}
