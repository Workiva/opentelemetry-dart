// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:fixnum/fixnum.dart';

abstract class TimeProvider {
  // The smallest increment that DateTime can report is in microseconds, while
  // OpenTelemetry expects time in nanoseconds.
  static const int nanosecondsPerMicrosecond = 1000;

  // window.performance API reports time in fractional milliseconds, while
  // OpenTelemetry expects time in nanoseconds.
  static const int nanosecondsPerMillisecond = 1000000;

  /// The current time, in nanoseconds since Unix Epoch.
  Int64 get now;
}
