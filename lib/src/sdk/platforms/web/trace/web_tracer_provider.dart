// Copyright 2021-2022 Workiva Inc.

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at

//     http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

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
  final Map<String, api.Tracer> _tracers = {};
  final List<api.SpanProcessor> _processors;
  final sdk.Resource _resource;
  final sdk.Sampler _sampler;
  final sdk.TimeProvider _timeProvider;
  final api.IdGenerator _idGenerator;
  final sdk.SpanLimits _spanLimits;

  WebTracerProvider(
      {List<api.SpanProcessor> processors,
      sdk.Resource resource,
      sdk.Sampler sampler,
      sdk.TimeProvider timeProvider,
      api.IdGenerator idGenerator,
      sdk.SpanLimits spanLimits})
      :
        // Default to a no-op TracerProvider.
        _processors = processors ?? [],
        _resource = resource ?? sdk.Resource([]),
        _sampler = sampler ?? sdk.ParentBasedSampler(sdk.AlwaysOnSampler()),
        _timeProvider = timeProvider ?? sdk.DateTimeTimeProvider(),
        _idGenerator = idGenerator ?? sdk.IdGenerator(),
        _spanLimits = spanLimits ?? sdk.SpanLimits(),
        super(
            processors: processors,
            resource: resource,
            sampler: sampler,
            idGenerator: idGenerator,
            spanLimits: spanLimits);

  @override
  api.Tracer getTracer(String name, {String version = ''}) {
    return _tracers.putIfAbsent(
        '$name@$version',
        () => Tracer(_processors, _resource, _sampler, _timeProvider,
            _idGenerator, sdk.InstrumentationLibrary(name, version),
            spanLimits: _spanLimits));
  }
}
