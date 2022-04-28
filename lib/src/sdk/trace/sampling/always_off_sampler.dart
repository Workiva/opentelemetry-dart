import '../../../../api.dart' as api;
import '../../../../sdk.dart' as sdk;

class AlwaysOffSampler implements sdk.Sampler {
  @override
  String get description => 'AlwaysOffSampler';

  @override
  sdk.SamplingResult shouldSample(
      api.Context context,
      api.TraceId traceId,
      String spanName,
      api.SpanKind spanKind,
      List<api.Attribute> spanAttributes,
      List<api.SpanLink> links) {
    return sdk.SamplingResult(sdk.Decision.drop, spanAttributes,
        context.spanContext?.traceState ?? sdk.TraceState.empty());
  }
}
