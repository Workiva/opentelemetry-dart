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

import 'dart:math';

import '../../../api.dart' as api;

/// Generator responsible for generating OTel compatible.
class IdGenerator implements api.IdGenerator {
  static final Random _random = Random.secure();

  static List<int> _generateId(int byteLength) {
    final buffer = [];
    for (var i = 0; i < byteLength; i++) {
      buffer.add(_random.nextInt(256));
    }
    return buffer.cast<int>();
  }

  @override
  List<int> generateSpanId() => _generateId(8);

  @override
  List<int> generateTraceId() => _generateId(16);
}
