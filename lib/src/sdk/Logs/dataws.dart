// import 'package:opentelemetry/api.dart' as api;
// import 'package:opentelemetry/sdk.dart' as sdk;
// import 'package:opentelemetry/src/sdk/Logs/component_registry.dart';
//
//
// class ReadableLogRecord {
//   sdk.Resource resource;
//   InstrumentationScopeInfo instrumentationScopeInfo;
//   DateTime timestamp;
//   DateTime? observedTimestamp;
//   api.SpanContext? spanContext;
//   api.Severity? severity;
//   AttributeValue? body;
//   Map<String, AttributeValue> attributes;
//
//   ReadableLogRecord({
//     required this.resource,
//     required this.instrumentationScopeInfo,
//     required this.timestamp,
//     this.observedTimestamp,
//     this.spanContext,
//     this.severity,
//     this.body,
//     required this.attributes,
//   });
// }
//
// abstract class LogRecordProcessor {
//   void onEmit(ReadableLogRecord logRecord);
//   ExportResult forceFlush({Duration? explicitTimeout});
//   ExportResult shutdown({Duration? explicitTimeout});
// }
//
// extension LogRecordProcessorExtension on LogRecordProcessor {
//   ExportResult forceFlush() => forceFlush(explicitTimeout: null);
//   ExportResult shutdown() => shutdown(explicitTimeout: null);
// }
//
// abstract class LogRecordExporter {
//   ExportResult export(List<ReadableLogRecord> logRecords, {Duration? explicitTimeout});
//   void shutdown({Duration? explicitTimeout});
//   ExportResult forceFlush({Duration? explicitTimeout});
// }
//
// extension LogRecordExporterExtension on LogRecordExporter {
//   ExportResult export(List<ReadableLogRecord> logRecords) => export(logRecords, explicitTimeout: null);
//   void shutdown() => shutdown(explicitTimeout: null);
//   ExportResult forceFlush() => forceFlush(explicitTimeout: null);
// }
//
// class InMemoryLogRecordExporter implements LogRecordExporter {
//   List<ReadableLogRecord> finishedLogRecords = [];
//   bool isRunning = true;
//
//   List<ReadableLogRecord> getFinishedLogRecords() {
//     return finishedLogRecords;
//   }
//
//   @override
//   ExportResult export(List<ReadableLogRecord> logRecords, {Duration? explicitTimeout}) {
//     if (!isRunning) {
//       return ExportResult.failure;
//     }
//     finishedLogRecords.addAll(logRecords);
//     return ExportResult.success;
//   }
//
//   @override
//   void shutdown({Duration? explicitTimeout}) {
//     finishedLogRecords.clear();
//     isRunning = false;
//   }
//
//   @override
//   ExportResult forceFlush({Duration? explicitTimeout}) {
//     if (!isRunning) {
//       return ExportResult.failure;
//     }
//     return ExportResult.success;
//   }
// }
//
// class MultiLogRecordExporter implements LogRecordExporter {
//   List<LogRecordExporter> logRecordExporters;
//
//   MultiLogRecordExporter({required this.logRecordExporters});
//
//   @override
//   ExportResult export(List<ReadableLogRecord> logRecords, {Duration? explicitTimeout}) {
//     var result = ExportResult.success;
//     logRecordExporters.forEach((exporter) {
//       result.mergeResultCode(exporter.export(logRecords, explicitTimeout: explicitTimeout));
//     });
//     return result;
//   }
//
//   @override
//   void shutdown({Duration? explicitTimeout}) {
//     logRecordExporters.forEach((exporter) {
//       exporter.shutdown(explicitTimeout: explicitTimeout);
//     });
//   }
//
//   @override
//   ExportResult forceFlush({Duration? explicitTimeout}) {
//     var result = ExportResult.success;
//     logRecordExporters.forEach((exporter) {
//       result.mergeResultCode(exporter.forceFlush(explicitTimeout: explicitTimeout));
//     });
//     return result;
//   }
// }
//
// class NoopLogRecordExporter implements LogRecordExporter {
//   static final instance = NoopLogRecordExporter();
//
//   @override
//   ExportResult export(List<ReadableLogRecord> logRecords, {Duration? explicitTimeout}) {
//     return ExportResult.success;
//   }
//
//   @override
//   void shutdown({Duration? explicitTimeout}) {}
//
//   @override
//   ExportResult forceFlush({Duration? explicitTimeout}) {
//     return ExportResult.success;
//   }
// }
//
// class BatchLogRecordProcessor implements LogRecordProcessor {
//   BatchWorker worker;
//
//   BatchLogRecordProcessor({
//     required LogRecordExporter logRecordExporter,
//     Duration scheduleDelay = const Duration(seconds: 5),
//     Duration exportTimeout = const Duration(seconds: 30),
//     int maxQueueSize = 2048,
//     int maxExportBatchSize = 512,
//     void Function(List<ReadableLogRecord>)? willExportCallback,
//   }) : worker = BatchWorker(
//     logRecordExporter: logRecordExporter,
//     scheduleDelay: scheduleDelay,
//     exportTimeout: exportTimeout,
//     maxQueueSize: maxQueueSize,
//     maxExportBatchSize: maxExportBatchSize,
//     willExportCallback: willExportCallback,
//   ) {
//     worker.start();
//   }
//
//   @override
//   void onEmit(ReadableLogRecord logRecord) {
//     worker.emit(logRecord: logRecord);
//   }
//
//   @override
//   ExportResult forceFlush({Duration? explicitTimeout}) {
//     forceFlush(timeout: explicitTimeout);
//     return ExportResult.success;
//   }
//
//   void forceFlush({Duration? timeout}) {
//     worker.forceFlush(explicitTimeout: timeout);
//   }
//
//   @override
//   ExportResult shutdown({Duration? explicitTimeout}) {
//     worker.cancel();
//     worker.shutdown(explicitTimeout: explicitTimeout);
//     return ExportResult.success;
//   }
// }
//
// class BatchWorker extends Thread {
//   LogRecordExporter logRecordExporter;
//   Duration scheduleDelay;
//   int maxQueueSize;
//   int maxExportBatchSize;
//   Duration exportTimeout;
//   void Function(List<ReadableLogRecord>)? willExportCallback;
//   int halfMaxQueueSize;
//   final cond = NSCondition();
//   List<ReadableLogRecord> logRecordList = [];
//   OperationQueue queue;
//
//   BatchWorker({
//     required this.logRecordExporter,
//     required this.scheduleDelay,
//     required this.exportTimeout,
//     required this.maxQueueSize,
//     required this.maxExportBatchSize,
//     required this.willExportCallback,
//   })  : halfMaxQueueSize = maxQueueSize >> 1,
//         queue = OperationQueue()
//           ..name = 'BatchWorker Queue'
//           ..maxConcurrentOperationCount = 1;
//
//   void emit(ReadableLogRecord logRecord) {
//     cond.lock();
//     if (logRecordList.length == maxQueueSize) {
//       // TODO: record a counter for dropped logs
//       cond.unlock();
//       return;
//     }
//
//     // TODO: record a gauge for referenced logs
//     logRecordList.add(logRecord);
//     if (logRecordList.length >= halfMaxQueueSize) {
//       cond.broadcast();
//     }
//     cond.unlock();
//   }
//
//   @override
//   void main() {
//     do {
//       autoreleasepool(() {
//         List<ReadableLogRecord> logRecordsCopy;
//         cond.lock();
//         if (logRecordList.length < maxExportBatchSize) {
//           do {
//             cond.wait(until: DateTime.now().add(scheduleDelay));
//           } while (logRecordList.isEmpty);
//         }
//         logRecordsCopy = List.from(logRecordList);
//         logRecordList.clear();
//         cond.unlock();
//         exportBatch(logRecordList: logRecordsCopy, explicitTimeout: exportTimeout);
//       });
//     } while (true);
//   }
//
//   void forceFlush({Duration? explicitTimeout}) {
//     List<ReadableLogRecord> logRecordsCopy;
//     cond.lock();
//     logRecordsCopy = List.from(logRecordList);
//     logRecordList.clear();
//     cond.unlock();
//
//     exportBatch(logRecordList: logRecordsCopy, explicitTimeout: explicitTimeout);
//   }
//
//   void shutdown({Duration? explicitTimeout}) {
//     final timeout = Duration(
//       milliseconds: explicitTimeout != null ? explicitTimeout.inMilliseconds : double.infinity.toInt(),
//     );
//     forceFlush(explicitTimeout: timeout);
//     logRecordExporter.shutdown(explicitTimeout: timeout);
//   }
//
//   void exportBatch({required List<ReadableLogRecord> logRecordList, Duration? explicitTimeout}) {
//     final exportOperation = BlockOperation(() {
//       exportAction(logRecordList: logRecordList, explicitTimeout: explicitTimeout);
//     });
//     final timeoutTimer = DispatchSource.makeTimerSource(queue: DispatchQueue.global());
//     timeoutTimer.setEventHandler(() => exportOperation.cancel());
//     final maxTimeOut = Duration(
//       milliseconds: explicitTimeout != null ? explicitTimeout.inMilliseconds : double.infinity.toInt(),
//     );
//     timeoutTimer.schedule(deadline: DateTime.now().add(maxTimeOut), leeway: Duration(milliseconds: 1));
//     timeoutTimer.activate();
//     queue.addOperation(exportOperation);
//     queue.waitUntilAllOperationsAreFinished();
//     timeoutTimer.cancel();
//   }
//
//   void exportAction({required List<ReadableLogRecord> logRecordList, Duration? explicitTimeout}) {
//     for (var i = 0; i < logRecordList.length; i += maxExportBatchSize) {
//       final logRecordToExport = logRecordList.sublist(i, i + maxExportBatchSize).toList();
//       willExportCallback?.call(logRecordToExport);
//       logRecordExporter.export(logRecordToExport, explicitTimeout: explicitTimeout);
//     }
//   }
// }
//
// class MultiLogRecordProcessor implements LogRecordProcessor {
//   List<LogRecordProcessor> logRecordProcessors;
//
//   MultiLogRecordProcessor({required this.logRecordProcessors});
//
//   @override
//   ExportResult forceFlush({Duration? explicitTimeout}) {
//     var result = ExportResult.success;
//     logRecordProcessors.forEach((processor) {
//       result.mergeResultCode(processor.forceFlush(explicitTimeout: explicitTimeout));
//     });
//     return result;
//   }
//
//   @override
//   ExportResult shutdown({Duration? explicitTimeout}) {
//     var result = ExportResult.success;
//     logRecordProcessors.forEach((processor) {
//       result.mergeResultCode(processor.shutdown(explicitTimeout: explicitTimeout));
//     });
//     return result;
//   }
//
//   @override
//   void onEmit(ReadableLogRecord logRecord) {
//     logRecordProcessors.forEach((processor) {
//       processor.onEmit(logRecord);
//     });
//   }
// }
//
// class NoopLogRecordProcessor implements LogRecordProcessor {
//   static final noopLogRecordProcessor = NoopLogRecordProcessor();
//
//   @override
//   void onEmit(ReadableLogRecord logRecord) {}
//
//   @override
//   ExportResult forceFlush({Duration? explicitTimeout}) {
//     return ExportResult.success;
//   }
//
//   @override
//   ExportResult shutdown({Duration? explicitTimeout}) {
//     return ExportResult.success;
//   }
// }
//
// class SimpleLogRecordProcessor implements LogRecordProcessor {
//   LogRecordExporter logRecordExporter;
//
//   SimpleLogRecordProcessor({required this.logRecordExporter});
//
//   @override
//   void onEmit(ReadableLogRecord logRecord) {
//     logRecordExporter.export([logRecord], explicitTimeout: null);
//   }
//
//   @override
//   ExportResult forceFlush({Duration? explicitTimeout}) {
//     return logRecordExporter.forceFlush(explicitTimeout: explicitTimeout);
//   }
//
//   @override
//   ExportResult shutdown({Duration? explicitTimeout}) {
//     logRecordExporter.shutdown(explicitTimeout: explicitTimeout);
//     return ExportResult.success;
//   }
// }
//
//
