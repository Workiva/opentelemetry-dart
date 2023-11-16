// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:fixnum/fixnum.dart';

import '../../../api.dart' as api;

enum SpanKind {
  /// Server-side handling of a synchronous RPC or other remote request.
  server,

  /// A request to a remote service.
  client,

  /// An initiator of an asynchronous request.
  producer,

  /// A handler of an asynchronous producer request.
  consumer,

  /// An internal operation within an application, as opposed to an operation with remote parents or children.
  internal
}

/// A representation of a single operation within a trace.
///
/// Examples of a span might include remote procedure calls or in-process
/// function calls to sub-components. A trace has a single, top-level "root"
/// span that in turn may haze zero or more child Spans, which in turn may have
/// children.
///
/// Warning: methods may be added to this interface in minor releases.
abstract class Span {
  /// The context associated with this span.
  ///
  /// This context is an immutable, serializable identifier for this span that
  /// can be used to create new child spans and remains usable even after this
  /// span ends.
  api.SpanContext get spanContext;

  /// The parent span id.
  api.SpanId get parentSpanId;

  /// Sets the name of the [Span].
  void setName(String name);

  /// Sets the status to the [Span].
  ///
  /// If used, this will override the default [Span] status. Default status code
  /// is [api.StatusCode.unset].
  ///
  /// Only the value of the last call will be recorded, and implementations are
  /// free to ignore previous calls.
  void setStatus(api.StatusCode status, [String description]);

  /// set single attribute
  void setAttribute(api.Attribute attribute);

  /// set multiple attributes
  void setAttributes(List<api.Attribute> attributes);

  /// Record metadata about an event occurring during this span.
  void addEvent(String name,
      {Int64? timestamp, List<api.Attribute> attributes});

  /// Marks the end of this span's execution.
  void end();

  /// Record metadata about an exception occurring during this span.
  void recordException(dynamic exception, {StackTrace stackTrace});
}
