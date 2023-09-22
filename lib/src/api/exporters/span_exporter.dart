// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:opentelemetry/src/api/trace/readable_span.dart';

abstract class SpanExporter {
  void export(List<ReadableSpan> spans);

  void forceFlush();

  void shutdown();
}
