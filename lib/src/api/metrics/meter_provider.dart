// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:opentelemetry/api.dart';
import 'package:opentelemetry/src/experimental_api.dart';

/// A registry for creating named [Meter]s.
abstract class MeterProvider {
  /// Gets or creates a [Meter] instance.
  ///
  /// The meter is identified by the combination of [name], [version],
  /// [schemaUrl] and [attributes]. The [name] SHOULD uniquely identify the
  /// instrumentation scope, such as the instrumentation library
  /// (e.g. io.opentelemetry.contrib.mongodb), package, module or class name.
  /// The [version] specifies the version of the instrumentation scope if the
  /// scope has a version (e.g. a library version). The [schemaUrl] identifies
  /// the schema this provider adheres to.  The [attributes] specifies
  /// attributes to associate with emitted telemetry.
  Meter? get(String name,
      {String version = '',
      String schemaUrl = '',
      List<Attribute> attributes = const []});
}
