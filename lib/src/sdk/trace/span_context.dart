// Copyright 2021-2022 Workiva Inc.

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at

//     http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

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
      : _spanId = api.SpanId.invalid(),
        _traceId = api.TraceId.invalid(),
        _traceFlags = api.TraceFlags.none,
        _traceState = sdk.TraceState.empty(),
        _isRemote = false;

  @override
  bool get isRemote => _isRemote;
}
