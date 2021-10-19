import '../../../api/common/attributes.dart';
import '../../../api/context/context.dart';
import '../../../api/trace/sampler.dart' as api;
import '../../../api/trace/sampling_result.dart' as result_api;
import '../../../api/trace/trace_id.dart';
import '../trace_state.dart';
import 'sampling_result.dart';

class AlwaysOnSampler implements api.Sampler {
  @override
  String get description => 'AlwaysOnSampler';

  @override
  result_api.SamplingResult shouldSample(Context context, TraceId traceId,
      String spanName, bool spanIsRemote, Attributes spanAttributes) {
    return SamplingResult(result_api.Decision.recordAndSample, spanAttributes,
        context.spanContext?.traceState ?? TraceState.empty());
  }
}
