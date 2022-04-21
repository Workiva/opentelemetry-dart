import 'package:opentelemetry/api.dart';
import 'package:opentelemetry/sdk.dart';
import 'package:test/test.dart';

void main() {
  test('Resource attributes value is not String', () {
    expect(
        () => Resource([Attribute.fromBoolean('foo', true)]),
        throwsA(isA<ArgumentError>().having((error) => error.message, 'message',
            'Both resource attributes key and value must be String.')));
  });
}
