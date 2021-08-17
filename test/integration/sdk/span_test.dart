import 'package:opentelemetry/src/api/trace/span_status.dart';
import 'package:opentelemetry/src/sdk/trace/span.dart';
import 'package:opentelemetry/src/sdk/trace/span_context.dart';
import 'package:opentelemetry/src/sdk/trace/trace_state.dart';
import 'package:test/test.dart';

void main() {
  test('span set and end time', () {
    final span =
        Span('foo', SpanContext('trace123', '789', TraceState()), 'span456');

    expect(span.startTime, isA<int>());
    expect(span.endTime, isNull);

    span.end();
    expect(span.startTime, isA<int>());
    expect(span.endTime, isA<int>());
    expect(span.endTime, greaterThan(span.startTime));
  });

  test('span status', () {
    final span =
        Span('foo', SpanContext('trace123', '789', TraceState()), 'span456');

    // Verify span status' defaults.
    expect(span.status.code, equals(StatusCode.UNSET));
    expect(span.status.description, equals(null));

    // Verify that span status can be set to "Error".
    span.setStatus(StatusCode.ERROR, description: 'Something s\'ploded.');
    expect(span.status.code, equals(StatusCode.ERROR));
    expect(span.status.description, equals('Something s\'ploded.'));

    // Verify that multiple errors update the span to the most recently set.
    span.setStatus(StatusCode.ERROR, description: 'Another error happened.');
    expect(span.status.code, equals(StatusCode.ERROR));
    expect(span.status.description, equals('Another error happened.'));

    // Verify that span status cannot be set to "Unset" and that description
    // is ignored for statuses other than "Error".
    span.setStatus(StatusCode.UNSET,
        description: 'Oops.  Can we turn this back off?');
    expect(span.status.code, equals(StatusCode.ERROR));
    expect(span.status.description, equals('Another error happened.'));

    // Verify that span status can be set to "Ok" and that description is
    // ignored for statuses other than "Error".
    span.setStatus(StatusCode.OK, description: 'All done here.');
    expect(span.status.code, equals(StatusCode.OK));
    expect(span.status.description, equals('Another error happened.'));

    // Verify that span status cannot be changed once set to "Ok".
    span.setStatus(StatusCode.ERROR, description: 'Something else went wrong.');
    expect(span.status.code, equals(StatusCode.OK));
    expect(span.status.description, equals('Another error happened.'));
  });
}
