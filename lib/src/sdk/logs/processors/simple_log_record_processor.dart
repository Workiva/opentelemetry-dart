// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'dart:async';

import 'package:logging/logging.dart' as logging;
import 'package:meta/meta.dart';
import 'package:opentelemetry/src/experimental_sdk.dart' as sdk;

class SimpleLogRecordProcessor implements sdk.LogRecordProcessor {
  final logger = logging.Logger('opentelemetry.sdk.logs.simplelogrecordprocessor');
  final sdk.LogRecordExporter exporter;
  bool _shutDownOnce = false;

  @visibleForTesting
  final exportsCompletion = <Completer>[];

  SimpleLogRecordProcessor({required this.exporter});

  bool _isForcedFlushed = false;

  @override
  void onEmit(sdk.ReadableLogRecord logRecord) {
    if (_shutDownOnce) return;
    final completer = Completer();
    exportsCompletion.add(completer);
    exporter.export([logRecord]).then((result) {
      if (result.code != sdk.ExportResultCode.success) {
        logger.shout('SimpleLogRecordProcessor: log record export failed', result.error, result.stackTrace);
      }
    }).whenComplete(() {
      completer.complete();
      if (_isForcedFlushed) return;
      exportsCompletion.remove(completer);
    });
  }

  @override
  Future<void> forceFlush() async {
    _isForcedFlushed = true;
    await Future.forEach(exportsCompletion, (completer) => completer.future);
  }

  @override
  Future<void> shutdown() async {
    _shutDownOnce = true;
    await exporter.shutdown();
  }
}
