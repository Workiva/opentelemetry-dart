// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import '../../../api.dart';

/// A representation of a collection of metadata attached to a trace span.
class Attributes {
  Map<String?, Object> _attributes = {};

  /// Instantiate an empty Attributes.
  Attributes.empty() {
    _attributes = {};
  }

  /// Retrieve the value associated with the Attribute with key [key].
  Object? get(String? key) => _attributes[key];

  ///
  int get length => _attributes.length;

  /// Retrieve the keys of all Attributes in this collection.
  Iterable<String?> get keys => _attributes.keys;

  /// Add an Attribute [attribute].
  /// If an Attribute with the same key already exists, it will be overwritten.
  void add(Attribute attribute) {
    _attributes[attribute.key] = attribute.value;
  }

  /// Add all Attributes in List [attributes].
  /// If an Attribute with the same key already exists, it will be overwritten.
  void addAll(List<Attribute> attributes) {
    attributes.forEach(add);
  }
}
