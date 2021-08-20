import 'package:opentelemetry/src/api/context/context.dart';
import 'package:opentelemetry/src/api/trace/sampler.dart' as api;
import 'package:opentelemetry/src/api/trace/sampling_result.dart' as result_api;
import 'package:opentelemetry/src/api/trace/span.dart' as span_api;
import 'package:opentelemetry/src/sdk/trace/samplers/sampling_result.dart';
import 'package:opentelemetry/src/api/instrumentation_library.dart';

class AlwaysOffSampler implements api.Sampler {
  @override
  String get decision => 'AlwaysOffSampler';

  @override
  result_api.SamplingResult shouldSample(Context context, span_api.Span span,
      InstrumentationLibrary libraryVersion) {
    return SamplingResult(
        Decision.DROP, span.attributes, span.spanContext.traceState);
  }
}
