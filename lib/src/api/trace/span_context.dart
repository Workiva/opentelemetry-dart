// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import '../../../api.dart' as api;

/// Representation of the context of an individual span.
class SpanContext {
  final api.TraceId traceId;
  final api.SpanId spanId;
  final int traceFlags;
  final api.TraceState traceState;
  final bool isRemote;

  bool get isValid => spanId.isValid && traceId.isValid;

  /// Construct a [SpanContext].
  SpanContext(this.traceId, this.spanId, this.traceFlags, this.traceState)
      : isRemote = false;

  /// Construct a [SpanContext] representing an operation which originated from
  /// a remote source.
  SpanContext.remote(
      this.traceId, this.spanId, this.traceFlags, this.traceState)
      : isRemote = true;

  /// Construct an invalid [SpanContext].
  SpanContext.invalid()
      : spanId = api.SpanId.invalid(),
        traceId = api.TraceId.invalid(),
        traceFlags = api.TraceFlags.none,
        traceState = api.TraceState.empty(),
        isRemote = false;
}
