import '../../../../sdk.dart' as sdk;
import '../../../../api.dart' as api;

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
  api.SamplingResult shouldSample(api.Context context, api.TraceId traceId,
      String spanName, bool spanIsRemote, api.Attributes spanAttributes) {
    final parentSpanContext = context.spanContext;

    if (parentSpanContext == null || !parentSpanContext.isValid) {
      return _root.shouldSample(
          context, traceId, spanName, spanIsRemote, spanAttributes);
    }

    if (parentSpanContext.isRemote) {
      return ((parentSpanContext.traceFlags & api.TraceFlags.sampled) ==
              api.TraceFlags.sampled)
          ? _remoteParentSampled.shouldSample(
              context, traceId, spanName, spanIsRemote, spanAttributes)
          : _remoteParentNotSampled.shouldSample(
              context, traceId, spanName, spanIsRemote, spanAttributes);
    }

    return ((parentSpanContext.traceFlags & api.TraceFlags.sampled) ==
            api.TraceFlags.sampled)
        ? _localParentSampled.shouldSample(
            context, traceId, spanName, spanIsRemote, spanAttributes)
        : _localParentNotSampled.shouldSample(
            context, traceId, spanName, spanIsRemote, spanAttributes);
  }
}
