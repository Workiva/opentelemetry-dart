@TestOn('vm')
import 'package:opentelemetry/src/sdk/trace/id_generator.dart';
import 'package:test/test.dart';

void main() {
  final generator = IdGenerator();

  test('generateSpanId is the correct length', () {
    expect(generator.generateSpanId().length, equals(8));
  });

  test('generateTraceId is the correct length', () {
    expect(generator.generateTraceId().length, equals(16));
  });
}
