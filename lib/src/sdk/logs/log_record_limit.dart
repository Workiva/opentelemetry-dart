// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

class LogRecordLimits {
  final int attributeCountLimit;
  final int attributeValueLengthLimit;

  const LogRecordLimits({
    this.attributeCountLimit = 128,
    this.attributeValueLengthLimit = -1,
  });
}
