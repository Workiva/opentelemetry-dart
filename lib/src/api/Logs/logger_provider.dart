import 'package:opentelemetry/api.dart';



abstract class LoggerProvider {
  LogTracer getLogger(String name,
      String version, String schemaUrl, List<Attribute> attributes);
  /// Flush all registered span processors.
  void forceFlush();

  /// Stop all registered span processors.
  void shutdown();
}




