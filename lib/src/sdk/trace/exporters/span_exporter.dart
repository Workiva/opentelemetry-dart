// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import '../read_only_span.dart';

abstract class SpanExporter {
  void export(List<ReadOnlySpan> spans);

  @Deprecated(
      'This method will be removed in 0.19.0. Use [SpanProcessor] instead.')
  void forceFlush();

  void shutdown();
}
