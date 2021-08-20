import 'tracer.dart';

/// A registry for creating named [Tracer]s.
abstract class TracerProvider {
  /// Returns a Tracer, creating one if one with the given [name] and [version]
  /// is not already created.
  ///
  /// [name] should be the name of the tracer or instrumentation library.
  /// [version] should be the version of the tracer or instrumentation library.
  Tracer getTracer(String name, {String version});

  /// Flush all registered span processors.
  void forceFlush();

  /// Stop all registered span processors.
  void shutdown();
}
