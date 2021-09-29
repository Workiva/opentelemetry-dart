import 'package:opentelemetry/api.dart';
import 'package:opentelemetry/src/api/trace/sampling_result.dart' as api;

enum Decision {
  DROP,
  RECORD_ONLY,
  RECORD_AND_SAMPLE,
}

class SamplingResult implements api.SamplingResult {
  final Decision decision;
  final Attributes spanAttributes;
  final TraceState traceState;

  SamplingResult(this.decision, this.spanAttributes, this.traceState);
}
