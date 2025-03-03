// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:opentelemetry/src/experimental_sdk.dart' as sdk;

/// This is implementation of [sdk.ReadWriteLogRecordExporter] that prints LogRecords to the
/// console. This class can be used for diagnostic purposes.
///
/// NOTE: This [sdk.LogRecordExporter] is intended for diagnostics use only, output rendered to the console may change at any time.
class ConsoleLogRecordExporter implements sdk.LogRecordExporter {
  @override
  Future<sdk.ExportResult> export(List<sdk.ReadableLogRecord> logs) async {
    return _sendLogRecords(logs);
  }

  /// Shutdown the exporter.
  @override
  Future<void> shutdown() async {}

  /// Showing logs  in console
  sdk.ExportResult _sendLogRecords(List<sdk.ReadableLogRecord> logs) {
    for (final log in logs) {
      print(_makeObject(log));
    }
    return sdk.ExportResult(code: sdk.ExportResultCode.success);
  }

  /// converts logRecord info into more readable format
  Map<String, dynamic> _makeObject(sdk.ReadableLogRecord log) {
    final contextInfo = {};
    contextInfo.addAll({
      'traceId': log.spanContext.traceId,
      'spanId': log.spanContext.spanId,
      'traceFlags': log.spanContext.traceFlags,
    });
    return {
      'resource': {
        'attributes': {
          for (final attribute in log.resource.attributes.keys)
            attribute: log.resource.attributes.get(attribute),
        },
      },
      'instrumentationScope': {
        'name': log.instrumentationScope.name,
        'version': log.instrumentationScope.version,
        'schemaUrl': log.instrumentationScope.schemaUrl,
        'attributes': {
          for (final attribute in log.instrumentationScope.attributes) attribute.key: attribute.value,
        }
      },
      'timestamp': log.timeStamp,
      'severityText': log.severityText,
      'severityNumber': log.severityNumber,
      'body': log.body,
      'attributes': {
        for (final attribute in log.attributes.keys) attribute: log.resource.attributes.get(attribute),
      },
      ...contextInfo,
    };
  }
}
