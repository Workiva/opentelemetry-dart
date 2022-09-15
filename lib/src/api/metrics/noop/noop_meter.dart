import 'package:opentelemetry/api.dart';
import 'package:opentelemetry/src/api/metrics/noop/noop_counter.dart';

/// A no-op instance of a [Meter]
class NoopMeter implements Meter {
  @override
  Counter<T> createCounter<T extends num>(String name,
      {String description, String units}) {
    return NoopCounter<T>();
  }
}
