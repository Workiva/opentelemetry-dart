// Copyright 2021-2022 Workiva Inc.

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at

//     http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import '../../../api.dart';

/// A representation of a collection of metadata attached to a trace span.
class Attributes {
  Map<String, Object> _attributes = {};

  /// Instantiate an empty Attributes.
  Attributes.empty() {
    _attributes = {};
  }

  /// Retrieve the value associated with the Attribute with key [key].
  Object get(String key) => _attributes[key];

  ///
  int get length => _attributes.length;

  /// Retrieve the keys of all Attributes in this collection.
  Iterable<String> get keys => _attributes.keys;

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
