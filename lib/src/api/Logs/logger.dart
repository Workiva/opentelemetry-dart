
import 'package:opentelemetry/api.dart';

abstract class Logger {
  LogRecordBuilder logRecordBuilder();
}