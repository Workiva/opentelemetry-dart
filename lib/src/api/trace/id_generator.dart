// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

/// Generator capable of creating OTel compliant IDs.
abstract class IdGenerator {
  /// Generate an ID for a Span.
  List<int> generateSpanId();

  /// Generate an ID for a trace.
  List<int> generateTraceId();
}
