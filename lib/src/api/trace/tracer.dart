import 'dart:async';

import '../../../api.dart' as api;

/// An interface for creating [api.Span]s and propagating context in-process.
///
/// Users may choose to use manual or automatic Context propagation. Because of
/// that, this class offers APIs to facilitate both usages.
abstract class Tracer {
  /// Starts a new [api.Span] without setting it as the current span in this
  /// tracer's context.
  api.Span startSpan(String name,
      {api.Context context,
      api.Attributes attributes,
      List<api.Attribute> attribute_list});

  /// Records a span of the given [name] for the given function
  /// and marks the span as errored if an exception occurs.
  FutureOr<R> trace<R>(String name, FutureOr<R> Function() fn,
      {api.Context context});
}
