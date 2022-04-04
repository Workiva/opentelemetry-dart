import '../../../../api.dart' as api;
import '../../../../sdk.dart' as sdk;

class ParentBasedSampler implements api.Sampler {
  final api.Sampler _root;
  final api.Sampler _remoteParentSampled;
  final api.Sampler _remoteParentNotSampled;
  final api.Sampler _localParentSampled;
  final api.Sampler _localParentNotSampled;

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
  api.SamplingResult shouldSample(
      api.Context context,
      api.TraceId traceId,
      String spanName,
      api.SpanKind spanKind,
      bool spanIsRemote,
      List<api.Attribute> spanAttributes,
      List<api.SpanLink> spanLinks) {
    final parentSpanContext = context.spanContext;

    if (parentSpanContext == null || !parentSpanContext.isValid) {
      return _root.shouldSample(context, traceId, spanName, spanKind,
          spanIsRemote, spanAttributes, spanLinks);
    }

    if (parentSpanContext.isRemote) {
      return ((parentSpanContext.traceFlags & api.TraceFlags.sampled) ==
              api.TraceFlags.sampled)
          ? _remoteParentSampled.shouldSample(context, traceId, spanName,
          spanKind, spanIsRemote, spanAttributes, spanLinks)
          : _remoteParentNotSampled.shouldSample(context, traceId, spanName,
          spanKind, spanIsRemote, spanAttributes, spanLinks);
    }

    return ((parentSpanContext.traceFlags & api.TraceFlags.sampled) ==
        ? _localParentSampled.shouldSample(context, traceId, spanName, spanKind,
        spanIsRemote, spanAttributes, spanLinks)
        : _localParentNotSampled.shouldSample(context, traceId, spanName,
    spanKind, spanIsRemote, spanAttributes, spanLinks);
  }
}
