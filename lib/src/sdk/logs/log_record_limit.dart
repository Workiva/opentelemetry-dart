// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

class LogRecordLimits {
  static const int defaultMaxAttributeCount = 128;
  static const defaultMaxAttributeLength = -1;

  final int maxAttributeCount;
  final int maxNumAttributeLength;

  LogRecordLimits({
    this.maxAttributeCount = defaultMaxAttributeCount,
    this.maxNumAttributeLength = defaultMaxAttributeLength,
  });
}
