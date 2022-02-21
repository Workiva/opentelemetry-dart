import 'package:opentelemetry/api.dart' as api;
import 'package:test/test.dart';

class MockIdGenerator implements api.IdGenerator {
  @override
  List<int> generateTraceId() {
    return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
  }

  @override
  List<int> generateSpanId() {
    throw UnimplementedError();
  }
}

void main() {
  test('create with int list', () {
    final testTraceId = api.TraceId([1, 2, 3]);

    expect(testTraceId.get(), equals([1, 2, 3]));
    expect(testTraceId.isValid, isTrue);
    expect(testTraceId.toString(), equals('010203'));
  });

  test('create from id generator', () {
    final testTraceId = api.TraceId.fromIdGenerator(MockIdGenerator());

    expect(testTraceId.get(),
        equals([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]));
    expect(testTraceId.isValid, isTrue);
    expect(testTraceId.toString(), equals('0102030405060708090a0b0c0d0e0f'));
  });

  test('create from string', () {
    final testTraceId = api.TraceId.fromString('010203');

    expect(testTraceId.get(),
        equals([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3]));
    expect(testTraceId.isValid, isTrue);
    expect(testTraceId.toString(), equals('00000000000000000000000000010203'));
  });

  test('create invalid id', () {
    final testTraceId = api.TraceId.invalid();

    expect(testTraceId.get(),
        equals([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
    expect(testTraceId.isValid, isFalse);
    expect(testTraceId.toString(), equals('00000000000000000000000000000000'));
  });
}
