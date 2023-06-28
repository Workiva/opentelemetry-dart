// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:opentelemetry/src/api/metrics/noop/noop_counter.dart';
import 'package:opentelemetry/src/experimental_api.dart';

/// A no-op instance of a [Meter]
class NoopMeter implements Meter {
  @override
  Counter<T> createCounter<T extends num>(String name,
      {String description, String unit}) {
    return NoopCounter<T>();
  }
}
