// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'package:fixnum/fixnum.dart';
import 'package:mocktail/mocktail.dart';
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/experimental_sdk.dart' as sdk;
import 'package:opentelemetry/src/sdk/logs/log_record_limit.dart';
import 'package:test/test.dart';

import '../../mocks.dart';

class MockLockRecordProcessor extends Mock implements sdk.LogRecordProcessor {}

void main() {
  setUpAll(() {
    registerFallbackValue(sdk.LogRecord(
      instrumentationScope: sdk.InstrumentationScope('library_name', 'library_version', 'url://schema', []),
      logRecordLimits: LogRecordLimits(),
    ));
  });

  test('emit new log', () {
    final processor = MockLockRecordProcessor();
    sdk.Logger(
      sdk.InstrumentationScope(
        'library_name',
        'library_version',
        'url://schema',
        [],
      ),
      LogRecordLimits(),
      FakeTimeProvider(now: Int64(60)),
      [processor],
      sdk.Resource([]),
    ).emit(body: 'TEST!');

    verify(() => processor.onEmit(any<sdk.LogRecord>(that: predicate<sdk.LogRecord>((it) {
          return it.attributes.keys.isEmpty == true &&
              it.instrumentationScope.name == 'library_name' &&
              it.instrumentationScope.version == 'library_version' &&
              it.instrumentationScope.schemaUrl == 'url://schema' &&
              it.resource.attributes.keys.isEmpty == true;
        })))).called(1);
  });
}
