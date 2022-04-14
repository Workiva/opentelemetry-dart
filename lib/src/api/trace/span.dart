import 'package:fixnum/fixnum.dart';

import '../../../api.dart' as api;

enum SpanKind { server, client, producer, consumer, internal }

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
  api.SpanContext get spanContext;

  /// Get the time when the span was closed, or null if still open.
  Int64 get endTime;

  /// Get the time when the span was started.
  Int64 get startTime;

  /// The parent span id.
  api.SpanId get parentSpanId;

  /// The name of the span.
  String name;

  /// Whether this Span is recording information like events with the
  /// addEvent operation, status with setStatus, etc.
  bool get isRecording;

  /// The kind of the span.
  SpanKind get kind;

  /// Sets the status to the [Span].
  ///
  /// If used, this will override the default [Span] status. Default status code
  /// is [api.StatusCode.unset].
  ///
  /// Only the value of the last call will be recorded, and implementations are
  /// free to ignore previous calls.
  void setStatus(api.StatusCode status, {String description});

  /// Retrieve the status of the [Span].
  api.SpanStatus get status;

  /// set single attribute
  void setAttribute(api.Attribute attribute);

  /// set multiple attributes
  void setAttributes(List<api.Attribute> attributes);

  /// Retrieve the resource on this span.
  api.Resource get resource;

  /// Retrieve the instrumentation library on this span.
  api.InstrumentationLibrary get instrumentationLibrary;

  /// Record metadata about an event occurring during this span.
  void addEvent(String name, Int64 timestamp, {List<api.Attribute> attributes});

  /// Marks the end of this span's execution.
  void end();

  /// Record metadata about an exception occurring during this span.
  void recordException(dynamic exception, {StackTrace stackTrace});
}
