import 'package:fixnum/fixnum.dart';
import '../../api/time_providers/time_provider.dart';

/// DateTimeTimeProvider retrieves timestamps using DateTime.
class DateTimeTimeProvider implements TimeProvider {
  @override
  Int64 get now =>
      Int64(DateTime.now().microsecondsSinceEpoch) *
      TimeProvider.nanosecondsPerMicrosecond;
}
