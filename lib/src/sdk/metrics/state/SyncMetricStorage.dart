/*
 * Copyright The OpenTelemetry Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import "package:@opentelemetry/api.dart" show Context, HrTime;
import "package:@opentelemetry/api-metrics.dart" show MetricAttributes;
import 'writable_metric_storage.dart' show WritableMetricStorage;
import "../aggregator/types.dart" show Accumulation, Aggregator;
import "../InstrumentDescriptor.dart" show InstrumentDescriptor;
import "../view/AttributesProcessor.dart" show AttributesProcessor;
import 'metrics_storage.dart' show MetricStorage;
import '../export/metric_data.dart' show MetricData;
import "DeltaMetricProcessor.dart" show DeltaMetricProcessor;
import "TemporalMetricProcessor.dart" show TemporalMetricProcessor;
import "../utils.dart" show Maybe;
import "MetricCollector.dart" show MetricCollectorHandle;

/**
 * Internal interface.
 *
 * Stores and aggregates [MetricData] for synchronous instruments.
 */
class SyncMetricStorage<T extends Maybe<Accumulation>> extends MetricStorage
    implements WritableMetricStorage {
  AttributesProcessor _attributesProcessor;
  DeltaMetricProcessor<T> _deltaMetricStorage;
  TemporalMetricProcessor<T> _temporalMetricStorage;
  SyncMetricStorage(InstrumentDescriptor instrumentDescriptor,
      Aggregator<T> aggregator, this._attributesProcessor)
      : super(instrumentDescriptor) {
    /* super call moved to initializer */;
    this._deltaMetricStorage = new DeltaMetricProcessor(aggregator);
    this._temporalMetricStorage = new TemporalMetricProcessor(aggregator);
  }
  record(num value, MetricAttributes attributes, Context context,
      HrTime recordTime) {
    attributes = this._attributesProcessor.process(attributes, context);
    this._deltaMetricStorage.record(value, attributes, context, recordTime);
  }

  /**
   * Collects the metrics from this storage.
   *
   * Note: This is a stateful operation and may reset any interval-related
   * state for the MetricCollector.
   */
  Maybe<MetricData> collect(MetricCollectorHandle collector,
      List<MetricCollectorHandle> collectors, HrTime collectionTime) {
    final accumulations = this._deltaMetricStorage.collect();
    return this._temporalMetricStorage.buildMetrics(collector, collectors,
        this._instrumentDescriptor, accumulations, collectionTime);
  }
}
