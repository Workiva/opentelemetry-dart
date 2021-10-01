import '../context/context.dart';
import '../instrumentation_library.dart';
import 'sampling_result.dart';
import 'span.dart';

/// Represents an entity which determines whether a [Span] should be sampled
/// and sent for collection.
abstract class Sampler {
  SamplingResult shouldSample(
      Context context, Span span, InstrumentationLibrary library);

  String get decision;
}
