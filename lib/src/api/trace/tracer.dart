import '../../../api.dart' as api;

/// An interface for creating [api.Span]s and propagating context in-process.
///
/// Users may choose to use manual or automatic Context propagation. Because of
/// that, this class offers APIs to facilitate both usages.
abstract class Tracer {
  /// Starts a new [api.Span] without setting it as the current span in this
  /// tracer's context.
  api.Span startSpan(String name,
      {api.Context context, api.Attributes attributes});

  /// Records a span of the given [name] for the given synchronous function
  /// and marks the span as errored if an exception occurs.
  R traceSync<R>(String name, R Function() fn, {api.Context context});

  /// Records a span of the given [name] for the given asynchronous function
  /// and marks the span as errored if an exception occurs.
  Future<R> traceAsync<R>(String name, Future<R> Function() fn,
      {api.Context context});
}
