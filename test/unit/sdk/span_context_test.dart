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

@TestOn('vm')
import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:test/test.dart';

void main() {
  test('spanContext getters', () {
    final spanId = api.SpanId([4, 5, 6]);
    final traceId = api.TraceId([1, 2, 3]);
    const traceFlags = api.TraceFlags.none;
    final traceState = sdk.TraceState.empty();

    final spanContext =
        sdk.SpanContext(traceId, spanId, traceFlags, traceState);

    expect(spanContext.traceId, same(traceId));
    expect(spanContext.spanId, same(spanId));
    expect(spanContext.traceFlags, same(traceFlags));
    expect(spanContext.traceState, same(traceState));
  });
}
