// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import '../../../api.dart' as api;
import 'log_record.dart';

abstract class Logger {
  void emit({
    List<api.Attribute> attributes = const <api.Attribute>[],
    api.Context? context,
    dynamic body,
    DateTime? observedTimestamp,
    Severity? severityNumber,
    String? severityText,
    DateTime? timeStamp,
  });
}
