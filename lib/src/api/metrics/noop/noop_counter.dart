import 'package:opentelemetry/api.dart';
import 'package:opentelemetry/src/experimental_api.dart';

/// A no-op instance of a [Counter]
class NoopCounter<T extends num> extends Counter<T> {
  @override
  void add(T value, {List<Attribute>? attributes, Context? context}) {}
}
