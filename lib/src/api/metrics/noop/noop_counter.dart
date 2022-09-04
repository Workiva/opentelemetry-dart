import 'package:opentelemetry/api.dart';

/// A no-op instance of a [Counter]
class NoopCounter<t> implements Counter {
  @override
  void add(dynamic value, {List<Attribute> attributes, Context context}) {}
}
