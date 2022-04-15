import '../../../../api.dart' as api;
import '../../../../sdk.dart' as sdk;

class AlwaysOffSampler implements api.Sampler {
  @override
  String get description => 'AlwaysOffSampler';

  @override
  api.SamplingResult shouldSample(
      api.Context context,
      api.TraceId traceId,
      String spanName,
      api.SpanKind spanKind,
      bool spanIsRemote,
      List<api.Attribute> spanAttributes,
      List<api.SpanLink> links) {
    return sdk.SamplingResult(api.Decision.drop, spanAttributes,
        context.spanContext?.traceState ?? sdk.TraceState.empty());
  }
}
