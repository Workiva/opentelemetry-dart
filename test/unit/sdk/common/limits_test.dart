// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/src/sdk/common/limits.dart';
import 'package:opentelemetry/src/sdk/logs/log_record_limit.dart';
import 'package:test/test.dart';

void main() {
  test('test log record limit', () {
    final logLimit = applyAttributeLimitsForLog(
      api.Attribute.fromString('key', 'value'),
      LogRecordLimitsImpl(attributeValueLengthLimit: 2),
    );

    expect(logLimit.value, 'va');
  });

  test('test log record limit list', () {
    final logLimit = applyAttributeLimitsForLog(
      api.Attribute.fromStringList('key', ['value1', 'value2']),
      LogRecordLimitsImpl(attributeValueLengthLimit: 2),
    );

    expect(logLimit.value, ['va', 'va']);
  });
}
