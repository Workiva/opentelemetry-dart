import '../../../../api.dart';
import '../../../api/trace/sampling_result.dart' as api;

class SamplingResult implements api.SamplingResult {
  @override
  final api.Decision decision;
  @override
  final List<Attribute> spanAttributes;
  @override
  final TraceState traceState;

  SamplingResult(this.decision, this.spanAttributes, this.traceState);
}
