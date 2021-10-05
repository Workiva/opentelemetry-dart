import '../../../api/context/context.dart';
import '../../../api/instrumentation_library.dart';
import '../../../api/trace/sampler.dart' as api;
import '../../../api/trace/sampling_result.dart' as result_api;
import '../../../api/trace/span.dart' as span_api;
import 'sampling_result.dart';

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
