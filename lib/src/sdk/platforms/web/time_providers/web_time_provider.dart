// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'dart:html';

import 'package:fixnum/fixnum.dart';
import 'package:meta/meta.dart';

import '../../../time_providers/time_provider.dart';

Int64 msToNs(num n, {int? fractionDigits}) {
  const nsPerMs = 1000 * 1000;
  final whole = n.truncate();
  if (fractionDigits == null) {
    final frac = ((n - whole) * nsPerMs).round();
    return Int64(whole * nsPerMs + frac);
  }
  final frac = double.parse((n - whole).toStringAsFixed(fractionDigits)) * nsPerMs;
  return Int64(whole) * nsPerMs + Int64(frac.round());
}

/// Time when navigation started or the service worker was started in
/// nanoseconds.
@experimental
final Int64 timeOrigin =
    msToNs(window.performance.timeOrigin ?? window.performance.timing.navigationStart, fractionDigits: 1);

/// Converts a high-resolution timestamp from the browser performance API to an
/// Int64 representing nanoseconds since Unix Epoch.
@experimental
Int64 fromDOMHighResTimeStamp(num ts) {
  return timeOrigin + msToNs(ts);
}

/// BrowserTimeProvider retrieves high-resolution timestamps utilizing the
/// `window.performance` API.
///
/// See [DOMHighResTimeStamp](https://www.w3.org/TR/hr-time/#sec-DOMHighResTimeStamp)
/// for more information.
///
/// Note that this time may be inaccurate if the executing system is suspended
/// for sleep.  See https://github.com/open-telemetry/opentelemetry-js/issues/852
/// for more information.
class WebTimeProvider implements TimeProvider {
  static final Duration timeOrigin = Duration(
    milliseconds: (window.performance.timeOrigin ?? window.performance.timing.navigationStart).round(),
  );

  /// The current time, in nanoseconds since Unix Epoch.
  ///
  /// Note that this time may be inaccurate if the executing system is suspended
  /// for sleep.  See https://github.com/open-telemetry/opentelemetry-js/issues/852
  /// for more information.
  @override
  Int64 get now => fromDOMHighResTimeStamp(window.performance.now());

  @override
  Duration get nowDuration =>
      WebTimeProvider.timeOrigin + Duration(microseconds: (window.performance.now() * 1000).round());
}
