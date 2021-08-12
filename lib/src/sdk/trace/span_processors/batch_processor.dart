import 'dart:async';
import 'dart:math';

import '../../../api/trace/span.dart';
import '../exporters/span_exporter.dart';
import 'span_processor.dart';

class BatchSpanProcessor implements SpanProcessor {
  final SpanExporter _exporter;
  bool _isShutdown = false;
  final List<Span> _spanBuffer = [];
  Timer _timer; 

  int _maxExportBatchSize = 512;
  final int _maxQueueSize = 2048;
  int _scheduledDelay = 5000;

  BatchSpanProcessor(this._exporter, {int maxExportBatchSize, int scheduledDelay}) {
    _maxExportBatchSize = maxExportBatchSize;
    _scheduledDelay = scheduledDelay;
  }

  @override
  void forceFlush() {
    if (_isShutdown) {
      return;
    }
    while (_spanBuffer.isNotEmpty) {
      _flushBatch();
    }
  }

  @override
  void onEnd(Span span) {
    if (_isShutdown) {
      return;
    }
    _addToBuffer(span);
  }

  @override
  void onStart() {}

  @override
  void shutdown() {
    _isShutdown = true;
    _clearTimer();
  }

  void _addToBuffer(Span span) {
    if (_spanBuffer.length >= _maxQueueSize) {
      // Buffer is full, drop span.
      return;
    }

    _spanBuffer.add(span);
    _startTimer();
  }

  void _startTimer() {
    if (_timer != null) {
      // _timer already defined.
      return;
    }

    _timer = Timer(Duration(milliseconds: _scheduledDelay), () {
      _flushBatch();
      if (_spanBuffer.isNotEmpty) {
        _clearTimer();
        _startTimer();
      }
    });
  }

  void _clearTimer() {
    if (_timer == null) {
      // _timer not set.
      return;
    }

    _timer.cancel();
    _timer = null;
  }

  void _flushBatch() {
    _clearTimer();
    if (_spanBuffer.isEmpty) {
      return;
    }

    final batchSize = min(_spanBuffer.length, _maxExportBatchSize);
    final batch = _spanBuffer.sublist(0, batchSize);
    _spanBuffer.removeRange(0, batchSize);

    _exporter.export(batch);
  }
}
