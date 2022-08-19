import 'package:opentelemetry/api.dart';

abstract class IntCounter {
  /////
  // Records a value with a set of attributes.
  //
  // @param value The increment amount. MUST be non-negative.
  // @param attributes A set of attributes to associate with the value.
  // @param context The explicit context to associate with this measurement.
  ///
  void add(int value, {List<Attribute> attributes, Context context});
}
