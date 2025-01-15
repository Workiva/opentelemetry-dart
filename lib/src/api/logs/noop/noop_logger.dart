// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:opentelemetry/src/api/context/context.dart';
import 'package:opentelemetry/src/api/logs/log_record.dart';
import 'package:opentelemetry/src/api/logs/logger.dart';
import 'package:opentelemetry/src/sdk/common/attributes.dart';

class NoopLogger implements Logger {
  const NoopLogger();

  @override
  void emit({
    Attributes? attributes,
    Context? context,
    dynamic body,
    DateTime? observedTimestamp,
    Severity? severityNumber,
    String? severityText,
    DateTime? timeStamp,
  }) {}
}
