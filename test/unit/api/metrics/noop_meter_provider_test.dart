@TestOn('vm')
import 'package:opentelemetry/api.dart' as api;
import 'package:test/test.dart';

void main() {
  group('MeterProvider:', () {
    setUp(() {});

    test('MeterProvider.get with name returns inert instance of Meter', () {
      final provider = api.NoopMeterProvider();
      expect(provider, isA<api.MeterProvider>());
      final meter = provider.get('testname');
      expect(meter, isA<api.Meter>());
      meter.createCounter('test').add(1);
    });
    test('MeterProvider.get with name+version returns inert instance of Meter',
        () {
      final provider = api.NoopMeterProvider();
      expect(provider, isA<api.MeterProvider>());
      final meter = provider.get('testname', instrumentationVersion: 'version');
      expect(meter, isA<api.Meter>());
      meter.createCounter('test').add(1);
    });

    test(
        'MeterProvider.get with name+version+url returns inert instance of Meter',
        () {
      final provider = api.NoopMeterProvider();
      expect(provider, isA<api.MeterProvider>());
      final meter = provider.get('testname',
          instrumentationVersion: 'version', schemaUrl: 'url');
      expect(meter, isA<api.Meter>());
      meter.createCounter('test').add(1);
    });

    test(
        'MeterProvider.get with name+version+url+attributes returns inert '
        'instance of Meter', () {
      final provider = api.NoopMeterProvider();
      expect(provider, isA<api.MeterProvider>());
      final meter = provider.get('testname',
          instrumentationVersion: 'version', schemaUrl: 'url', attributes: {});
      expect(meter, isA<api.Meter>());
      meter.createCounter('test').add(1);
    });
  });
}
