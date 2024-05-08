import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/sdk/Logs/component_registry.dart';
import 'package:opentelemetry/src/api/Logs/readable_log_record.dart';
import 'package:opentelemetry/src/sdk/common/export_result.dart';

abstract class LogRecordProcessor {

  void onEmit(ReadableLogRecord logRecord);
  ExportResult forceFlush();
  ExportResult shutdown();
}
extension LogRecordProcessorExtension on LogRecordProcessor {
  ExportResult forceFlush() => forceFlush();
  ExportResult shutdown() => shutdown();
}

