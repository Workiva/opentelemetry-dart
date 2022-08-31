import 'package:opentelemetry/api.dart';

class NoopCounter<t> implements Counter {
  @override
  void add(dynamic value, {List<Attribute> attributes, Context context}) {}
}
