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

import '../../../../api.dart' as api;

class SimpleSpanProcessor implements api.SpanProcessor {
  final api.SpanExporter _exporter;
  bool _isShutdown = false;

  SimpleSpanProcessor(this._exporter);

  @override
  void forceFlush() {
    _exporter.forceFlush();
  }

  @override
  void onEnd(api.Span span) {
    if (_isShutdown) {
      return;
    }

    _exporter.export([span]);
  }

  @override
  void onStart(api.Span span, api.Context parentContext) {}

  @override
  void shutdown() {
    forceFlush();
    _isShutdown = true;
    _exporter.shutdown();
  }
}
