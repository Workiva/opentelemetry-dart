// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import '../../../../api.dart' as api;

class SimpleSpanProcessor implements api.SpanProcessor {
  final api.SpanExporter _exporter;
  bool _isShutdown = false;

  SimpleSpanProcessor(this._exporter);

  @override
  void forceFlush() {
    _exporter.forceFlush();
  }

  @override
  void onEnd(api.Span span) {
    if (_isShutdown) {
      return;
    }

    _exporter.export([span]);
  }

  @override
  void onStart(api.Span span, api.Context? parentContext) {}

  @override
  void shutdown() {
    forceFlush();
    _isShutdown = true;
    _exporter.shutdown();
  }
}
