// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:opentelemetry/sdk.dart' as sdk;

/// https://opentelemetry.io/docs/specs/otel/logs/sdk/#logrecordprocessor
abstract class LogRecordProcessor {
  void onEmit(sdk.ReadWriteLogRecord logRecord);

  Future<void> forceFlush();

  Future<void> shutdown();
}
