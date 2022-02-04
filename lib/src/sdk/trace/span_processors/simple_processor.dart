import '../../../../api.dart' as api;

class SimpleSpanProcessor implements api.SpanProcessor {
  final api.SpanExporter _exporter;
  bool _isShutdown = false;

  SimpleSpanProcessor(this._exporter);

  @override
  void forceFlush() {}

  @override
  void onEnd(api.Span span) {
    if (_isShutdown) {
      return;
    }

    _exporter.export([span]);
  }

  @override
  void onStart() {}

  @override
  void shutdown() {
    forceFlush();
    _isShutdown = true;
    _exporter.shutdown();
  }
}
