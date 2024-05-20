import 'package:opentelemetry/api.dart';


abstract class EventBuilder extends LogRecordBuilder {
  EventBuilder setData(Map<String, dynamic> attributes);
}

