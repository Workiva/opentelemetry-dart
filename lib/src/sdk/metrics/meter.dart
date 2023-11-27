// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import '../../../sdk.dart' as sdk;
import '../../experimental_sdk.dart' as sdk;
import '../../experimental_api.dart' as api;

class Meter implements api.Meter {
  final sdk.Resource _resource; // ignore: unused_field
  final sdk.InstrumentationScope _instrumentationScope; // ignore: unused_field

  Meter(this._resource, this._instrumentationScope);

  @override
  api.Counter<T> createCounter<T extends num>(String name,
      {String? description, String? unit}) {
    return sdk.Counter<T>();
  }
}
