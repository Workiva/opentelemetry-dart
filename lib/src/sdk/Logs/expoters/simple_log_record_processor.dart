import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/sdk/Logs/component_registry.dart';
import 'package:opentelemetry/src/api/Logs/readable_log_record.dart';
import 'package:opentelemetry/src/sdk/common/export_result.dart';
import 'package:opentelemetry/src/sdk/Logs/expoters/log_record_expoter.dart';
import 'package:opentelemetry/src/sdk/Logs/expoters/log_record_processor.dart';

class SimpleLogRecordProcessor implements LogRecordProcessor {
  LogRecordExporter logRecordExporter;
  bool _isShutdown = false;


  SimpleLogRecordProcessor({required this.logRecordExporter});

  @override
  void onEmit(ReadableLogRecord logRecord) {
    if (_isShutdown) {
      return;
    }
    logRecordExporter.export([logRecord]);
  }

  @override
  void forceFlush() {
    logRecordExporter.forceFlush();
  }

  @override
  void shutdown() {
    forceFlush();
    logRecordExporter.shutdown();
    _isShutdown = true;
  }
}
