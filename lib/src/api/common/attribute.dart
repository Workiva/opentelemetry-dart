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

/// A representation of a single piece of metadata attached to trace span.
class Attribute {
  final String key;
  final Object value;

  /// Create an Attribute from a String value.
  Attribute.fromString(this.key, String this.value) {
    if (key == null) {
      throw ArgumentError("key can't be null.");
    }
  }

  /// Create an Attribute from a boolean value.
  // ignore: avoid_positional_boolean_parameters
  Attribute.fromBoolean(this.key, bool this.value) {
    if (key == null) {
      throw ArgumentError("key can't be null.");
    }
  }

  /// Create an Attribute from a double-precision floating-point value.
  Attribute.fromDouble(this.key, double this.value) {
    if (key == null) {
      throw ArgumentError("key can't be null.");
    }
  }

  /// Create an Attribute from an integer value.
  Attribute.fromInt(this.key, int this.value) {
    if (key == null) {
      throw ArgumentError("key can't be null.");
    }
  }

  /// Create an Attribute from a list of String values.
  Attribute.fromStringList(this.key, List<String> this.value) {
    if (key == null) {
      throw ArgumentError("key can't be null.");
    }
  }

  /// Create an Attribute from a list of boolean values.
  Attribute.fromBooleanList(this.key, List<bool> this.value) {
    if (key == null) {
      throw ArgumentError("key can't be null.");
    }
  }

  /// Create an Attribute from a list of double-precision floating-point values.
  Attribute.fromDoubleList(this.key, List<double> this.value) {
    if (key == null) {
      throw ArgumentError("key can't be null.");
    }
  }

  /// Create an Attribute from a list of integer values.
  Attribute.fromIntList(this.key, List<int> this.value) {
    if (key == null) {
      throw ArgumentError("key can't be null.");
    }
  }
}
