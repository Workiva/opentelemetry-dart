import '../../../api/trace/span.dart';

import 'span_exporter.dart';

class ConsoleExporter implements SpanExporter {
  var _isShutdown = false;

  void _printSpans(List<Span> spans) {
    for (var i = 0; i < spans.length; i++) {
      final span = spans[i];
      print({
        'traceId': span.spanContext.traceId.toString(),
        'parentId': span.parentSpanId?.toString(),
        'name': span.name,
        'id': span.spanContext.spanId.toString(),
        'timestamp': span.startTime,
        'duration': span.endTime - span.startTime,
        'flags': span.spanContext.traceFlags.toString(),
        'state': span.spanContext.traceState.toString(),
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
