// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import '../../../../api.dart' as api;
import '../../../../sdk.dart' as sdk;

/// Represents an entity which determines whether a [api.Span] should be sampled
/// and sent for collection.
abstract class Sampler {
  sdk.SamplingResult shouldSample(
      api.Context context,
      api.TraceId traceId,
      String? spanName,
      api.SpanKind? spanKind,
      List<api.Attribute>? spanAttributes,
      List<api.SpanLink>? spanLinks);

  String get description;
}
