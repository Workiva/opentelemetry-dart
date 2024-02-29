// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

/// Represents versioning metadata for this library within applications
/// which use multiple implementations of OpenTelemetry.
// See https://github.com/open-telemetry/oteps/blob/main/text/0083-component.md#instrumentationlibrary
@Deprecated('This class will be removed in 0.19.0.')
abstract class InstrumentationLibrary {
  String get name;
  String get version;
}
