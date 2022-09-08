import 'package:opentelemetry/api.dart';

/// A no-op instance of a [Counter]
class NoopCounter implements Counter<int> {
  @override
  void add(int value, {List<Attribute> attributes, Context context}) {}
}
