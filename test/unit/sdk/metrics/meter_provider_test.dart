@TestOn('vm')

import 'package:logging/logging.dart';
import 'package:opentelemetry/sdk.dart' as sdk;

//The following requirements were used to determine what should be tested.
//[https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/metrics/api.md#meterprovider]

import 'package:test/test.dart';

void main() {
  group('MeterProvider:', () {
    setUp(() {
      Logger.root.level = Level.ALL; // defaults to Level.INFO
      Logger.root.onRecord.listen((record) {
        print('${record.level.name}: ${record.time}: ${record.message}');
      });
    });

    test(
        'failing to provide a name when getting a meter results in a functional'
        'meter and logs a message', () {
      Logger.root.onRecord.listen(expectAsync1((record) {
        expect(record.stackTrace, isNotNull);
        expect(record.message, equals('Invalid Meter Name'));
        expect(record.level, equals(Level.SEVERE));
      }));

      final meter = sdk.MeterProvider().get(null)..createCounter('test', null);
      expect(meter, isNotNull);
    });

    test('getting a meter by same name will return the same instance', () {
      const meterName = 'meterA';
      final meterProvider = sdk.MeterProvider();
      final meterA = meterProvider.get(meterName);
      final meterB = meterProvider.get(meterName);

      expect(identical(meterA, meterB), true);
    });

    test('getting by name and version will return the same meter', () {
      const meterName = 'meterA';
      const version = 'v2';
      final meterProvider = sdk.MeterProvider();
      final meterA =
          meterProvider.get(meterName, instrumentationVersion: version);
      final meterB =
          meterProvider.get(meterName, instrumentationVersion: version);

      expect(identical(meterA, meterB), true);
    });

    test(
        'getting by same name, version and schema_url will return the same meter',
        () {
      const meterName = 'meterA';
      const version = 'v2';
      const url = 'http:schemas.com';
      final meterProvider = sdk.MeterProvider();
      final meterA = meterProvider.get(meterName,
          instrumentationVersion: version, schemaUrl: url);
      final meterB = meterProvider.get(meterName,
          instrumentationVersion: version, schemaUrl: url);

      expect(identical(meterA, meterB), true);
    });

    test(
        'getting by same name, version, schema_url and attributes will return the same meter',
        () {
      const meterName = 'meterA';
      const version = 'v2';
      const url = 'http:schemas.com';
      const attributes = {'keyA': 'valueA', 'KeyB': 'valueB'};
      final meterProvider = sdk.MeterProvider();
      final meterA = meterProvider.get(meterName,
          instrumentationVersion: version,
          schemaUrl: url,
          attributes: attributes);
      final meterB = meterProvider.get(meterName,
          instrumentationVersion: version,
          schemaUrl: url,
          attributes: attributes);

      expect(identical(meterA, meterB), true);
    });

    // todo: imlpement test that verifies that changes to attributes apply to
    // previously created meters
    // https://github.com/Workiva/opentelemetry-dart/issues/74
    // test('changes to attributes apply to previously created meters', () {
    // });
  });
}
