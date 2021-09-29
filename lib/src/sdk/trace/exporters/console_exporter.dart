import '../../../api/trace/span.dart';

import 'span_exporter.dart';

class ConsoleExporter implements SpanExporter {
  var _isShutdown = false;

  void _printSpans(List<Span> spans) {
    for (var i = 0; i < spans.length; i++) {
      final span = spans[i];
      print({
        'traceId': span.spanContext.traceId
            .map((x) => x.toRadixString(16).padLeft(2, '0'))
            .join(),
        'parentId': span.parentSpanId
            .map((x) => x.toRadixString(16).padLeft(2, '0'))
            .join(),
        'name': span.name,
        'id': span.spanContext.spanId
            .map((x) => x.toRadixString(16).padLeft(2, '0'))
            .join(),
        'timestamp': span.startTime,
        'duration': span.endTime - span.startTime,
        'status': span.status.code
      });
    }
  }

  @override
  void export(List<Span> spans) {
    if (_isShutdown) {
      return;
    }

    _printSpans(spans);
  }

  @override
  void shutdown() {
    _isShutdown = true;
  }
}
