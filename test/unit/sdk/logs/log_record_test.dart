// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

@TestOn('vm')
import 'package:fixnum/fixnum.dart';
import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/experimental_api.dart' as api;
import 'package:opentelemetry/src/experimental_sdk.dart' as sdk;
import 'package:test/test.dart';

import '../../mocks.dart';

void main() {
  test('set readonly will block values from being set', () {
    final logRecord = sdk.LogRecord(
        instrumentationScope: sdk.InstrumentationScope('library_name', 'library_version', 'url://schema', []),
        logRecordLimits: sdk.LogRecordLimits(),
        timeProvider: FakeTimeProvider(now: Int64(123)))
      ..makeReadonly()
      ..body = 'Log Message'
      ..severityNumber = api.Severity.debug
      ..severityText = 'DEBUG'
      ..setAttributes(sdk.Attributes.empty()..add(api.Attribute.fromString('key', 'value')))
      ..setAttribute('key2', 'value2');

    expect(logRecord.body, null);
    expect(logRecord.severityNumber, null);
    expect(logRecord.severityText, null);
    expect(logRecord.attributes?.keys, const <String>[]);
    expect(logRecord.droppedAttributesCount, 0);
    expect(logRecord.hrTime, Int64(123));
    expect(logRecord.hrTimeObserved, Int64(123));
  });

  test('logRecord call setter', () {
    final logRecord = sdk.LogRecord(
        instrumentationScope: sdk.InstrumentationScope('library_name', 'library_version', 'url://schema', []),
        logRecordLimits: sdk.LogRecordLimits(),
        timeProvider: FakeTimeProvider(now: Int64(123)))
      ..body = 'Log Message'
      ..severityNumber = api.Severity.debug
      ..severityText = 'DEBUG'
      ..setAttributes(sdk.Attributes.empty()..add(api.Attribute.fromString('key', 'value')))
      ..setAttribute('key2', 'value2');

    expect(logRecord.body, 'Log Message');
    expect(logRecord.severityNumber, api.Severity.debug);
    expect(logRecord.severityText, 'DEBUG');
    expect(logRecord.attributes?.keys, const <String>['key', 'key2']);
    expect(logRecord.droppedAttributesCount, 0);
    expect(logRecord.hrTime, Int64(123));
    expect(logRecord.hrTimeObserved, Int64(123));
  });

  test('logRecord update same attribute will create attributesCount diff', () {
    final logRecord = sdk.LogRecord(
      instrumentationScope: sdk.InstrumentationScope('library_name', 'library_version', 'url://schema', []),
      logRecordLimits: sdk.LogRecordLimits(),
    )
      ..setAttributes(sdk.Attributes.empty()..add(api.Attribute.fromString('key2', 'value')))
      ..setAttribute('key2', 'value2');

    expect(logRecord.droppedAttributesCount, 1);
  });

  test('logRecord time stamp will be converted to Int64', () {
    final now = DateTime.now();
    final logRecord = sdk.LogRecord(
      instrumentationScope: sdk.InstrumentationScope('library_name', 'library_version', 'url://schema', []),
      timeStamp: now,
      observedTimestamp: now,
      logRecordLimits: sdk.LogRecordLimits(),
    )
      ..setAttributes(sdk.Attributes.empty()..add(api.Attribute.fromString('key2', 'value')))
      ..setAttribute('key2', 'value2');

    expect(logRecord.hrTime, Int64(now.microsecondsSinceEpoch) * 1000);
    expect(logRecord.hrTimeObserved, Int64(now.microsecondsSinceEpoch) * 1000);
  });

  test('logRecord set attribute', () {
    final now = DateTime.now();
    final logRecord = sdk.LogRecord(
      instrumentationScope: sdk.InstrumentationScope('library_name', 'library_version', 'url://schema', []),
      timeStamp: now,
      observedTimestamp: now,
      logRecordLimits: sdk.LogRecordLimits(maxNumAttributeLength: 2),
    )
      ..setAttribute('key', 'value')
      ..setAttribute('key2', true)
      ..setAttribute('key3', 1)
      ..setAttribute('key4', 1.1)
      ..setAttribute('key5', ['value2'])
      ..setAttribute('key6', [true])
      ..setAttribute('key7', [1])
      ..setAttribute('key8', [1.1]);

    expect(logRecord.droppedAttributesCount, 0);
    expect(logRecord.attributes?.keys, const ['key', 'key2', 'key3', 'key4', 'key5', 'key6', 'key7', 'key8']);
    expect(logRecord.attributes?.get('key'), 'va');
  });

  test('logRecord set attribute with limit', () {
    final now = DateTime.now();
    final logRecord = sdk.LogRecord(
      instrumentationScope: sdk.InstrumentationScope('library_name', 'library_version', 'url://schema', []),
      timeStamp: now,
      observedTimestamp: now,
      logRecordLimits: sdk.LogRecordLimits(maxNumAttributeLength: 2),
    )
      ..setAttribute('key', 'value')
      ..setAttribute('key2', ['value2']);

    expect(logRecord.attributes?.get('key'), 'va');
    expect(logRecord.attributes?.get('key2'), const ['va']);
  });
}
