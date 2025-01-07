// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import '../../../api/context/context.dart';
import '../../../api/trace/trace_flags.dart';
import '../exporters/span_exporter.dart';
import '../read_only_span.dart';
import '../read_write_span.dart';
import 'span_processor.dart';

class SimpleSpanProcessor implements SpanProcessor {
  final SpanExporter _exporter;
  bool _isShutdown = false;

  SimpleSpanProcessor(this._exporter);

  @override
  void forceFlush() {}

  @override
  void onEnd(ReadOnlySpan span) {
    if (_isShutdown) {
      return;
    }

    final isSampled =
        span.spanContext.traceFlags & TraceFlags.sampled == TraceFlags.sampled;
    if (isSampled) {
      _exporter.export([span]);
    }
  }

  @override
  void onStart(ReadWriteSpan span, Context parentContext) {}

  @override
  void shutdown() {
    _isShutdown = true;
    _exporter.shutdown();
  }
}
