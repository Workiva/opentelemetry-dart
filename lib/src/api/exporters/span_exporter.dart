import '../../../api.dart' as api;

abstract class SpanExporter {
  void export(List<api.Span> spans);

  void forceFlush();

  void shutdown();
}
