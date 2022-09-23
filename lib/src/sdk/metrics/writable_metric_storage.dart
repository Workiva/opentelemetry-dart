import 'package:opentelemetry/api.dart';

abstract class WritableMetricStorage {
  void record(num value, List<Attribute> attributes, Context context,
      double unixEpochInMS);
}
