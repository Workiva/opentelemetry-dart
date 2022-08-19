import 'package:opentelemetry/api.dart';

//Builder class for {@link IntCounter}.
//
// @since 1.10.0
abstract class IntCounterBuilder {
// Sets the description for this instrument.
//
// @param description The description.
// @see <a
//     href="https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/metrics/api.md#instrument-description">Instrument
//     Description</a>
  void setDescription(String description);

//
// Sets the unit of measure for this instrument.
//
//@param unit The unit. Instrument units must be 63 or fewer ASCII characters.
//@see <a
//     href="https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/metrics/api.md#instrument-unit">Instrument
//     Unit</a>
  void setUnit(String unit);

// Builds and returns a Counter instrument with the configuration.
//
//@return The Counter instrument.
  IntCounter build();
}
