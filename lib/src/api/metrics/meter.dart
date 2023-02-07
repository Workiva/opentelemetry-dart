import 'package:opentelemetry/src/experimental_api.dart';

abstract class Meter {
  /// Creates a new [Counter] instrument named [name]. Additional details about
  /// this metric can be captured in [description] and units can be specified in
  /// [unit].
  ///
  /// See https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/metrics/api.md#instrument-naming-rule
  Counter<T> createCounter<T extends num>(String name,
      {String? description, String? unit});
}
