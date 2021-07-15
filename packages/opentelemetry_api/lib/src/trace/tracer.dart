import 'package:opentelemetry_context/opentelemetry_context.dart';

import 'span.dart';
import 'span_kind.dart';

/// An interface for creating [Span]s and propagating context in-process.
///
/// Users may choose to use manual or automatic Context propagation. Because of
/// that, this class offers APIs to facilitate both usages.
abstract class Tracer {
  /// Returns the current Span from the current context if available.
  ///
  /// If there is no Span associated with the current context, this returns
  /// `null`.
  ///
  /// To install a [Span] to the current Context, use [Tracer.withSpan].
  // Span getCurrentSpan();

  /// Starts a new [Span] without setting it as the current span in this
  /// tracer's context.
  ///
  /// This method does NOT modify the current Context. To install a [Span] to
  /// the current Context use [Tracer.withSpan].
  Span startSpan(String name, {Context context, SpanKind kind, DateTime startTime});

  /// Calls [fn] within the Context provided by [span].
  ///
  /// This is a convenience method for creating spans attached to the tracer's
  /// context. Applications that need more control over the span lifetime should
  /// use [Tracer.startSpan].
  // T withSpan<T>(Span span, T Function() fn);

  /// Binds the given [context] span to [target], or propagates the current
  /// context if one is not given.
  // T bind<T>(T target, {Span context});
}
