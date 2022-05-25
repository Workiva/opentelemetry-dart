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
      {List<api.SpanProcessor> processors,
      sdk.Resource resource,
      sdk.Sampler sampler,
      api.IdGenerator idGenerator,
      sdk.SpanLimits spanLimits})
      : _processors = processors ?? [], // Default to a no-op TracerProvider.
        _resource = resource ?? sdk.Resource([]),
        _sampler = sampler ?? sdk.ParentBasedSampler(sdk.AlwaysOnSampler()),
        _idGenerator = idGenerator ?? sdk.IdGenerator(),
        _spanLimits = spanLimits ?? sdk.SpanLimits();

  List<api.SpanProcessor> get spanProcessors => _processors;

  @override
  api.Tracer getTracer(String name, {String version = ''}) {
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
