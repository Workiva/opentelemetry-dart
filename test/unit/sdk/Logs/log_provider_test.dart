@TestOn('vm')
import 'package:fixnum/src/int64.dart';
import 'package:mocktail/mocktail.dart';
import 'package:opentelemetry/sdk.dart' as sdk;

import 'package:opentelemetry/src/sdk/time_providers/time_provider.dart';

import 'package:opentelemetry/src/sdk/trace/read_only_span.dart';
import 'package:opentelemetry/src/sdk/trace/span_processors/span_processor.dart';
import 'package:opentelemetry/src/sdk/trace/tracer_provider.dart';
import 'package:opentelemetry/src/sdk/Logs/logger_provider.dart';

import 'package:test/test.dart';

import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';


void main() {


  test('tracerProvider custom span processors', () {
    final mockProcessor1 = MockLogProcessop();
    final mockProcessor2 = MockLogProcessop();
    final logLimit = sdk.LogLimits(maxAttributeCount: 10);

    final provider =
    LoggerTraceProviderBase( logLimit , processors: [mockProcessor1, mockProcessor2]);

    expect(provider.processors, [mockProcessor1, mockProcessor2]);
  });

  test('tracerProvider force flushes all processors', () {
    final mockProcessor1 = MockLogProcessop();
    final mockProcessor2 = MockLogProcessop();
    final logLimit = sdk.LogLimits(maxAttributeCount: 10);

    LoggerTraceProviderBase( logLimit , processors: [mockProcessor1, mockProcessor2])
        .forceFlush();

    verify(mockProcessor1.forceFlush).called(1);
    verify(mockProcessor2.forceFlush).called(1);
  });

  test('tracerProvider shuts down all processors', () {
    final mockProcessor1 = MockLogProcessop();
    final mockProcessor2 = MockLogProcessop();
    final logLimit = sdk.LogLimits(maxAttributeCount: 10);

    LoggerTraceProviderBase( logLimit , processors: [mockProcessor1, mockProcessor2])
        .shutdown();

    verify(mockProcessor1.shutdown).called(1);
    verify(mockProcessor2.shutdown).called(1);
  });
}