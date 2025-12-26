// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:fixnum/fixnum.dart';

import '../../../api.dart';
import '../../experimental_api.dart' show NonRecordingSpan;

/// A [Tracer] class which yields [NonRecordingSpan]s and no-ops for most
/// operations.
class NoopTracer implements Tracer {
  @override
  Span startSpan(String name,
      {Context? context,
      SpanKind? kind,
      List<Attribute>? attributes,
      List<SpanLink>? links,
      Int64? startTime,
      bool newRoot = false}) {
    return NonRecordingSpan(context != null
        ? spanContextFromContext(context)
        : SpanContext.invalid());
  }
}
