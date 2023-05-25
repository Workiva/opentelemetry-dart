// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import '../../../api.dart' as api;

/// Representation of the context of an individual span.
class SpanContext {
  final api.SpanId _spanId;
  final api.TraceId _traceId;
  final int _traceFlags;
  final api.TraceState _traceState;
  final bool _isRemote;

  api.TraceId get traceId => _traceId;

  api.SpanId get spanId => _spanId;

  int get traceFlags => _traceFlags;

  api.TraceState get traceState => _traceState;

  bool get isValid => spanId.isValid && traceId.isValid;

  /// Construct a [SpanContext].
  SpanContext(this._traceId, this._spanId, this._traceFlags, this._traceState)
      : _isRemote = false;

  /// Construct a [SpanContext] representing an operation which originated
  /// from a remote source.
  SpanContext.remote(
      this._traceId, this._spanId, this._traceFlags, this._traceState)
      : _isRemote = true;

  /// Construct an invalid [SpanContext].
  SpanContext.invalid()
      : _spanId = api.SpanId.invalid(),
        _traceId = api.TraceId.invalid(),
        _traceFlags = api.TraceFlags.none,
        _traceState = api.TraceState.empty(),
        _isRemote = false;

  bool get isRemote => _isRemote;
}
