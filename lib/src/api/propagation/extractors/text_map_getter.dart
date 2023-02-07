// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import '../../../../api.dart' as api;

/// Interface that allows a [api.TextMapPropagator] to read propagated fields from a carrier.
abstract class TextMapGetter<C> {
  /// Returns all the keys in the given carrier.
  Iterable<String> keys(C carrier);

  /// Returns the first value of the given propagation [key] or returns null.
  String? get(C carrier, String key);
}
