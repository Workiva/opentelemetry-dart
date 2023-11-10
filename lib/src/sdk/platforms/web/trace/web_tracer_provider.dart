// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import '../../../../../api.dart' as api;
import '../../../../../sdk.dart' as sdk;
import '../../../trace/tracer.dart';

/// A [api.TracerProvider] which implements features specific to `dart:html`.
///
/// Use of [WebTracerProvider] with this provider results in a [api.Tracer]
/// which uses the `window.performance` API for high-precision timestamps
/// on the [api.Span]s it creates.
///
/// Note that these timestamps may be inaccurate if the executing system is
/// suspended for sleep.
/// See https://github.com/open-telemetry/opentelemetry-js/issues/852
/// for more information.
class WebTracerProvider extends sdk.TracerProviderBase {
  final sdk.TimeProvider _timeProvider;

  WebTracerProvider(
      {List<sdk.SpanProcessor>? processors,
      sdk.Resource? resource,
      sdk.Sampler? sampler,
      sdk.TimeProvider? timeProvider,
      api.IdGenerator? idGenerator,
      sdk.SpanLimits? spanLimits})
      : _timeProvider = timeProvider ?? sdk.DateTimeTimeProvider(),
        super(
            processors: processors ??
                [], // Default to a TracerProvider which does not emit traces.
            resource: resource ?? sdk.Resource([]),
            sampler: sampler ?? sdk.ParentBasedSampler(sdk.AlwaysOnSampler()),
            idGenerator: idGenerator ?? sdk.IdGenerator(),
            spanLimits: spanLimits ?? sdk.SpanLimits());

  @override
  api.Tracer getTracer(String name,
      {String version = '',
      String schemaUrl = '',
      List<api.Attribute> attributes = const []}) {
    return tracers.putIfAbsent(
        '$name@$version',
        () => Tracer(
            processors,
            resource,
            sampler,
            _timeProvider,
            idGenerator,
            sdk.InstrumentationScope(name, version, schemaUrl, attributes),
            spanLimits));
  }
}
