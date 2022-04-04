import '../../../../api.dart' as api;
import '../../../../sdk.dart' as sdk;

class AlwaysOnSampler implements api.Sampler {
  @override
  String get description => 'AlwaysOnSampler';

  @override
  api.SamplingResult shouldSample(
      api.Context context,
      api.TraceId traceId,
      String spanName,
      api.SpanKind spanKind,
      bool spanIsRemote,
      List<api.Attribute> spanAttributes,
      List<api.SpanLink> spanLinks) {
    return sdk.SamplingResult(api.Decision.recordAndSample, spanAttributes,
        context.spanContext?.traceState ?? sdk.TraceState.empty());
  }
}
