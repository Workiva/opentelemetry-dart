import '../../../api/exporters/span_exporter.dart';
import '../../../api/span_processors/span_processor.dart';
import '../../../api/trace/span.dart';

class SimpleSpanProcessor implements SpanProcessor {
  final SpanExporter _exporter;
  bool _isShutdown = false;

  SimpleSpanProcessor(this._exporter);

  @override
  void forceFlush() {}

  @override
  void onEnd(Span span) {
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
