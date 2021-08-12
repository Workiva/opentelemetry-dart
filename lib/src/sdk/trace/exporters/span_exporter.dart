import '../../../api/trace/span.dart';

abstract class SpanExporter {
  void export(List<Span> spans);

  void shutdown();
}
