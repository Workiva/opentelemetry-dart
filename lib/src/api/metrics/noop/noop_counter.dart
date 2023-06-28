// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:opentelemetry/api.dart';
import 'package:opentelemetry/src/experimental_api.dart';

/// A no-op instance of a [Counter]
class NoopCounter<T extends num> extends Counter<T> {
  @override
  void add(T value, {List<Attribute> attributes, Context context}) {}
}
