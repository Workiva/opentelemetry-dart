// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:meta/meta.dart';

import './tracer.dart';
import '../../../api.dart' as api;
import '../../../sdk.dart' as sdk;

/// A registry for creating named [api.Tracer]s.
class TracerProviderBase implements api.TracerProvider {
  @protected
  final Map<String, Tracer> tracers = {};

  @protected
  final List<sdk.SpanProcessor> processors;

  @protected
  final sdk.Resource resource;

  @protected
  final sdk.Sampler sampler;

  @protected
  final api.IdGenerator idGenerator;

  @protected
  final sdk.SpanLimits spanLimits;

  final sdk.TimeProvider _timeProvider;

  TracerProviderBase(
      {this.processors =
          const [], // Default to a TracerProvider which does not emit traces.
      resource,
      sdk.TimeProvider? timeProvider,
      this.sampler = const sdk.ParentBasedSampler(sdk.AlwaysOnSampler()),
      this.idGenerator = const sdk.IdGenerator(),
      this.spanLimits = const sdk.SpanLimits()})
      : resource = resource ?? sdk.Resource([]),
        _timeProvider = timeProvider ?? sdk.DateTimeTimeProvider();

  List<sdk.SpanProcessor> get spanProcessors => processors;

  @override
  api.Tracer getTracer(String name,
      {String version = '',
      String schemaUrl = '',
      List<api.Attribute> attributes = const []}) {
    final key = '$name@$version';
    return tracers.putIfAbsent(
        key,
        () => Tracer(
            processors,
            resource,
            sampler,
            _timeProvider,
            idGenerator,
            sdk.InstrumentationScope(name, version, schemaUrl, attributes),
            spanLimits));
  }

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
}
