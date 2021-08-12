import '../../../api/trace/span.dart';

abstract class SpanProcessor {
  void onStart();

  void onEnd(Span span);

  void shutdown();

  void forceFlush();
}
