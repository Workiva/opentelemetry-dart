// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:opentelemetry/src/experimental_sdk.dart' as sdk;

abstract class LogRecordExporter {
  Future<sdk.ExportResult> export(List<sdk.ReadableLogRecord> logs);

  Future<void> shutdown();
}
