// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/src/experimental_api.dart' as api;

class Counter<T extends num> implements api.Counter<T> {
  @override
  void add(T value, {List<api.Attribute>? attributes, api.Context? context}) {
    // TODO: implement add https://github.com/Workiva/opentelemetry-dart/issues/75
  }
}
