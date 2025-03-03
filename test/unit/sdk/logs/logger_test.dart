// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'package:mocktail/mocktail.dart';
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/experimental_sdk.dart' as sdk;
import 'package:opentelemetry/src/sdk/logs/log_record_limit.dart';
import 'package:test/test.dart';

class Callback {
  const Callback();

  void call(sdk.ReadWriteLogRecord logRecord) {}
}

class CallbackMock extends Mock implements Callback {}

void main() {
  setUpAll(() {
    registerFallbackValue(sdk.LogRecord(
      instrumentationScope: sdk.InstrumentationScope('library_name', 'library_version', 'url://schema', []),
      logRecordLimits: LogRecordLimits(),
    ));
  });

  test('emit new log', () {
    final callBack = CallbackMock();
    sdk.Logger(
      logRecordLimits: LogRecordLimits(),
      instrumentationScope: sdk.InstrumentationScope(
        'library_name',
        'library_version',
        'url://schema',
        [],
      ),
      resource: sdk.Resource([]),
      onLogEmit: callBack,
    ).emit(body: 'TEST!');

    verify(() => callBack.call(any<sdk.LogRecord>(that: predicate<sdk.LogRecord>((it) {
          return it.attributes?.keys.isEmpty == true &&
              it.instrumentationScope.name == 'library_name' &&
              it.instrumentationScope.version == 'library_version' &&
              it.instrumentationScope.schemaUrl == 'url://schema' &&
              it.resource?.attributes.keys.isEmpty == true;
        })))).called(1);
  });
}
