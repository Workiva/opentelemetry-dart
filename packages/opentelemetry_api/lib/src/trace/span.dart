import 'span_context.dart';
import 'status.dart';

/// A representation of a single operation within a trace.
///
/// Examples of a span might include remote procedure calls or in-process
/// function calls to sub-components. A trace has a single, top-level "root"
/// span that in turn may haze zero or more child Spans, which in turn may have
/// children.
///
/// Spans are created by [Tracer.startSpan].
abstract class Span {
  /// The context associated with this span.
  ///
  /// This context is an immutable, serializable identifier for this span that
  /// can be used to create new child spans and remains usable even after this
  /// span ends.
  SpanContext get context;

  /// Whether this span is active and recording information like events via
  /// [addEvent], attributes via [setAttributes], and so on.
  bool get isRecording;

  /// Adds an event to this span.
  ///
  /// If [attributes] and/or [startTime] are given, they will be set as
  /// attributes to this span.
  ///
  /// Values in [attributes] must be of type [String], [num], [boolean], or a
  /// [List] of these types. Null or improperly typed values will result in
  /// undefined behavior.
  void addEvent(String name, {Map<String, Object> attributes, DateTime startTime});

  /// Marks the end of this span's execution.
  ///
  /// [endTime] will be set as this span's end time. If not provided, the
  /// current time will be used.
  void end({DateTime endTime});

  // void recordException(Object error, {Map<String, Object> attributes, StackTrace stackTrace, DateTime startTime});

  /// Sets an attribute to this span.
  ///
  /// [value] must non-null and of type [String], [num], [boolean], or a [List]
  /// of one of these types. Null or improperly typed values will result in
  /// undefined behavior.
  void setAttribute(String key, Object value);

  /// Sets multiple attributes to this span.
  ///
  /// Values in [attributes] must be of type [String], [num], [boolean], or a
  /// [List] of these types. Null or improperly typed values will result in
  /// undefined behavior.
  void setAllAttributes(Map<String, Object> attributes);

  /// Sets this span's status.
  ///
  /// If used, this will override the default status of [StatusCode.unset] and
  /// will also override the value of previous calls on this Span.
  void setStatus(StatusCode code, {String description});

  /// Updates this span's name.
  ///
  /// Upon this update, any sampling behavior based on span name will depend on
  /// the implementation.
  void updateName(String name) {

  }
}
