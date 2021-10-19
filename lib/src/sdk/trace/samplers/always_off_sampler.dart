import 'package:opentelemetry/src/sdk/trace/trace_state.dart';

import '../../../api/common/attributes.dart';
import '../../../api/context/context.dart';
import '../../../api/trace/sampler.dart' as api;
import '../../../api/trace/sampling_result.dart' as result_api;
import '../../../api/trace/trace_id.dart';
import 'sampling_result.dart';

class AlwaysOffSampler implements api.Sampler {
  @override
  String get description => 'AlwaysOffSampler';

  @override
  result_api.SamplingResult shouldSample(Context context, TraceId traceId,
      String spanName, bool spanIsRemote, Attributes spanAttributes) {
    return SamplingResult(result_api.Decision.drop, spanAttributes,
        context.spanContext?.traceState ?? TraceState.empty());
  }
}
