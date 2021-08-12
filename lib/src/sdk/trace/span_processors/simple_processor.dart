import '../../../api/trace/span.dart';
import '../exporters/span_exporter.dart';
import 'span_processor.dart';

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
    _isShutdown = true;
  }
}
