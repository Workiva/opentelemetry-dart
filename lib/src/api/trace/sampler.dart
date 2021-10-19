import '../common/attributes.dart';
import '../context/context.dart';
import 'sampling_result.dart';
import 'span.dart';
import 'trace_id.dart';

/// Represents an entity which determines whether a [Span] should be sampled
/// and sent for collection.
abstract class Sampler {
  SamplingResult shouldSample(
      Context context,
      TraceId traceId,
      String spanName,
      bool spanIsRemote, // ignore: avoid_positional_boolean_parameters
      Attributes spanAttributes);

  String get description;
}
