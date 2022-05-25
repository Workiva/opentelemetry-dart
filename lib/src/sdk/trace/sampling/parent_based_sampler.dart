// Copyright 2021-2022 Workiva Inc.

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at

//     http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import '../../../../api.dart' as api;
import '../../../../sdk.dart' as sdk;

class ParentBasedSampler implements sdk.Sampler {
  final sdk.Sampler _root;
  final sdk.Sampler _remoteParentSampled;
  final sdk.Sampler _remoteParentNotSampled;
  final sdk.Sampler _localParentSampled;
  final sdk.Sampler _localParentNotSampled;

  ParentBasedSampler(this._root,
      {remoteParentSampled,
      remoteParentNotSampled,
      localParentSampled,
      localParentNotSampled})
      : _remoteParentSampled = remoteParentSampled ?? sdk.AlwaysOnSampler(),
        _remoteParentNotSampled =
            remoteParentNotSampled ?? sdk.AlwaysOffSampler(),
        _localParentSampled = localParentSampled ?? sdk.AlwaysOnSampler(),
        _localParentNotSampled =
            localParentNotSampled ?? sdk.AlwaysOffSampler();

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
          ? _remoteParentSampled.shouldSample(
              context, traceId, spanName, spanKind, spanAttributes, spanLinks)
          : _remoteParentNotSampled.shouldSample(
              context, traceId, spanName, spanKind, spanAttributes, spanLinks);
    }

    return (parentSpanContext.traceFlags & api.TraceFlags.sampled) ==
            api.TraceFlags.sampled
        ? _localParentSampled.shouldSample(
            context, traceId, spanName, spanKind, spanAttributes, spanLinks)
        : _localParentNotSampled.shouldSample(
            context, traceId, spanName, spanKind, spanAttributes, spanLinks);
  }
}
