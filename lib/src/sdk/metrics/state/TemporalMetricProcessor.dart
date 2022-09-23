
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
 import "package:@opentelemetry/api.dart" show HrTime ; import "../aggregator/types.dart" show Accumulation , AccumulationRecord , Aggregator ; import '../export/metric_data.dart' show MetricData ; import "../InstrumentDescriptor.dart" show InstrumentDescriptor ; import "../export/AggregationTemporality.dart" show AggregationTemporality ; import "../utils.dart" show Maybe ; import "MetricCollector.dart" show MetricCollectorHandle ; import "HashMap.dart" show AttributeHashMap ;
 /**
 * Remembers what was presented to a specific exporter.
 */
 abstract class LastReportedHistory < T extends Maybe< Accumulation > > {
 /**
   * The last accumulation of metric data.
   */
 AttributeHashMap< T > accumulations ;
 /**
   * The timestamp the data was reported.
   */
 HrTime collectionTime ;
 /**
   * The AggregationTemporality used to aggregate reports.
   */
 AggregationTemporality aggregationTemporality ; }
 /**
 * Internal interface.
 *
 * Provides unique reporting for each collector. Allows synchronous collection
 * of metrics and reports given temporality values.
 */
 class TemporalMetricProcessor < T extends Maybe< Accumulation > > { Aggregator< T > _aggregator ; var _unreportedAccumulations = new Map< MetricCollectorHandle , List < AttributeHashMap< T > > > ( ) ; var _reportHistory = new Map< MetricCollectorHandle , LastReportedHistory< T > > ( ) ; TemporalMetricProcessor ( this . _aggregator ) { }
 /**
   * Builds the [MetricData] streams to report against a specific MetricCollector.
   * 
   * 
   * 
   * 
   * 
   * 
   */
 Maybe< MetricData > buildMetrics ( MetricCollectorHandle collector , List < MetricCollectorHandle > collectors , InstrumentDescriptor instrumentDescriptor , AttributeHashMap< T > currentAccumulations , HrTime collectionTime ) { this . _stashAccumulations ( collectors , currentAccumulations ) ; final unreportedAccumulations = this . _getMergedUnreportedAccumulations ( collector ) ; var result = unreportedAccumulations ; AggregationTemporality aggregationTemporality ;
 // Check our last report time.
 if ( this . _reportHistory . has ( collector ) ) {
 // eslint-disable-next-line @typescript-eslint/no-non-null-assertion
 final last = ; final lastCollectionTime = last . collectionTime ; aggregationTemporality = last . aggregationTemporality ;
 // Use aggregation temporality + instrument to determine if we do a merge or a diff of

 // previous. We have the following four scenarios:

 // 1. Cumulative Aggregation (temporality) + Delta recording (sync instrument).

 //    Here we merge with our last record to get a cumulative aggregation.

 // 2. Cumulative Aggregation + Cumulative recording (async instrument).

 //    Cumulative records are converted to delta recording with DeltaMetricProcessor.

 //    Here we merge with our last record to get a cumulative aggregation.

 // 3. Delta Aggregation + Delta recording

 //    Calibrate the startTime of metric streams to be the reader's lastCollectionTime.

 // 4. Delta Aggregation + Cumulative recording.

 //    Cumulative records are converted to delta recording with DeltaMetricProcessor.

 //    Calibrate the startTime of metric streams to be the reader's lastCollectionTime.
 if ( identical ( aggregationTemporality , AggregationTemporality . CUMULATIVE ) ) {
 // We need to make sure the current delta recording gets merged into the previous cumulative

 // for the next cumulative recording.
 result = TemporalMetricProcessor . merge ( last . accumulations , unreportedAccumulations , this . _aggregator ) ; } else { result = TemporalMetricProcessor . calibrateStartTime ( last . accumulations , unreportedAccumulations , lastCollectionTime ) ; } } else {
 // Call into user code to select aggregation temporality for the instrument.
 aggregationTemporality = collector . selectAggregationTemporality ( instrumentDescriptor . type ) ; }
 // Update last reported (cumulative) accumulation.
 this . _reportHistory . set ( collector , { "accumulations" : result , "collectionTime" : collectionTime , "aggregationTemporality" : aggregationTemporality } ) ; return this . _aggregator . toMetricData ( instrumentDescriptor , aggregationTemporality , AttributesMapToAccumulationRecords ( result ) ,
 /* endTime */ collectionTime ) ; } _stashAccumulations ( List < MetricCollectorHandle > collectors , AttributeHashMap< T > currentAccumulation ) { collectors . forEach ( ( it ) { var stash = this . _unreportedAccumulations . get ( it ) ; if ( identical ( stash , undefined ) ) { stash = [ ] ; this . _unreportedAccumulations . set ( it , stash ) ; } stash . push ( currentAccumulation ) ; } ) ; } _getMergedUnreportedAccumulations ( MetricCollectorHandle collector ) { var result = new AttributeHashMap< T > ( ) ; final unreportedList = this . _unreportedAccumulations . get ( collector ) ; this . _unreportedAccumulations . set ( collector , [ ] ) ; if ( identical ( unreportedList , undefined ) ) { return result ; } for ( final it in unreportedList ) { result = TemporalMetricProcessor . merge ( result , it , this . _aggregator ) ; } return result ; } static merge /*< T >*/ ( AttributeHashMap< T > last , AttributeHashMap< T > current , Aggregator< T > aggregator ) { final result = last ; final iterator = current . entries ( ) ; var next = iterator . next ( ) ; while ( ! identical ( next . done , true ) ) { final = next . value ; if ( last . has ( key , hash ) ) { final lastAccumulation = last . get ( key , hash ) ;
 // last.has() returned true, lastAccumulation is present.

 // eslint-disable-next-line @typescript-eslint/no-non-null-assertion
 final accumulation = aggregator . merge ( , record ) ; result . set ( key , accumulation , hash ) ; } else { result . set ( key , record , hash ) ; } next = iterator . next ( ) ; } return result ; }
 /**
   * Calibrate the reported metric streams' startTime to lastCollectionTime. Leaves
   * the new stream to be the initial observation time unchanged.
   */
 static calibrateStartTime /*< T >*/ ( AttributeHashMap< T > last , AttributeHashMap< T > current , HrTime lastCollectionTime ) { for ( final in last . keys ( ) ) { final currentAccumulation = current . get ( key , hash ) ; currentAccumulation ?  . setStartTime ( lastCollectionTime ) :  ; } return current ; } }
 // TypeScript complains about converting 3 elements tuple to AccumulationRecord<T>.
 List < AccumulationRecord< T > > AttributesMapToAccumulationRecords /*< T >*/ ( AttributeHashMap< T > map ) { return ; }