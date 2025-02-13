// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

// https://opentelemetry.io/docs/specs/otel/logs/sdk/#logrecord-limits
abstract class LogRecordLimits {
  // https://opentelemetry.io/docs/specs/otel/common/#configurable-parameters

  int get attributeCountLimit;

  int get attributeValueLengthLimit;
}

class LogRecordLimitsImpl implements LogRecordLimits {
  final int _attributeCountLimit;
  final int _attributeValueLengthLimit;

  const LogRecordLimitsImpl({
    int attributeCountLimit = 128,
    int attributeValueLengthLimit = -1,
  })  : _attributeCountLimit = attributeCountLimit,
        _attributeValueLengthLimit = attributeValueLengthLimit;

  @override
  int get attributeCountLimit => _attributeCountLimit;

  @override
  int get attributeValueLengthLimit => _attributeValueLengthLimit;
}
