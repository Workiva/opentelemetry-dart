// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:opentelemetry/api.dart' as api;
import 'package:opentelemetry/sdk.dart' as sdk;
import 'package:opentelemetry/src/sdk/logs/log_record_limit.dart';
import 'package:opentelemetry/src/sdk/logs/logger_config.dart';
import 'package:quiver/core.dart';

const defaultLoggerName = 'opentelemetry';

// https://opentelemetry.io/docs/specs/otel/logs/sdk/#loggerprovider
class LoggerProvider implements api.LoggerProvider {
  final Map<int, api.Logger> _loggers = {};

  final LoggerConfig _config;

  final List<sdk.LogRecordProcessor> _processors;

  final sdk.Resource _resource;

  final sdk.LogRecordLimits _logRecordLimits;

  final sdk.TimeProvider _timeProvider;

  LoggerProvider({
    LoggerConfig config = const LoggerConfig(),
    sdk.LogRecordLimits logRecordLimits = const LogRecordLimits(),
    sdk.Resource? resource,
    List<sdk.LogRecordProcessor>? processors,
    sdk.TimeProvider? timeProvider,
  })  : _processors = processors ?? const <sdk.LogRecordProcessor>[],
        _config = config,
        _logRecordLimits = logRecordLimits,
        _resource = resource ?? sdk.Resource([]),
        _timeProvider = timeProvider ?? sdk.DateTimeTimeProvider();

  @override
  api.Logger get(
    String name, {
    String version = '',
    String schemaUrl = '',
    List<api.Attribute> attributes = const [],
  }) {
    final loggerName = name.isNotEmpty ? name : defaultLoggerName;
    final key = hash3(loggerName, version, schemaUrl);
    if (_config.disabled) {
      return api.NoopLogger();
    }
    return _loggers.putIfAbsent(
      key,
      () => sdk.Logger(
        logRecordLimits: _logRecordLimits,
        resource: _resource,
        instrumentationScope: sdk.InstrumentationScope(loggerName, version, schemaUrl, attributes),
        timeProvider: _timeProvider,
        processors: _processors
      ),
    );
  }

  void forceFlush() {
    return _processors.forEach((e) => e.forceFlush());
  }

  void shutdown() {
    return _processors.forEach((e) => e.shutdown());
  }
}
