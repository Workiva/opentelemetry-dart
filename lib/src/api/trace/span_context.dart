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
