@TestOn('vm')

import 'package:logging/logging.dart';
import 'package:opentelemetry/api.dart';
import 'package:opentelemetry/src/sdk/common/instrumentation_scope.dart';
import 'package:opentelemetry/src/sdk/metrics/state/meter_provider_shared_state.dart';
import 'package:test/test.dart';

void main() {
  group('instrumentationScopeId:', () {
    setUp(() {
      Logger.root.level = Level.ALL; // defaults to Level.INFO
      Logger.root.onRecord.listen((record) {
        printOnFailure(
            '${record.level.name}: ${record.time}: ${record.message}');
      });
    });

    test('instrumentationScopeId with same parameters returns same id', () {
      //int instrumentationScopeId(InstrumentationScope instrumentationScope) {
      const nameOne = 'testName';
      const versionOne = '';
      const schemaUrlOne = '';
      const attributesOne = <Attribute>[];

      const nameTwo = 'testName';
      const versionTwo = '';
      const schemaUrlTwo = '';
      const attributesTwo = <Attribute>[];

      final scopeOne = InstrumentationScope(
          nameOne, versionOne, schemaUrlOne, attributesOne);
      final idOne = instrumentationScopeId(scopeOne);

      final scopeTwo = InstrumentationScope(
          nameTwo, versionTwo, schemaUrlTwo, attributesTwo);
      final idTwo = instrumentationScopeId(scopeTwo);

      expect(idOne, equals(idTwo));
    });
  });
}
