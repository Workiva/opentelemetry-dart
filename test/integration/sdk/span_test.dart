import 'package:mockito/mockito.dart';
import 'package:opentelemetry/src/api/trace/span_status.dart';
import 'package:opentelemetry/src/api/trace/trace_flags.dart' as api;
import 'package:opentelemetry/src/sdk/common/attribute.dart';
import 'package:opentelemetry/src/sdk/common/attributes.dart';
import 'package:opentelemetry/src/sdk/instrumentation_library.dart';
import 'package:opentelemetry/src/sdk/resource/resource.dart';
import 'package:opentelemetry/src/sdk/trace/span.dart';
import 'package:opentelemetry/src/sdk/trace/span_context.dart';
import 'package:opentelemetry/src/sdk/trace/span_id.dart';
import 'package:opentelemetry/src/sdk/trace/trace_flags.dart';
import 'package:opentelemetry/src/sdk/trace/trace_id.dart';
import 'package:opentelemetry/src/sdk/trace/trace_state.dart';
import 'package:test/test.dart';

import '../../unit/mocks.dart';

void main() {
  test('span set and end time', () {
    final mockProcessor1 = MockSpanProcessor();
    final mockProcessor2 = MockSpanProcessor();
    final parentSpanId = SpanId([4, 5, 6]);
    final span = Span(
        'foo',
        SpanContext(TraceId([1, 2, 3]), SpanId([7, 8, 9]),
            TraceFlags(api.TraceFlags.none), TraceState.empty()),
        parentSpanId,
        [mockProcessor1, mockProcessor2],
        Resource(Attributes.empty()),
        InstrumentationLibrary('library_name', 'library_version'),
        null);

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
    final span = Span(
        'foo',
        SpanContext(TraceId([1, 2, 3]), SpanId([7, 8, 9]),
            TraceFlags(api.TraceFlags.none), TraceState.empty()),
        SpanId([4, 5, 6]),
        [],
        Resource(Attributes.empty()),
        InstrumentationLibrary('library_name', 'library_version'),
        null);

    // Verify span status' defaults.
    expect(span.status.code, equals(StatusCode.unset));
    expect(span.status.description, equals(null));

    // Verify that span status can be set to "Error".
    span.setStatus(StatusCode.error, description: 'Something s\'ploded.');
    expect(span.status.code, equals(StatusCode.error));
    expect(span.status.description, equals('Something s\'ploded.'));

    // Verify that multiple errors update the span to the most recently set.
    span.setStatus(StatusCode.error, description: 'Another error happened.');
    expect(span.status.code, equals(StatusCode.error));
    expect(span.status.description, equals('Another error happened.'));

    // Verify that span status cannot be set to "Unset" and that description
    // is ignored for statuses other than "Error".
    span.setStatus(StatusCode.unset,
        description: 'Oops.  Can we turn this back off?');
    expect(span.status.code, equals(StatusCode.error));
    expect(span.status.description, equals('Another error happened.'));

    // Verify that span status can be set to "Ok" and that description is
    // ignored for statuses other than "Error".
    span.setStatus(StatusCode.ok, description: 'All done here.');
    expect(span.status.code, equals(StatusCode.ok));
    expect(span.status.description, equals('Another error happened.'));

    // Verify that span status cannot be changed once set to "Ok".
    span.setStatus(StatusCode.error, description: 'Something else went wrong.');
    expect(span.status.code, equals(StatusCode.ok));
    expect(span.status.description, equals('Another error happened.'));
  });

  test('span add and retrieve attributes', () {
    final attributeList = [
      Attribute.fromString('First', 'First Attribute'),
      Attribute.fromBoolean('Second', false),
      Attribute.fromDouble('Third', 3.14),
      Attribute.fromInt('Fourth', 4),
      Attribute.fromStringList('Fifth', ['String', 'List']),
      Attribute.fromBooleanList('Sixth', [true, false]),
      Attribute.fromDoubleList('Seventh', [7.1, 7.2]),
      Attribute.fromIntList('Eighth', [8, 8]),
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
    final span = Span(
        'foo',
        SpanContext(TraceId([1, 2, 3]), SpanId([7, 8, 9]),
            TraceFlags(api.TraceFlags.none), TraceState.empty()),
        SpanId([4, 5, 6]),
        [],
        Resource(Attributes.empty()),
        InstrumentationLibrary('library_name', 'library_version'),
        null);

    expect(span.attributes.isEmpty, equals(true));

    span.attributes.add(attributeList.removeAt(0));
    span.attributes.addAll(attributeList);

    span.end();

    expectedAttributeMap.forEach((key, value) {
      expect(span.attributes.get(key).runtimeType, equals(value.runtimeType));
      expect(span.attributes.get(key), equals(value));
    });
  });
}
