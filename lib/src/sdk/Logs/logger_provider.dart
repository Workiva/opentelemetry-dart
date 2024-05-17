// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:meta/meta.dart';
import 'package:opentelemetry/src/api/Logs/logger_provider.dart';
import 'package:opentelemetry/src/sdk/Logs/log_limits.dart';
import 'package:opentelemetry/src/sdk/Logs/logging_tracer.dart';

import './logg.dart';
import '../../../api.dart' as api;
import '../../../sdk.dart' as sdk;

class LoggerTraceProviderBase implements api.LoggerProvider{
  @protected
  final Map<String, LoggTracer> tracers = {};

  @protected
  late final List<sdk.LogRecordProcessor> processors;

  @protected
  late final sdk.Resource resource;
  @protected
  final sdk.Sampler sampler;

  @protected
  final api.IdGenerator idGenerator;

  @protected
  final sdk.LogLimits logLimits;
  @override
  void forceFlush() {
    for (var i = 0; i < processors.length; i++) {
      processors[i].forceFlush();
    }
  }

  @override
  void shutdown() {
    for (var i = 0; i < processors.length; i++) {
      processors[i].shutdown();
    }
  }

  LoggerTraceProviderBase(this.logLimits, { this.processors = const [],resource,
    this.idGenerator = const sdk.IdGenerator(),
    this.sampler = const sdk.ParentBasedSampler(sdk.AlwaysOnSampler())
  }): resource = resource ?? sdk.Resource([]);
  @override
  api.LogTracer getLogger(String name,String version , String schemaUrl , List<api.Attribute> attributes) {
    // TODO: implement getLogger

    return LoggTracer(processors, resource, sdk.DateTimeTimeProvider(),
        sdk.InstrumentationScope(name, version, schemaUrl, attributes),
        idGenerator,
        sampler,
        logLimits);

  }
}
