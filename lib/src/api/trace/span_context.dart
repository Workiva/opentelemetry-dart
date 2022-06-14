// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import '../../../api.dart' as api;

/// Representation of the context of an individual span.
abstract class SpanContext {
  /// Get the ID of the span.
  api.SpanId get spanId;

  /// Get the ID of the trace the span is a part of.
  api.TraceId get traceId;

  /// Get W3C trace context flags used in propagation represented by a one byte bitmap.
  int get traceFlags;

  /// Get the state of the entire trace.
  api.TraceState get traceState;

  bool get isValid;

  /// Whether this SpanContext represents an operation which originated
  /// from a remote source.
  bool get isRemote;
}
