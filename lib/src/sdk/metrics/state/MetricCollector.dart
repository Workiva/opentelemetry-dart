
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
 import "dart:async"; import "package:@opentelemetry/core.dart" show hrTime ; import "../export/AggregationSelector.dart" show AggregationTemporalitySelector ; import '../export/metric_data.dart' show CollectionResult ; import "../export/MetricProducer.dart" show MetricProducer , MetricCollectOptions ; import "../export/MetricReader.dart" show MetricReader ; import "../InstrumentDescriptor.dart" show InstrumentType ; import "../types.dart" show ForceFlushOptions , ShutdownOptions ; import "../utils.dart" show FlatMap ; import "MeterProviderSharedState.dart" show MeterProviderSharedState ;
 /**
 * An internal opaque interface that the MetricReader receives as
 * MetricProducer. It acts as the storage key to the internal metric stream
 * state for each MetricReader.
 */
 class MetricCollector implements MetricProducer { MeterProviderSharedState _sharedState ; MetricReader _metricReader ; MetricCollector ( this . _sharedState , this . _metricReader ) { } Promise< CollectionResult > collect ( [ MetricCollectOptions options ] ) { final collectionTime = hrTime ( ) ; final meterCollectionPromises = Array . from ( this . _sharedState . meterSharedStates . values ( ) ) . map ( ( meterSharedState ) => meterSharedState . collect ( this , collectionTime , options ) ) ; final result = ; return { "resourceMetrics" : { "resource" : this . _sharedState . resource , "scopeMetrics" : result . map ( ( it ) => it . scopeMetrics ) } , "errors" : FlatMap ( result , ( it ) => it . errors ) } ; }
 /**
   * Delegates for MetricReader.forceFlush.
   */
 Promise forceFlush ( [ ForceFlushOptions options ] ) { ; }
 /**
   * Delegates for MetricReader.shutdown.
   */
 Promise shutdown ( [ ShutdownOptions options ] ) { ; } selectAggregationTemporality ( InstrumentType instrumentType ) { return this . _metricReader . selectAggregationTemporality ( instrumentType ) ; } selectAggregation ( InstrumentType instrumentType ) { return this . _metricReader . selectAggregation ( instrumentType ) ; } }
 /**
 * An internal interface for MetricCollector. Exposes the necessary
 * information for metric collection.
 */
 abstract class MetricCollectorHandle { AggregationTemporalitySelector selectAggregationTemporality ; }