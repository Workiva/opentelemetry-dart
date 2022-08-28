@TestOn('vm')
// import 'package:opentelemetry/api.dart' as api;

import 'package:logging/logging.dart';
import 'package:opentelemetry/sdk.dart' as sdk;

//Libraries that produce telemetry data should only depend on opentelemetry-api,
//and defer the choice of the SDK to the application developer. Applications may
//depend on opentelemetry-sdk or another package that implements the API.

/*
[https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/metrics/api.md#meterprovider]
This API MUST accept the following parameters:

name (required): This name SHOULD uniquely identify the instrumentation scope, 
such as the instrumentation library (e.g. io.opentelemetry.contrib.mongodb), 
package, module or class name. If an application or library has built-in 
OpenTelemetry instrumentation, both Instrumented library and Instrumentation 
library may refer to the same library. In that scenario, the name denotes a 
module name or component name within that library or application. In case an 
invalid name (null or empty string) is specified, a working Meter implementation 
MUST be returned as a fallback rather than returning null or throwing an 
exception, its name property SHOULD keep the original invalid value, and a 
message reporting that the specified value is invalid SHOULD be logged. A 
library, implementing the OpenTelemetry API may also ignore this name and return 
a default instance for all calls, if it does not support "named" functionality 
(e.g. an implementation which is not even observability-related). A 
MeterProvider could also return a no-op Meter here if application owners 
configure the SDK to suppress telemetry produced by this library.

version (optional): Specifies the version of the instrumentation scope if the scope has a version (e.g. a library version). Example value: 1.0.0.

[since 1.4.0] schema_url (optional): Specifies the Schema URL that should be recorded in the emitted telemetry.

[since 1.13.0] attributes (optional): Specifies the instrumentation scope attributes to associate with emitted telemetry.
Meters are identified by all of these parameters.

Implementations MUST return different Meter instances when called repeatedly with different values of parameters. Note that always returning a new Meter instance is a valid implementation. The only exception to this rule is the no-op Meter: implementations MAY return the same instance regardless of parameter values.

It is unspecified whether or under which conditions the same or different Meter instances are returned from this function when the same (name,version,schema_url,attributes) parameters are used.

The term identical applied to Meters describes instances where all identifying fields are equal. The term distinct applied to Meters describes instances where at least one identifying field has a different value.

Implementations MUST NOT require users to repeatedly obtain a Meter with the same identity to pick up configuration changes. This can be achieved either by allowing to work with an outdated configuration or by ensuring that new configuration applies also to previously returned Meters.

Note: This could, for example, be implemented by storing any mutable configuration in the MeterProvider and having Meter implementation objects have a reference to the MeterProvider from which they were obtained. If configuration must be stored per-meter (such as disabling a certain meter), the meter could, for example, do a look-up with its identity in a map in the MeterProvider, or the MeterProvider could maintain a registry of all returned Meters and actively update their configuration if it changes.

The effect of associating a Schema URL with a Meter MUST be that the telemetry emitted using the Meter will be associated with the Schema URL, provided that the emitted data format is capable of representing such association.*/

//Note: Meter SHOULD NOT be responsible for the configuration. This should be the responsibility of the MeterProvider instead.

import 'package:test/test.dart';

class _LogRecordMatcher extends TypeMatcher<LogRecord> {
  final Matcher _level;
  final Matcher _message;

  factory _LogRecordMatcher(dynamic levelOr, dynamic messageOr) =>
      _LogRecordMatcher._(levelOr is Matcher ? levelOr : equals(levelOr),
          messageOr is Matcher ? messageOr : equals(messageOr));

  _LogRecordMatcher._(this._level, this._message);

  @override
  Description describe(Description description) {
    description.add('level: ');
    _level.describe(description);
    description.add(', message: ');
    _message.describe(description);
    return description;
  }

  @override
  Description describeMismatch(covariant LogRecord item,
      Description description, Map<dynamic, dynamic> matchState, bool __) {
    if (!_level.matches(item.level, matchState)) {
      _level.describeMismatch(item.level, description, matchState, false);
    }
    if (!_message.matches(item.message, matchState)) {
      _message.describeMismatch(item.message, description, matchState, false);
    }
    return description;
  }

  @override
  bool matches(dynamic item, Map<dynamic, dynamic> matchState) =>
      item is LogRecord &&
      _level.matches(item.level, matchState) &&
      _message.matches(item.message, matchState);
}

void main() {
  /// Matches [LogRecord] of [Level.SEVERE] where message is [messageOrMatcher].
  TypeMatcher<LogRecord> severeLogOf(dynamic messageOrMatcher) =>
      _LogRecordMatcher(Level.SEVERE, messageOrMatcher);

  group('MeterProvider:', () {
    setUp(() {
      Logger.root.level = Level.ALL; // defaults to Level.INFO
      Logger.root.onRecord.listen((record) {
        print('${record.level.name}: ${record.time}: ${record.message}');
      });
    });

    test(
        'failing to provide a name when getting a meter results in a functional'
        'meter and logs a message', () {
      Logger.root.onRecord.listen(expectAsync1((record) {
        expect(record.stackTrace, isNotNull);
        expect(record.message, equals('Invalid Meter Name'));
        expect(record.level, equals(Level.SEVERE));
      }));

      final meter = sdk.MeterProvider().get(null)..createCounter('test', null);
      expect(meter, isNotNull);
    });

    test('getting a meter by same name will return the same instance', () {
      const meterName = 'meterA';
      final meterProvider = sdk.MeterProvider();
      final meterA = meterProvider.get(meterName);
      final meterB = meterProvider.get(meterName);

      expect(identical(meterA, meterB), true);
    });

    test('getting by name and version will return the same meter', () {
      const meterName = 'meterA';
      const version = 'v2';
      final meterProvider = sdk.MeterProvider();
      final meterA =
          meterProvider.get(meterName, instrumentationVersion: version);
      final meterB =
          meterProvider.get(meterName, instrumentationVersion: version);

      expect(identical(meterA, meterB), true);
    });

    test(
        'getting by same name, version and schema_url will return the same meter',
        () {
      const meterName = 'meterA';
      const version = 'v2';
      const url = 'http:schemas.com';
      final meterProvider = sdk.MeterProvider();
      final meterA = meterProvider.get(meterName,
          instrumentationVersion: version, schemaUrl: url);
      final meterB = meterProvider.get(meterName,
          instrumentationVersion: version, schemaUrl: url);

      expect(identical(meterA, meterB), true);
    });

    test(
        'getting by same name, version, schema_url and attributes will return the same meter',
        () {
      const meterName = 'meterA';
      const version = 'v2';
      const url = 'http:schemas.com';
      const attributes = {'keyA': 'valueA', 'KeyB': 'valueB'};
      final meterProvider = sdk.MeterProvider();
      final meterA = meterProvider.get(meterName,
          instrumentationVersion: version,
          schemaUrl: url,
          attributes: attributes);
      final meterB = meterProvider.get(meterName,
          instrumentationVersion: version,
          schemaUrl: url,
          attributes: attributes);

      expect(identical(meterA, meterB), true);
    });

    // todo: imlpement test that verifies that changes to attributes apply to
    // previously created meters
    // https://github.com/Workiva/opentelemetry-dart/issues/74
    // test('changes to attributes apply to previously created meters', () {
    // });
  });
}
