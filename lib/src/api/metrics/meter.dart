import 'package:opentelemetry/api.dart';

abstract class Meter {
  //
  // Constructs a Counter instrument.
  //
  // <p>This is used to build both synchronous instruments and asynchronous instruments (i.e.
  // callbacks).
  //
  // @param name the name of the Counter. Instrument names must consist of 63 or fewer characters
  //     including alphanumeric, _, ., -, and start with a letter.
  // @return a builder for configuring a Counter instrument. Defaults to recording long values, but
  //     may be changed.
  // @see <a
  //     href="https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/metrics/api.md#instrument-naming-rule">Instrument
  //     Naming Rule</a>
  IntCounterBuilder counterBuilder(String name);
}
