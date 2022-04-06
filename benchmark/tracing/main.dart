import 'dart:async';

import 'package:benchmarking/benchmarking.dart';
import 'package:opentelemetry/sdk.dart' as otel_sdk;

void main() async {
  final tracer = otel_sdk.TracerProvider().getTracer('benchmark');

  final result = await asyncBenchmark('Tracing (Zone.fork per span)', () async {
    // Sync trace
    tracer.trace('1[sync]', () => 1);

    // Async trace
    await tracer.trace('2[async]', () async => 2);

    // Two interleaved async traces
    final trace3Completer = Completer();
    tracer.trace('3[async]', () => trace3Completer.future);
    final trace4Completer = Completer();
    tracer.trace('4[async]', () => trace4Completer.future);
    trace4Completer.complete();
    trace3Completer.complete();

    // A tree of async traces with depth=100
    Future<void> recursiveTraceTo(int maxDepth, [int currentDepth]) async {
      currentDepth ??= 0;
      if (currentDepth >= maxDepth) return;
      tracer.trace('depth=$currentDepth',
          () => recursiveTraceTo(maxDepth, currentDepth + 1));
    }

    await recursiveTraceTo(100);
  });
  result.report(units: 104);
}
