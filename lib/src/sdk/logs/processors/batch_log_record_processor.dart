// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'dart:async';
import 'dart:math';

import 'package:opentelemetry/src/experimental_sdk.dart' as sdk;

class BatchLogRecordProcessor extends sdk.LogRecordProcessor {
  static const OTEL_BLRP_MAX_EXPORT_BATCH_SIZE = 512;
  static const OTEL_BLRP_MAX_QUEUE_SIZE = 2048;
  static const OTEL_BLRP_SCHEDULE_DELAY = 5000;
  static const OTEL_BLRP_EXPORT_TIMEOUT = 30000;

  final int maxExportBatchSize;
  final int scheduledDelayMillis;
  final int exportTimeoutMillis;
  final int maxQueueSize;
  final sdk.LogRecordExporter exporter;

  final _finishedLogRecords = <sdk.LogRecord>[];

  bool _isShutDown = false;
  Timer? _timer;

  BatchLogRecordProcessor({
    required this.exporter,
    this.maxExportBatchSize = OTEL_BLRP_MAX_EXPORT_BATCH_SIZE,
    this.scheduledDelayMillis = OTEL_BLRP_SCHEDULE_DELAY,
    this.exportTimeoutMillis = OTEL_BLRP_EXPORT_TIMEOUT,
    this.maxQueueSize = OTEL_BLRP_MAX_QUEUE_SIZE,
  }) : assert(
          maxQueueSize >= maxExportBatchSize,
          'BatchLogRecordProcessor: maxExportBatchSize must be smaller or equal to maxQueueSize',
        );

  @override
  void onEmit(sdk.LogRecord logRecord) {
    if (_isShutDown) return;
    _addToBuffer(logRecord);
  }

  @override
  Future<void> forceFlush() async {
    if (_isShutDown) return;
    await _flushAll();
  }

  @override
  Future<void> shutdown() async {
    _isShutDown = true;
    await _flushAll();
    await exporter.shutdown();
  }

  void _addToBuffer(sdk.LogRecord logRecord) {
    if (_finishedLogRecords.length >= maxQueueSize) {
      return;
    }
    _finishedLogRecords.add(logRecord);
    _maybeStartTimer();
  }

  Future<void> _flushAll() {
    return Future(() async {
      final promises = <Future<void>>[];
      final batchCount = (_finishedLogRecords.length / maxExportBatchSize).ceil();

      for (var i = 0; i < batchCount; i++) {
        promises.add(_flushOneBatch());
      }

      try {
        await Future.wait(promises);
      } catch (e) {
        rethrow;
      }
    });
  }

  Future<void> _flushOneBatch() async {
    _clearTimer();
    if (_finishedLogRecords.isEmpty) return;
    final result = _finishedLogRecords.sublist(0, min(maxExportBatchSize, _finishedLogRecords.length));
    _finishedLogRecords.removeRange(0, result.length);
    await exporter.export(result);
  }

  void _maybeStartTimer() {
    if (_timer != null) return;
    _timer = Timer(Duration(milliseconds: scheduledDelayMillis), () async {
      await _flushOneBatch();
      _clearTimer();
      _maybeStartTimer();
    });
  }

  void _clearTimer() {
    _timer = null;
  }
}
