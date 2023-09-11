// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import '../../../api.dart' as api;

class NoopTextMapPropagator implements api.TextMapPropagator {
  @override
  api.Context extract(
          api.Context context, dynamic carrier, api.TextMapGetter getter) =>
      context;

  @override
  void inject(api.Context context, dynamic carrier, api.TextMapSetter setter) {}
}
