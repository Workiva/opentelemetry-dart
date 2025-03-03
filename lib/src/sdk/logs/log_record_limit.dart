// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

class LogRecordLimits {
  final int _attributeCountLimit;
  final int _attributeValueLengthLimit;

  const LogRecordLimits({
    int attributeCountLimit = 128,
    int attributeValueLengthLimit = -1,
  })  : _attributeCountLimit = attributeCountLimit,
        _attributeValueLengthLimit = attributeValueLengthLimit;

  int get attributeCountLimit => _attributeCountLimit;

  int get attributeValueLengthLimit => _attributeValueLengthLimit;
}
