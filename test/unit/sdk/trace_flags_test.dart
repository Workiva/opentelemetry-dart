import 'package:test/test.dart';
import 'package:opentelemetry/src/sdk/trace/trace_flags.dart';
import 'package:opentelemetry/src/api/trace/trace_flags.dart' as api;

void main() {
  test('create empty', () {
    final testTraceFlags = TraceFlags(api.TraceFlags.NONE);

    expect(testTraceFlags.sampled, isFalse);
    expect(testTraceFlags.isValid, isTrue);
  });

  test('create sampled', () {
    final testTraceFlags = TraceFlags(api.TraceFlags.SAMPLED_FLAG);

    expect(testTraceFlags.sampled, isTrue);
    expect(testTraceFlags.isValid, isTrue);
  });

  test('create from string', () {
    final testTraceFlags = TraceFlags.fromString('01');

    expect(testTraceFlags.sampled, isTrue);
    expect(testTraceFlags.isValid, isTrue);
  });

  test('create invalid', () {
    final testTraceFlags = TraceFlags.invalid();

    expect(testTraceFlags.sampled, isFalse);
    expect(testTraceFlags.isValid, isFalse);
  });

  test('set sampled', () {
    final testTraceFlags = TraceFlags(api.TraceFlags.NONE)..sampled = true;

    expect(testTraceFlags.sampled, isTrue);
    expect(testTraceFlags.isValid, isTrue);
  });

  test('unset sampled', () {
    final testTraceFlags = TraceFlags(api.TraceFlags.SAMPLED_FLAG)
      ..sampled = false;

    expect(testTraceFlags.sampled, isFalse);
    expect(testTraceFlags.isValid, isTrue);
  });
}
