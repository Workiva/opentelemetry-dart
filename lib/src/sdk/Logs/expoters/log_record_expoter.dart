import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/sdk/Logs/component_registry.dart';
import 'package:opentelemetry/src/api/Logs/readable_log_record.dart';
import 'package:opentelemetry/src/sdk/common/export_result.dart';

abstract class LogRecordExporter {
  export(List<ReadableLogRecord> logRecords);
  void shutdown();
  forceFlush();
}

extension LogRecordExporterExtension on LogRecordExporter {
  export(List<ReadableLogRecord> logRecords) => export(logRecords);
  void shutdown() => shutdown();
  forceFlush() => forceFlush();
}
