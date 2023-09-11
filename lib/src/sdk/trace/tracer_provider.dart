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

  TracerProviderBase(
      {List<sdk.SpanProcessor> processors,
      sdk.Resource resource,
      sdk.Sampler sampler,
      api.IdGenerator idGenerator,
      sdk.SpanLimits spanLimits})
      : processors = processors ?? [], // Default to a no-op TracerProvider.
        resource = resource ?? sdk.Resource([]),
        sampler = sampler ?? sdk.ParentBasedSampler(sdk.AlwaysOnSampler()),
        idGenerator = idGenerator ?? sdk.IdGenerator(),
        spanLimits = spanLimits ?? sdk.SpanLimits();

  List<sdk.SpanProcessor> get spanProcessors => processors;

  @override
  api.Tracer getTracer(String name, {String version = ''}) {
    final key = '$name@$version';
    return tracers.putIfAbsent(
        key,
        () => Tracer(
            processors,
            resource,
            sampler,
            sdk.DateTimeTimeProvider(),
            idGenerator,
            sdk.InstrumentationLibrary(name, version),
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
