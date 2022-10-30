
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
 import "dart:async"; import "package:@opentelemetry/api.dart" show HrTime ; import "package:@opentelemetry/core.dart" show InstrumentationScope ; import "../export/MetricProducer.dart" show MetricCollectOptions ; import '../export/metric_data.dart' show ScopeMetrics ; import "../InstrumentDescriptor.dart" show createInstrumentDescriptorWithView , InstrumentDescriptor ; import "../Meter.dart" show Meter ; import "../utils.dart" show isNotNullish , Maybe ; import "AsyncMetricStorage.dart" show AsyncMetricStorage ; import 'meter_provider_shared_state.dart' show MeterProviderSharedState ; import "MetricCollector.dart" show MetricCollectorHandle ; import "MetricStorageRegistry.dart" show MetricStorageRegistry ; import 'multi_writable_metric_storage.dart' show MultiMetricStorage ; import "ObservableRegistry.dart" show ObservableRegistry ; import "SyncMetricStorage.dart" show SyncMetricStorage ; import "../aggregator/types.dart" show Accumulation , Aggregator ; import "../view/AttributesProcessor.dart" show AttributesProcessor ; import 'metrics_storage.dart' show MetricStorage ;
 /**
 * An internal record for shared meter provider states.
 */
 class MeterSharedState { MeterProviderSharedState _meterProviderSharedState ; InstrumentationScope _instrumentationScope ; var metricStorageRegistry = new MetricStorageRegistry ( ) ; var observableRegistry = new ObservableRegistry ( ) ; Meter meter ; MeterSharedState ( this . _meterProviderSharedState , this . _instrumentationScope ) { this . meter = new Meter ( this ) ; } registerMetricStorage ( InstrumentDescriptor descriptor ) { final storages = this . _registerMetricStorage ( descriptor , SyncMetricStorage ) ; if ( identical ( storages . length , 1 ) ) { return storages [ 0 ] ; } return new MultiMetricStorage ( storages ) ; } registerAsyncMetricStorage ( InstrumentDescriptor descriptor ) { final storages = this . _registerMetricStorage ( descriptor , AsyncMetricStorage ) ; return storages ; }
 /**
   * 
   * 
   * 
   * 
   */
 Promise< ScopeMetricsResult > collect ( MetricCollectorHandle collector , HrTime collectionTime , [ MetricCollectOptions options ] ) {
 /**
     * 1. Call all observable callbacks first.
     * 2. Collect metric result for the collector.
     */
 final errors = ; final metricDataList = Array . from ( this . metricStorageRegistry . getStorages ( collector ) ) . map ( ( metricStorage ) { return metricStorage . collect ( collector , this . _meterProviderSharedState . metricCollectors , collectionTime ) ; } ) . filter ( isNotNullish ) ; return { "scopeMetrics" : { "scope" : this . _instrumentationScope , "metrics" : metricDataList . filter ( isNotNullish ) } , "errors" : errors } ; } List < R > _registerMetricStorage /*< MetricStorageType, R >*/ ( InstrumentDescriptor descriptor , MetricStorageType MetricStorageType ) { final views = this . _meterProviderSharedState . viewRegistry . findViews ( descriptor , this . _instrumentationScope ) ; var storages = views . map ( ( view ) { final viewDescriptor = createInstrumentDescriptorWithView ( view , descriptor ) ; final compatibleStorage = this . metricStorageRegistry . findOrUpdateCompatibleStorage /*< R >*/ ( viewDescriptor ) ; if ( compatibleStorage != null ) { return compatibleStorage ; } final aggregator = view . aggregation . createAggregator ( viewDescriptor ) ; final viewStorage = ; this . metricStorageRegistry . register ( viewStorage ) ; return viewStorage ; } ) ;
 // Fallback to the per-collector aggregations if no view is configured for the instrument.
 if ( identical ( storages . length , 0 ) ) { final perCollectorAggregations = this . _meterProviderSharedState . selectAggregations ( descriptor . type ) ; final collectorStorages = perCollectorAggregations . map ( ( ) { final compatibleStorage = this . metricStorageRegistry . findOrUpdateCompatibleCollectorStorage /*< R >*/ ( collector , descriptor ) ; if ( compatibleStorage != null ) { return compatibleStorage ; } final aggregator = aggregation . createAggregator ( descriptor ) ; final storage = ; this . metricStorageRegistry . registerForCollector ( collector , storage ) ; return storage ; } ) ; storages = storages . concat ( collectorStorages ) ; } return storages ; } } abstract class ScopeMetricsResult { ScopeMetrics scopeMetrics ; List < unknown > errors ; } abstract class MetricStorageConstructor { }