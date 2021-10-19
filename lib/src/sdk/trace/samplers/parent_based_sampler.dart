import '../../../../sdk.dart';
import '../../../api/common/attributes.dart' as api;
import '../../../api/context/context.dart';
import '../../../api/trace/sampler.dart';
import '../../../api/trace/sampling_result.dart';
import '../../../api/trace/trace_id.dart';

class ParentBasedSampler implements Sampler {
  final Sampler _root;
  final Sampler _remoteParentSampled;
  final Sampler _remoteParentNotSampled;
  final Sampler _localParentSampled;
  final Sampler _localParentNotSampled;

  ParentBasedSampler(this._root,
      {remoteParentSampled,
      remoteParentNotSampled,
      localParentSampled,
      localParentNotSampled})
      : _remoteParentSampled = remoteParentSampled ?? AlwaysOnSampler(),
        _remoteParentNotSampled = remoteParentNotSampled ?? AlwaysOffSampler(),
        _localParentSampled = localParentSampled ?? AlwaysOnSampler(),
        _localParentNotSampled = localParentNotSampled ?? AlwaysOffSampler();

  @override
  String get description => 'ParentBasedSampler{root=${_root.description}}';

  @override
  SamplingResult shouldSample(Context context, TraceId traceId, String spanName,
      bool spanIsRemote, api.Attributes spanAttributes) {
    final parentSpanContext = context.spanContext;

    if (parentSpanContext == null || !parentSpanContext.isValid) {
      return _root.shouldSample(
          context, traceId, spanName, spanIsRemote, spanAttributes);
    }

    if (parentSpanContext.isRemote) {
      return (parentSpanContext.traceFlags.sampled)
          ? _remoteParentSampled.shouldSample(
              context, traceId, spanName, spanIsRemote, spanAttributes)
          : _remoteParentNotSampled.shouldSample(
              context, traceId, spanName, spanIsRemote, spanAttributes);
    }

    return (parentSpanContext.traceFlags.sampled)
        ? _localParentSampled.shouldSample(
            context, traceId, spanName, spanIsRemote, spanAttributes)
        : _localParentNotSampled.shouldSample(
            context, traceId, spanName, spanIsRemote, spanAttributes);
  }
}
