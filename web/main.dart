// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

// Browser test bed for the `zone()` context-propagation behaviour.
//
// This file is intentionally written against ONLY the public API that exists
// on both `master` (legacy `ZoneSpecification.run` `zone()`) and PR #234
// (`zoneValues`-based `zone()`):
// https://github.com/Workiva/opentelemetry-dart/pull/234
//
// Pull it down on either branch unchanged and compare:
//
//   * PROPAGATION  - `Context.current` inside `zone(ctx).run(...)` must keep
//     returning `ctx` (its value AND its span) across every async hop
//     (microtask, timer, `Future.whenComplete`). This MUST pass on both
//     branches - the fix must not regress propagation.
//
//   * EXCESS ATTACHES - the legacy helper re-fires its attach/detach hook on
//     every runtime-driven `Zone.run`, over-attaching and emitting
//     `opentelemetry: unexpected (mismatched) token given to detach`. We count
//     those warnings as the excess-attach symptom. On `master` the count is
//     > 0; on PR #234 it MUST be 0.
import 'dart:async';
import 'dart:js_interop';

import 'package:logging/logging.dart';
import 'package:opentelemetry/api.dart' as otel;
import 'package:web/web.dart';

final _myKey = otel.ContextKey();
const _expectedValue = 'propagated-value';

// A known, fixed span context we expect to see propagated.
final _expectedSpanContext = otel.SpanContext(
  otel.TraceId([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]),
  otel.SpanId([1, 2, 3, 4, 5, 6, 7, 8]),
  otel.TraceFlags.sampled,
  otel.TraceState.empty(),
);

Future<void> main() async {
  final warnings = <String>[];

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    if (record.loggerName == 'opentelemetry' &&
        record.level >= Level.WARNING) {
      warnings.add(record.message);
      console.warn('[otel] ${record.message}'.toJS);
      _appendLog(record.message, cls: 'warn');
    }
  });

  // The context we expect to be visible everywhere inside the zone.
  final propagatedContext = otel.contextWithSpanContext(
    otel.Context.current.setValue(_myKey, _expectedValue),
    _expectedSpanContext,
  );

  // ---- Phase 1: propagation correctness -----------------------------------
  final failures = <String>[];
  var checkpoints = 0;

  void checkpoint(String label) {
    checkpoints++;
    final current = otel.Context.current;
    final value = current.getValue<String>(_myKey);
    final spanId = otel.spanContextFromContext(current).spanId.toString();
    final ok = value == _expectedValue &&
        spanId == _expectedSpanContext.spanId.toString();
    if (!ok) {
      failures.add('$label (value=$value, spanId=$spanId)');
    }
    _appendLog('  checkpoint[$label]: ${ok ? 'ok' : 'FAIL'} '
        '(value=$value)');
  }

  _appendLog('Phase 1: verifying context propagation inside zone()…');
  await otel.zone(propagatedContext).run(() async {
    checkpoint('sync-entry');
    await Future.microtask(() {});
    checkpoint('after-microtask');
    await Future<void>.delayed(Duration.zero);
    checkpoint('after-timer');
    await Future.value(0).whenComplete(() async {
      checkpoint('inside-whenComplete');
      await Future.microtask(() {});
    });
    checkpoint('after-whenComplete');

    // The real-world use case: a freshly started span (which defaults its
    // parent to `Context.current`) must parent to the propagated span context.
    final inferredParent =
        otel.spanContextFromContext(otel.Context.current).spanId.toString();
    checkpoints++;
    if (inferredParent != _expectedSpanContext.spanId.toString()) {
      failures.add('startSpan-parent (parentSpanId=$inferredParent)');
    }
    _appendLog('  checkpoint[startSpan-parent]: '
        "${inferredParent == _expectedSpanContext.spanId.toString() ? 'ok' : 'FAIL'}");
  });

  // ---- Phase 2: excess-attach probe ---------------------------------------
  // Generate runtime-driven Zone.run traffic. On the legacy helper this
  // over-attaches and logs mismatched-token warnings; on PR #234 it stays
  // silent.
  _appendLog('Phase 2: probing for excess attaches (10 iterations)…');
  for (var i = 0; i < 10; i++) {
    await otel.zone(propagatedContext).run(() async {
      await Future.microtask(() {});
      await Future<void>.delayed(Duration.zero);
      await Future.value(i).whenComplete(() async {
        await Future.microtask(() {});
      });
    });
  }
  // Let any deferred (whenComplete) detaches flush.
  await Future<void>.delayed(const Duration(milliseconds: 100));

  // ---- Verdict ------------------------------------------------------------
  final propagationOk = failures.isEmpty;
  final excessDetected = warnings.isNotEmpty;

  _renderResult(
    propagationOk: propagationOk,
    checkpoints: checkpoints,
    failures: failures,
    warningCount: warnings.length,
  );

  // Stable, machine-readable marker for tooling (Chrome DevTools console).
  console.log(
    'REPRO_RESULT '
            'propagation=${propagationOk ? 'PASS' : 'FAIL'} '
            'checkpoints=${checkpoints - failures.length}/$checkpoints '
            'excessAttaches=${excessDetected ? 'DETECTED' : 'NONE'} '
            'mismatchedDetachWarnings=${warnings.length}'
        .toJS,
  );
}

void _renderResult({
  required bool propagationOk,
  required int checkpoints,
  required List<String> failures,
  required int warningCount,
}) {
  final result = document.getElementById('result');
  if (result == null) return;
  final excessDetected = warningCount > 0;
  result
    ..textContent =
        'PROPAGATION: ${propagationOk ? 'PASS' : 'FAIL'} '
            '(${checkpoints - failures.length}/$checkpoints checkpoints)  |  '
            'EXCESS ATTACHES: ${excessDetected ? 'DETECTED' : 'NONE'} '
            '($warningCount mismatched-token warning${warningCount == 1 ? '' : 's'})'
    ..className = (propagationOk && !excessDetected) ? 'clean' : 'reproduced';
  if (failures.isNotEmpty) {
    _appendLog('Propagation failures: ${failures.join('; ')}', cls: 'warn');
  }
}

void _appendLog(String message, {String cls = ''}) {
  final log = document.getElementById('log');
  if (log == null) return;
  final line = document.createElement('div')
    ..textContent = message
    ..className = cls;
  log.appendChild(line);
}
