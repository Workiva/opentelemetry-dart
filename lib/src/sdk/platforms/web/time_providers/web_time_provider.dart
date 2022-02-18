import 'dart:html';
import 'dart:js';

import 'package:fixnum/fixnum.dart';

import '../../../../../api.dart' as api;

/// BrowserTimeProvider retrieves high-resolution timestamps utilizing the
/// `window.performance` API.
///
/// See [DOMHighResTimeStamp](https://www.w3.org/TR/hr-time/#sec-DOMHighResTimeStamp)
/// for more information.
///
/// Note that this time may be inaccurate if the executing system is suspended
/// for sleep.  See https://github.com/open-telemetry/opentelemetry-js/issues/852
/// for more information.
class WebTimeProvider implements api.TimeProvider {
  static final Int64 _timeOrigin = _fromDouble(
      JsObject.fromBrowserObject(window)['performance']['timeOrigin'] ??
          // fallback for browsers that don't support timeOrigin, like Dartium
          window.performance.timing.navigationStart.toDouble());

  /// Derive a time, in nanoseconds, from a floating-point time, in milliseconds.
  static Int64 _fromDouble(double time) =>
      Int64((time * api.TimeProvider.nanosecondsPerMillisecond).round());

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
