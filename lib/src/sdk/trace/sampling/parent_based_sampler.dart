// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:meta/meta.dart';

import '../../../../api.dart' as api;
import '../../../../sdk.dart' as sdk;

class ParentBasedSampler implements sdk.Sampler {
  final sdk.Sampler _root;

  @protected
  final sdk.Sampler remoteParentSampled;

  @protected
  final sdk.Sampler remoteParentNotSampled;

  @protected
  final sdk.Sampler localParentSampled;

  @protected
  final sdk.Sampler localParentNotSampled;

  const ParentBasedSampler(this._root,
      {this.remoteParentSampled = const sdk.AlwaysOnSampler(),
      this.remoteParentNotSampled = const sdk.AlwaysOffSampler(),
      this.localParentSampled = const sdk.AlwaysOnSampler(),
      this.localParentNotSampled = const sdk.AlwaysOffSampler()});

  @override
  String get description => 'ParentBasedSampler{root=${_root.description}}';

  @override
  sdk.SamplingResult shouldSample(
      api.Context context,
      api.TraceId traceId,
      String spanName,
      api.SpanKind spanKind,
      List<api.Attribute> spanAttributes,
      List<api.SpanLink> spanLinks) {
    final parentSpanContext = context.spanContext;

    if (parentSpanContext == null || !parentSpanContext.isValid) {
      return _root.shouldSample(
          context, traceId, spanName, spanKind, spanAttributes, spanLinks);
    }

    if (parentSpanContext.isRemote) {
      return ((parentSpanContext.traceFlags & api.TraceFlags.sampled) ==
              api.TraceFlags.sampled)
          ? remoteParentSampled.shouldSample(
              context, traceId, spanName, spanKind, spanAttributes, spanLinks)
          : remoteParentNotSampled.shouldSample(
              context, traceId, spanName, spanKind, spanAttributes, spanLinks);
    }

    return (parentSpanContext.traceFlags & api.TraceFlags.sampled) ==
            api.TraceFlags.sampled
        ? localParentSampled.shouldSample(
            context, traceId, spanName, spanKind, spanAttributes, spanLinks)
        : localParentNotSampled.shouldSample(
            context, traceId, spanName, spanKind, spanAttributes, spanLinks);
  }
}
