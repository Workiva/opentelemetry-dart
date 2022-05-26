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

import 'dart:html';
import 'dart:js';

import 'package:fixnum/fixnum.dart';

import '../../../../../sdk.dart' as sdk;

/// BrowserTimeProvider retrieves high-resolution timestamps utilizing the
/// `window.performance` API.
///
/// See [DOMHighResTimeStamp](https://www.w3.org/TR/hr-time/#sec-DOMHighResTimeStamp)
/// for more information.
///
/// Note that this time may be inaccurate if the executing system is suspended
/// for sleep.  See https://github.com/open-telemetry/opentelemetry-js/issues/852
/// for more information.
class WebTimeProvider implements sdk.TimeProvider {
  static final Int64 _timeOrigin = _fromDouble(
      JsObject.fromBrowserObject(window)['performance']['timeOrigin'] ??
          // fallback for browsers that don't support timeOrigin, like Dartium
          window.performance.timing.navigationStart.toDouble());

  /// Derive a time, in nanoseconds, from a floating-point time, in milliseconds.
  static Int64 _fromDouble(double time) =>
      Int64((time * sdk.TimeProvider.nanosecondsPerMillisecond).round());

  /// The current time, in nanoseconds since Unix Epoch.
  ///
  /// Note that this time may be inaccurate if the executing system is suspended
  /// for sleep.  See https://github.com/open-telemetry/opentelemetry-js/issues/852
  /// for more information.
  @override
  Int64 get now =>
      // .now() returns an int in Dartium, requiring .toDouble()
      _timeOrigin + _fromDouble(window.performance.now().toDouble());
}
