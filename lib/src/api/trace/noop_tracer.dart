// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:fixnum/fixnum.dart';

import '../../../api.dart' as api;
import 'nonrecording_span.dart';

/// A [api.Tracer] class which yields [NonRecordingSpan]s and no-ops for most
/// operations.
class NoopTracer implements api.Tracer {
  @override
  api.Span startSpan(String name,
      {api.Context context,
      api.SpanKind kind,
      List<api.Attribute> attributes,
      List<api.SpanLink> links,
      Int64 startTime}) {
    final parentContext =
        (context.spanContext != null && context.spanContext.isValid)
            ? context.spanContext
            : api.SpanContext.invalid();

    return NonRecordingSpan(parentContext);
  }
}
