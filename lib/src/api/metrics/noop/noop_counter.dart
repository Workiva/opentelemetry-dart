import 'package:opentelemetry/api.dart';

/// A no-op instance of a [Counter]
class NoopCounter implements Counter<int> {
  @override
  void add(dynamic value, {List<Attribute> attributes, Context context}) {}
}
