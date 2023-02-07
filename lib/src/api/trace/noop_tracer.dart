// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:fixnum/fixnum.dart';

import '../../../api.dart' as api;
import '../../../sdk.dart' as sdk;

/// A [api.Tracer] class which yields [api.NonRecordingSpan]s and no-ops for most
/// operations.
class NoopTracer implements api.Tracer {
  @override
  api.Span startSpan(String name,
      {api.Context? context,
      api.SpanKind? kind,
      List<api.Attribute>? attributes,
      List<api.SpanLink>? links,
      Int64? startTime}) {
    final parentContext = context!.spanContext!;

    return api.NonRecordingSpan(
        (parentContext.isValid) ? parentContext : sdk.SpanContext.invalid());
  }
}
