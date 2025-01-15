// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:meta/meta.dart';
import 'package:opentelemetry/src/experimental_sdk.dart' as sdk;

/// This class can be used for testing purposes. It stores the exported LogRecords
/// in a list in memory that can be retrieved using the `getFinishedLogRecords()`
/// method.
class InMemoryLogRecordExporter implements sdk.LogRecordExporter {
  var _finishedLogRecords = <sdk.ReadableLogRecord>[];

  /// Indicates if the exporter has been "shutdown."
  /// When false, exported log records will not be stored in-memory.
  @protected
  bool _stopped = false;

  @override
  Future<sdk.ExportResult> export(List<sdk.ReadableLogRecord> logs) async {
    if (_stopped) {
      return sdk.ExportResult(
        code: sdk.ExportResultCode.failed,
        error: Exception('Exporter has been stopped'),
        stackTrace: StackTrace.current,
      );
    }
    _finishedLogRecords.addAll(logs);

    return sdk.ExportResult(code: sdk.ExportResultCode.success);
  }

  @override
  Future<void> shutdown() async {
    _stopped = true;
    reset();
  }

  List<sdk.ReadableLogRecord> get finishedLogRecords => List.unmodifiable(_finishedLogRecords);

  void reset() {
    _finishedLogRecords = <sdk.ReadableLogRecord>[];
  }
}
