// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import '../../../api.dart' as api;
import 'noop_tracer.dart';

class NoopTracerProvider implements api.TracerProvider {
  @override
  void forceFlush() {}

  @override
  api.Tracer getTracer(String name,
      {String version, String schemaUrl, List<api.Attribute> attributes}) {
    return NoopTracer();
  }

  @override
  void shutdown() {}
}
