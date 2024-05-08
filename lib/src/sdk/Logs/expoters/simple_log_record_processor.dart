import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/sdk/Logs/component_registry.dart';
import 'package:opentelemetry/src/api/Logs/readable_log_record.dart';
import 'package:opentelemetry/src/sdk/common/export_result.dart';
import 'package:opentelemetry/src/sdk/Logs/expoters/log_record_expoter.dart';
import 'package:opentelemetry/src/sdk/Logs/expoters/log_record_processor.dart';

class SimpleLogRecordProcessor implements LogRecordProcessor {
  LogRecordExporter logRecordExporter;

  SimpleLogRecordProcessor({required this.logRecordExporter});

  @override
  void onEmit(ReadableLogRecord logRecord) {
    logRecordExporter.export([logRecord]);
  }

  @override
  ExportResult forceFlush() {
    return logRecordExporter.forceFlush();
  }

  @override
  ExportResult shutdown() {
    logRecordExporter.shutdown();
    return ExportResult.success;
  }
}
