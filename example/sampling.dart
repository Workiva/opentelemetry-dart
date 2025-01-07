// Copyright 2021-2022 Workiva.
// Licensed under the Apache License, Version 2.0. Please see https://github.com/Workiva/opentelemetry-dart/blob/master/LICENSE for more information

import 'package:collection/collection.dart';
import 'package:opentelemetry/api.dart'
    show
        Attribute,
        Context,
        SpanKind,
        SpanLink,
        TraceId,
        registerGlobalTracerProvider,
        spanContextFromContext;
import 'package:opentelemetry/sdk.dart'
    show
        ConsoleExporter,
        Decision,
        ParentBasedSampler,
        ReadOnlySpan,
        ReadWriteSpan,
        Sampler,
        SamplingResult,
        SimpleSpanProcessor,
        TracerProviderBase;

final Attribute samplingOffAttribute =
    Attribute.fromInt('sampling.priority', 0);

class SpanSamplingPrioritySampler implements Sampler {
  @override
  SamplingResult shouldSample(
      Context parentContext,
      TraceId traceId,
      String name,
      SpanKind spanKind,
      List<Attribute> attributes,
      List<SpanLink> links) {
    final decision = attributes.firstWhereOrNull((element) =>
                element.key == 'sampling.priority' && element.value == 0) !=
            null
        ? Decision.recordOnly
        : Decision.recordAndSample;

    return SamplingResult(
        decision, attributes, spanContextFromContext(parentContext).traceState);
  }

  @override
  String get description => 'SpanSamplingPrioritySampler';
}

class PrintingSpanProcessor extends SimpleSpanProcessor {
  PrintingSpanProcessor(super.exporter);

  @override
  void onStart(ReadWriteSpan span, Context parentContext) {
    print('Span started: ${span.name}');
    super.onStart(span, parentContext);
  }

  @override
  void onEnd(ReadOnlySpan span) {
    print('Span ended: ${span.name}');
    super.onEnd(span);
  }

  @override
  void shutdown() {
    print('Shutting down');
    super.shutdown();
  }

  @override
  void forceFlush() {}
}

void main(List<String> args) async {
  final sampler = ParentBasedSampler(SpanSamplingPrioritySampler());
  final tp = TracerProviderBase(
      processors: [PrintingSpanProcessor(ConsoleExporter())], sampler: sampler);
  registerGlobalTracerProvider(tp);

  final tracer = tp.getTracer('instrumentation-name');

  tracer.startSpan('span-not-sampled', attributes: [
    samplingOffAttribute,
  ]).end();
  tracer.startSpan('span-sampled').end();

  tp.shutdown();
}
