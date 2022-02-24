import '../../../api.dart' as api;

abstract class SpanProcessor {
  void onStart();

  void onEnd(api.Span span);

  void shutdown();

  void forceFlush();
}
