import 'package:opentelemetry/api.dart';

abstract class Counter<T extends num> {
  /// Records a value with a set of attributes.
  ///
  /// [value] The increment amount. MUST be non-negative.
  /// [attributes] A set of attributes to associate with the value.
  /// [context] The explicit context to associate with this measurement.
  void add(T value, {List<Attribute> attributes, Context context});
}
