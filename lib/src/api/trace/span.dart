import 'package:opentelemetry/src/api/trace/span_status.dart';

import 'span_context.dart';

/// A representation of a single operation within a trace.
///
/// Examples of a span might include remote procedure calls or in-process
/// function calls to sub-components. A trace has a single, top-level "root"
/// span that in turn may haze zero or more child Spans, which in turn may have
/// children.
abstract class Span {
  /// The context associated with this span.
  ///
  /// This context is an immutable, serializable identifier for this span that
  /// can be used to create new child spans and remains usable even after this
  /// span ends.
  SpanContext get spanContext;

  /// Get the time when the span was closed, or null if still open.
  int get endTime;

  /// Get the time when the span was started.
  int get startTime;

  /// The parent span id.
  String get parentSpanId;

  /// The name of the span.
  String get name;

  /// Sets the status to the [Span].
  ///
  /// If used, this will override the default [Span] status. Default status code
  /// is [StatusCode.UNSET].
  ///
  /// Only the value of the last call will be recorded, and implementations are
  /// free to ignore previous calls.
  void setStatus(StatusCode status, {String description});

  /// Retrieve the status of the [Span].
  SpanStatus get status;
  
  /// Marks the end of this span's execution.
  void end();
}
