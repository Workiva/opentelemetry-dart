import 'package:fixnum/fixnum.dart';
import 'time_provider.dart';

/// DateTimeTimeProvider retrieves timestamps using DateTime.
class DateTimeTimeProvider implements TimeProvider {
  @override
  Int64 get now =>
      Int64(DateTime.now().microsecondsSinceEpoch) *
      TimeProvider.nanosecondsPerMicrosecond;
}
