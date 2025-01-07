// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:meta/meta.dart';
import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/experimental_api.dart' as api;
import 'package:opentelemetry/src/experimental_sdk.dart' as sdk;
import 'package:quiver/core.dart';

const defaultLoggerName = 'unknown';

class LoggerProvider implements api.LoggerProvider {
  @protected
  final Map<int, api.Logger> loggers = {};

  final List<sdk.LogRecordProcessor> logRecordProcessors;

  final sdk.Resource? resource;
  final sdk.LogRecordLimits? logRecordLimits;

  final sdk.TimeProvider _timeProvider;

  LoggerProvider({
    this.resource,
    this.logRecordLimits,
    List<sdk.LogRecordProcessor>? processors,
    sdk.TimeProvider? timeProvider,
  })  : logRecordProcessors = processors ?? <sdk.LogRecordProcessor>[],
        _timeProvider = timeProvider ?? sdk.DateTimeTimeProvider();

  @override
  api.Logger get(
    String name, {
    String version = '',
    String schemaUrl = '',
    List<api.Attribute> attributes = const [],
    bool? includeTraceContext,
  }) {
    final loggerName = name.isNotEmpty ? name : defaultLoggerName;
    final key = hash3(loggerName, version, schemaUrl);
    return loggers.putIfAbsent(
      key,
      () => sdk.Logger(
        logRecordLimits: logRecordLimits ?? sdk.LogRecordLimits(),
        resource: resource,
        instrumentationScope: sdk.InstrumentationScope(loggerName, version, schemaUrl, attributes),
        timeProvider: _timeProvider,
        onLogEmit: (log) {
          for (final processor in logRecordProcessors) {
            processor.onEmit(log);
          }
        },
      ),
    );
  }

  void addLogRecordProcessor(sdk.LogRecordProcessor processor) {
    logRecordProcessors.add(processor);
  }

  Future<void> forceFlush() async {
    await Future.forEach(logRecordProcessors, (e) => e.forceFlush());
  }

  Future<void> shutdown() async {
    await Future.forEach(logRecordProcessors, (e) => e.shutdown());
  }
}
