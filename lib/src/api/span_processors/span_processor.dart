import '../../../api.dart' as api;

abstract class SpanProcessor {
  void onStart(api.Span span, api.Context context);

  void onEnd(api.Span span);

  void shutdown();

  void forceFlush();
}
