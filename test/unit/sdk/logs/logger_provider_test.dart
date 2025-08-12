// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'package:fixnum/src/int64.dart';
import 'package:mocktail/mocktail.dart';
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/sdk/logs/log_record_limit.dart';
import 'package:test/test.dart';

import '../../mocks.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(sdk.LogRecord(
      instrumentationScope: sdk.InstrumentationScope('library_name', 'library_version', 'url://schema', []),
      logRecordLimits: LogRecordLimits(),
    ));
  });

  test('traceProvider custom timeProvider', () {
    final mockTimeProvider = FakeTimeProvider(now: Int64(123));
    final mockProcessor1 = MockLogRecordProcessor();
    final provider = sdk.LoggerProvider(timeProvider: mockTimeProvider, processors: [mockProcessor1]);
    provider.get('foo').emit();
    verify(() => mockProcessor1.onEmit(any(
          that: predicate((a) {
            if (a is! sdk.ReadWriteLogRecord) return false;
            return a.timeStamp == DateTime.fromMicrosecondsSinceEpoch(123 ~/ 1000) &&
                a.observedTimestamp == DateTime.fromMicrosecondsSinceEpoch(123 ~/ 1000);
          }),
        ))).called(1);
  });

  test('loggerProvider force flushes all processors', () async {
    final mockProcessor1 = MockLogRecordProcessor();
    final mockProcessor2 = MockLogRecordProcessor();
    when(mockProcessor1.forceFlush).thenAnswer((_) async => Future.value());
    when(mockProcessor2.forceFlush).thenAnswer((_) async => Future.value());
    sdk.LoggerProvider(processors: [mockProcessor1, mockProcessor2]).forceFlush();

    verify(mockProcessor1.forceFlush).called(1);
    verify(mockProcessor2.forceFlush).called(1);
  });

  test('loggerProvider shuts down all processors', () async {
    final mockProcessor1 = MockLogRecordProcessor();
    final mockProcessor2 = MockLogRecordProcessor();
    when(mockProcessor1.shutdown).thenAnswer((_) async => Future.value());
    when(mockProcessor2.shutdown).thenAnswer((_) async => Future.value());
    sdk.LoggerProvider(processors: [mockProcessor1, mockProcessor2]).shutdown();

    verify(mockProcessor1.shutdown).called(1);
    verify(mockProcessor2.shutdown).called(1);
  });
}
