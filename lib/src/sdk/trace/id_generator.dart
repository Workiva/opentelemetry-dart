// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

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
