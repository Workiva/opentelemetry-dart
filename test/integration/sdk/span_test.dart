import 'package:mockito/mockito.dart';
import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:test/test.dart';

import '../../unit/mocks.dart';

void main() {
  test('span set and end time', () {
    final mockProcessor1 = MockSpanProcessor();
    final mockProcessor2 = MockSpanProcessor();
    final parentSpanId = api.SpanId([4, 5, 6]);
    final span = sdk.Span(
        'foo',
        sdk.SpanContext(api.TraceId([1, 2, 3]), api.SpanId([7, 8, 9]),
            api.TraceFlags.none, sdk.TraceState.empty()),
        parentSpanId,
        [mockProcessor1, mockProcessor2],
        sdk.Resource(api.Attributes.empty()),
        sdk.InstrumentationLibrary('library_name', 'library_version'));

    expect(span.startTime, isNotNull);
    expect(span.endTime, isNull);
    expect(span.parentSpanId, same(parentSpanId));
    expect(span.name, 'foo');

    verify(mockProcessor1.onStart()).called(1);
    verify(mockProcessor2.onStart()).called(1);
    verifyNever(mockProcessor1.onEnd(span));
    verifyNever(mockProcessor2.onEnd(span));

    span.end();
    expect(span.startTime, isNotNull);
    expect(span.endTime, isNotNull);
    expect(span.endTime, greaterThan(span.startTime));

    verify(mockProcessor1.onEnd(span)).called(1);
    verify(mockProcessor2.onEnd(span)).called(1);
  });

  test('span status', () {
    final span = sdk.Span(
        'foo',
        sdk.SpanContext(api.TraceId([1, 2, 3]), api.SpanId([7, 8, 9]),
            api.TraceFlags.none, sdk.TraceState.empty()),
        api.SpanId([4, 5, 6]),
        [],
        sdk.Resource(api.Attributes.empty()),
        sdk.InstrumentationLibrary('library_name', 'library_version'));

    // Verify span status' defaults.
    expect(span.status.code, equals(api.StatusCode.unset));
    expect(span.status.description, equals(null));

    // Verify that span status can be set to "Error".
    span.setStatus(api.StatusCode.error, description: 'Something s\'ploded.');
    expect(span.status.code, equals(api.StatusCode.error));
    expect(span.status.description, equals('Something s\'ploded.'));

    // Verify that multiple errors update the span to the most recently set.
    span.setStatus(api.StatusCode.error,
        description: 'Another error happened.');
    expect(span.status.code, equals(api.StatusCode.error));
    expect(span.status.description, equals('Another error happened.'));

    // Verify that span status cannot be set to "Unset" and that description
    // is ignored for statuses other than "Error".
    span.setStatus(api.StatusCode.unset,
        description: 'Oops.  Can we turn this back off?');
    expect(span.status.code, equals(api.StatusCode.error));
    expect(span.status.description, equals('Another error happened.'));

    // Verify that span status can be set to "Ok" and that description is
    // ignored for statuses other than "Error".
    span.setStatus(api.StatusCode.ok, description: 'All done here.');
    expect(span.status.code, equals(api.StatusCode.ok));
    expect(span.status.description, equals('Another error happened.'));

    // Verify that span status cannot be changed once set to "Ok".
    span.setStatus(api.StatusCode.error,
        description: 'Something else went wrong.');
    expect(span.status.code, equals(api.StatusCode.ok));
    expect(span.status.description, equals('Another error happened.'));
  });

  test('span add and retrieve attributes', () {
    final attributeList = [
      api.Attribute.fromString('First', 'First Attribute'),
      api.Attribute.fromBoolean('Second', false),
      api.Attribute.fromDouble('Third', 3.14),
      api.Attribute.fromInt('Fourth', 4),
      api.Attribute.fromStringList('Fifth', ['String', 'List']),
      api.Attribute.fromBooleanList('Sixth', [true, false]),
      api.Attribute.fromDoubleList('Seventh', [7.1, 7.2]),
      api.Attribute.fromIntList('Eighth', [8, 8]),
    ];
    final expectedAttributeMap = {
      'First': 'First Attribute',
      'Second': false,
      'Third': 3.14,
      'Fourth': 4,
      'Fifth': ['String', 'List'],
      'Sixth': [true, false],
      'Seventh': [7.1, 7.2],
      'Eighth': [8, 8],
    };
    final span = sdk.Span(
        'foo',
        sdk.SpanContext(api.TraceId([1, 2, 3]), api.SpanId([7, 8, 9]),
            api.TraceFlags.none, sdk.TraceState.empty()),
        api.SpanId([4, 5, 6]),
        [],
        sdk.Resource(api.Attributes.empty()),
        sdk.InstrumentationLibrary('library_name', 'library_version'));

    expect(span.attributes.keys.length, isZero);

    span.attributes.add(attributeList.removeAt(0));
    span.attributes.addAll(attributeList);

    span.end();

    expectedAttributeMap.forEach((key, value) {
      expect(span.attributes.get(key).runtimeType, equals(value.runtimeType));
      expect(span.attributes.get(key), equals(value));
    });
  });
}
