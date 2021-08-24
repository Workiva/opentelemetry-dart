import '../../../src/api/context/context.dart';
import 'span.dart';

/// An interface for creating [Span]s and propagating context in-process.
///
/// Users may choose to use manual or automatic Context propagation. Because of
/// that, this class offers APIs to facilitate both usages.
abstract class Tracer {
  /// Starts a new [Span] without setting it as the current span in this
  /// tracer's context.
  Span startSpan(String name, {Context context});

  /// The Tracer's name.
  String get name;
}
