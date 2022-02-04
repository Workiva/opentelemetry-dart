import '../../../api.dart' as api;
import '../../../sdk.dart' as sdk;

/// Representation of the context of the context of an individual span.
class SpanContext implements api.SpanContext {
  final api.SpanId _spanId;
  final api.TraceId _traceId;
  final int _traceFlags;
  final api.TraceState _traceState;
  final bool _isRemote;

  @override
  api.TraceId get traceId => _traceId;

  @override
  api.SpanId get spanId => _spanId;

  @override
  int get traceFlags => _traceFlags;

  @override
  api.TraceState get traceState => _traceState;

  @override
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
      : _spanId = sdk.SpanId.invalid(),
        _traceId = sdk.TraceId.invalid(),
        _traceFlags = api.TraceFlags.none,
        _traceState = sdk.TraceState.empty(),
        _isRemote = false;

  @override
  bool get isRemote => _isRemote;
}
