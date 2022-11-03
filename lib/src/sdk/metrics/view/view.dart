//  import "Predicate.dart" show PatternPredicate ;
//  import "AttributesProcessor.dart" show AttributesProcessor , FilteringAttributesProcessor ;
//  import "InstrumentSelector.dart" show InstrumentSelector ;
//  import "MeterSelector.dart" show MeterSelector ;
//  import "Aggregation.dart" show Aggregation ;
//  import "../InstrumentDescriptor.dart" show InstrumentType ;

import 'package:opentelemetry/src/sdk/metrics/view/attributes_processor.dart';

import '../instrument_descriptor.dart';

bool hasWildcard(String pattern) {
  return pattern.contains('*');
}

/// Can be passed to a MeterProvider to select instruments and alter their metric stream.
class View {
  String name;
  String description;
  //Aggregation aggregation;
  AttributesProcessor attributesProcessor;
  InstrumentSelector instrumentSelector;
  MeterSelector meterSelector;

  /// Create a new [View] instance.
  View(
      {this.name,
      this.description,
      List<String> attributeKeys,
      //this.aggregation=const Aggregation.default,
      InstrumentType instrumentType,
      String instrumentName,
      String meterName,
      String meterVersion,
      String meterSchemaUrl}) {
    // If no criteria is provided, the SDK SHOULD treat it as an error.
    // It is recommended that the SDK implementations fail fast.

    if (instrumentName == null &&
        instrumentType == null &&
        meterName == null &&
        meterVersion == null &&
        meterSchemaUrl == null) {
      throw ArgumentError(
          'Cannot create view with no selector arguments supplied');
    }

    // The SDK SHOULD NOT allow Views with a specified name to be declared with instrument selectors that
    // may select more than one instrument (e.g. wild card instrument name) in the same Meter.
    if (name != null && instrumentName != null || hasWildcard(instrumentName)) {
      throw ArgumentError(
          'Views with a specified name must be declared with an instrument selector that selects at most one instrument per meter.');
    }

    // Create AttributesProcessor if attributeKeys are defined set.
    if (attributeKeys != null) {
      attributesProcessor = FilteringAttributesProcessor(attributeKeys);
    } else {
      attributesProcessor = AttributesProcessor.Noop();
    }

    // this.aggregation = viewOptions.aggregation ?? Aggregation.Default();
    // this.instrumentSelector = new InstrumentSelector({
    //   name: viewOptions.instrumentName,
    //   type: viewOptions.instrumentType,
    // });
    // this.meterSelector = new MeterSelector({
    //   name: viewOptions.meterName,
    //   version: viewOptions.meterVersion,
    //   schemaUrl: viewOptions.meterSchemaUrl
    // });
  }
}

class MeterSelector {}

class InstrumentSelector {}
