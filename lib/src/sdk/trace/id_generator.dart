import 'dart:math';

import '../../../src/api/trace/id_generator.dart' as api;

/// Generator responsible for generating OTel compatible.
class IdGenerator implements api.IdGenerator {
  static final Random _random = Random.secure();

  static String _generateId(int byteLength) {
    final buffer = StringBuffer();
    for (var i = 0; i < byteLength; i++) {
      buffer.write(_random.nextInt(256).toRadixString(16).padLeft(2, '0'));
    }
    return buffer.toString();
  }
  
  @override
  String generateSpanId() => _generateId(8);

  @override
  String generateTraceId() => _generateId(16);
}
