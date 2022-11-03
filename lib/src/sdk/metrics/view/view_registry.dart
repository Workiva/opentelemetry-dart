import 'package:opentelemetry/api.dart';
import 'package:opentelemetry/src/sdk/metrics/instrument_descriptor.dart';
import 'package:opentelemetry/src/sdk/metrics/view/view.dart';

class ViewRegistry {
  final List<View> _registeredViews = [];
  void addView(View view) {
    _registeredViews.add(view);
  }

  //findViews(instrument: InstrumentDescriptor, meter: InstrumentationScope): View[] {
  List<View> findViews(
      InstrumentDescriptor instrument, InstrumentationScope meter) {
    final views = _registeredViews.where((element) => false);
    return views;
  }
}
