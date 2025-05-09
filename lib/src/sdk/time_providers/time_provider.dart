// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:fixnum/fixnum.dart';

abstract class TimeProvider {
  // The smallest increment that DateTime can report is in microseconds, while
  // OpenTelemetry expects time in nanoseconds.
  @Deprecated('This constant will be removed in 0.19.0 without replacement.')
  static const int nanosecondsPerMicrosecond = 1000;

  // window.performance API reports time in fractional milliseconds, while
  // OpenTelemetry expects time in nanoseconds.
  @Deprecated('This constant will be removed in 0.19.0 without replacement.')
  static const int nanosecondsPerMillisecond = 1000000;

  /// The current time in nanoseconds since Unix Epoch.
  ///
  /// **Warning:** Return type will change to `Duration` in 0.19.0.
  /// Use [nowDuration] instead.
  @Deprecated(
      'Return type will change to `Duration` in 0.19.0. '
          'Use `nowDuration` for now, and migrate back to `now` after 0.19.0.'
  )
  Int64 get now;

  /// The current time as a [Duration] since Unix Epoch.
  ///
  /// **Warning:** Temporary API, will be removed in 0.20.0.
  /// Use this for intermediate migration of `now` prior to 0.19.0.
  Duration get nowDuration;
}
