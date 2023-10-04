// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import '../../../api.dart' as api;

abstract class SpanExporter {
  void export(List<api.Span> spans);

  void forceFlush();

  void shutdown();
}
