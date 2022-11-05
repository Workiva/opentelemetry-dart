@TestOn('vm')

import 'package:logging/logging.dart';
import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/src/experimental_sdk.dart' as sdk;
import 'package:opentelemetry/src/sdk/metrics/meter_provider.dart';

//The following requirements were used to determine what should be tested.
//[https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/metrics/api.md#meterprovider]

import 'package:test/test.dart';

void main() {
  group('MeterProvider:', () {
    setUp(() {
      Logger.root.level = Level.ALL; // defaults to Level.INFO
      Logger.root.onRecord.listen((record) {
        printOnFailure(
            '${record.level.name}: ${record.time}: ${record.message}');
      });
    });

    test(
        'failing to provide a name when getting a meter results in a functional'
        'meter and logs a message', () {
      expect(
          Logger.root.onRecord,
          emits(isA<LogRecord>()
              .having(
                (r) => r.message,
                'message',
                equals(invalidMeterNameMessage),
              )
              .having(
                (r) => r.level,
                'level',
                equals(Level.WARNING),
              )));

      final meter = sdk.MeterProvider().get(null)..createCounter('test');
      expect(meter, isNotNull);
    });

    test('getting a meter by same name will return the same instance', () {
      const meterName = 'meterA';
      final meterProvider = sdk.MeterProvider();
      final meterA = meterProvider.get(meterName);
      final meterB = meterProvider.get(meterName);

      expect(identical(meterA, meterB), true);
    });

    test('getting meters by different names will return different instances',
        () {
      const meterNameA = 'meterA';
      const meterNameB = 'meterB';
      final meterProvider = sdk.MeterProvider();
      final meterA = meterProvider.get(meterNameA);
      final meterB = meterProvider.get(meterNameB);

      expect(identical(meterA, meterB), false);
    });

    test('getting by name and version will return the same meter', () {
      const meterName = 'meterA';
      const version = 'v2';
      final meterProvider = sdk.MeterProvider();
      final meterA = meterProvider.get(meterName, version: version);
      final meterB = meterProvider.get(meterName, version: version);

      expect(identical(meterA, meterB), true);
    });

    test(
        'getting by same name yet different version will return different meter'
        ' instances', () {
      const meterName = 'meterA';
      const versionA = 'v1';
      const versionB = 'v2';
      final meterProvider = sdk.MeterProvider();
      final meterA = meterProvider.get(meterName, version: versionA);
      final meterB = meterProvider.get(meterName, version: versionB);

      expect(identical(meterA, meterB), false);
    });

    test(
        'getting by same name, version and schema_url will return the same meter',
        () {
      const meterName = 'meterA';
      const version = 'v2';
      const url = 'http:schemas.com';
      final meterProvider = sdk.MeterProvider();
      final meterA =
          meterProvider.get(meterName, version: version, schemaUrl: url);
      final meterB =
          meterProvider.get(meterName, version: version, schemaUrl: url);

      expect(identical(meterA, meterB), true);
    });

    test(
        'getting by same name, same version and different schema_url will return'
        ' different meter instances', () {
      const meterName = 'meterA';
      const version = 'v2';
      const urlA = 'http:schemas.com';
      const urlB = 'https:schemas.com';
      final meterProvider = sdk.MeterProvider();
      final meterA =
          meterProvider.get(meterName, version: version, schemaUrl: urlA);
      final meterB =
          meterProvider.get(meterName, version: version, schemaUrl: urlB);

      expect(identical(meterA, meterB), false);
    });

    test(
        'getting by same name, version, schema_url and attributes will return the same meter',
        () {
      const meterName = 'meterA';
      const version = 'v2';
      const url = 'http:schemas.com';
      final attributes = [
        api.Attribute.fromString('keyA', 'valueA'),
        api.Attribute.fromString('KeyB', 'valueBBB')
      ];
      final meterProvider = sdk.MeterProvider();
      final meterA = meterProvider.get(meterName,
          version: version, schemaUrl: url, attributes: attributes);
      final meterB = meterProvider.get(meterName,
          version: version, schemaUrl: url, attributes: attributes);

      expect(identical(meterA, meterB), true);
    });

    test(
        'getting by same name, same version, same schema_url and different '
        'attributes will return different meter instances', () {
      const meterName = 'meterA';
      const version = 'v2';
      const url = 'http:schemas.com';
      final attributesA = [
        api.Attribute.fromString('keyA', 'valueA'),
        api.Attribute.fromString('KeyB', 'valueBBB')
      ];
      final attributesB = [
        api.Attribute.fromString('keyA', 'valueA'),
        api.Attribute.fromString('KeyB', 'valueB')
      ];
      final meterProvider = sdk.MeterProvider();
      final meterA = meterProvider.get(meterName,
          version: version, schemaUrl: url, attributes: attributesA);
      final meterB = meterProvider.get(meterName,
          version: version, schemaUrl: url, attributes: attributesB);

      expect(identical(meterA, meterB), false);
    });

    test('resource can be set', () {
      final resource = sdk.Resource([api.Attribute.fromString('foo', 'bar')]);
      final provider = sdk.MeterProvider(resource: resource);
      expect(identical(resource, provider.resource), true);
    });

    // todo: implement test that verifies that changes to attributes apply to
    // previously created meters
    // https://github.com/Workiva/opentelemetry-dart/issues/74
    // test('changes to attributes apply to previously created meters', () {
    // });
  });
}
