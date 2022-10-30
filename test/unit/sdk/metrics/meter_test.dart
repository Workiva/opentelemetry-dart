@TestOn('vm')
import 'package:test/test.dart';
import 'package:logging/logging.dart';
import 'package:opentelemetry/src/experimental_sdk.dart' as sdk;
void main() {
  group('Meter:', () {
    setUp(() {
      Logger.root.level = Level.ALL; // defaults to Level.INFO
      Logger.root.onRecord.listen((record) {
        printOnFailure(
            '${record.level.name}: ${record.time}: ${record.message}');
      });
    });

    test(
        'createCounter should create a counter', () {
      

      final meter = sdk.MeterProvider().get(null)..createCounter('test');
      expect(meter, isA<sdk.CounterInstrument>());
    });
  });
}