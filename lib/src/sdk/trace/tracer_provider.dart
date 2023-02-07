// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import './tracer.dart';
import '../../../api.dart' as api;
import '../../../sdk.dart' as sdk;

/// A registry for creating named [api.Tracer]s.
class TracerProviderBase implements api.TracerProvider {
  final Map<String, api.Tracer> _tracers = {};
  final List<api.SpanProcessor> _processors;
  final sdk.Resource _resource;
  final sdk.Sampler _sampler;
  final api.IdGenerator _idGenerator;
  final sdk.SpanLimits _spanLimits;

  TracerProviderBase(
      {List<api.SpanProcessor>? processors,
      sdk.Resource? resource,
      sdk.Sampler? sampler,
      api.IdGenerator? idGenerator,
      sdk.SpanLimits? spanLimits})
      : _processors = processors ?? [], // Default to a no-op TracerProvider.
        _resource = resource ?? sdk.Resource([]),
        _sampler = sampler ?? sdk.ParentBasedSampler(sdk.AlwaysOnSampler()),
        _idGenerator = idGenerator ?? sdk.IdGenerator(),
        _spanLimits = spanLimits ?? sdk.SpanLimits();

  List<api.SpanProcessor> get spanProcessors => _processors;

  @override
  api.Tracer getTracer(String name, {String? version = ''}) {
    final key = '$name@$version';
    return _tracers.putIfAbsent(
        key,
        () => Tracer(
            _processors,
            _resource,
            _sampler,
            sdk.DateTimeTimeProvider(),
            _idGenerator,
            sdk.InstrumentationLibrary(name, version),
            spanLimits: _spanLimits));
  }

  @override
  void forceFlush() {
    for (var i = 0; i < _processors.length; i++) {
      _processors[i].forceFlush();
    }
  }

  @override
  void shutdown() {
    for (var i = 0; i < _processors.length; i++) {
      _processors[i].shutdown();
    }
  }
}
