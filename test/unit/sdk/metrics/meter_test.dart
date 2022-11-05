@TestOn('vm')
import 'package:test/test.dart';
import 'package:logging/logging.dart';
import 'package:opentelemetry/src/experimental_sdk.dart' as sdk;
import 'package:opentelemetry/api.dart';

void main() {
  group('Meter:', () {
    setUp(() {
      Logger.root.level = Level.ALL; // defaults to Level.INFO
      Logger.root.onRecord.listen((record) {
        printOnFailure(
            '${record.level.name}: ${record.time}: ${record.message}');
      });
    });

    test('resource is available from Meter', () {
      final resource = sdk.Resource([Attribute.fromString('foo', 'bar')]);
      final provider = sdk.MeterProvider(resource: resource);
      final sdk.Meter meter = provider.get('test');

      expect(meter)
    });
  });
}
