// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import '../../../api.dart' as api;
import '../common/attributes.dart';

class Resource {
  final Attributes _attributes;

  Resource.empty() : _attributes = Attributes.empty();

  factory Resource(List<api.Attribute> attributeList) {
    for (final attribute in attributeList) {
      if (attribute.value is! String) {
        throw ArgumentError('Attributes value must be String.');
      }
    }
    final attributes = Attributes.empty()..addAll(attributeList);
    return Resource.fromAttributes(attributes);
  }

  Resource.fromAttributes(this._attributes);

  Attributes get attributes => _attributes;
}
