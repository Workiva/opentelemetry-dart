// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import '../../api.dart' as api;

// Represents the instrumentation library.
class InstrumentationLibrary implements api.InstrumentationLibrary {
  final String _name;
  final String? _version;

  InstrumentationLibrary(this._name, this._version);

  @override
  String get name => _name;

  @override
  String? get version => _version;
}
