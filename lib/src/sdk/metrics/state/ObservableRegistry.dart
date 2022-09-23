
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
 import "dart:async"; import "package:@opentelemetry/api.dart" as api ; import "package:@opentelemetry/api.dart" show HrTime ; import "package:@opentelemetry/api-metrics.dart" show BatchObservableCallback , Observable , ObservableCallback ; import "../Instruments.dart" show isObservableInstrument , ObservableInstrument ; import "../ObservableResult.dart" show BatchObservableResultImpl , ObservableResultImpl ; import "../utils.dart" show callWithTimeout , PromiseAllSettled , isPromiseAllSettledRejectionResult , setEquals ;
 /**
 * Records for single instrument observable callback.
 */
 abstract class ObservableCallbackRecord { ObservableCallback callback ; ObservableInstrument instrument ; }
 /**
 * Records for multiple instruments observable callback.
 */
 abstract class BatchObservableCallbackRecord { BatchObservableCallback callback ; Set< ObservableInstrument > instruments ; }
 /**
 * An internal interface for managing ObservableCallbacks.
 *
 * Every registered callback associated with a set of instruments are be evaluated
 * exactly once during collection prior to reading data for that instrument.
 */
 class ObservableRegistry { List < ObservableCallbackRecord > _callbacks = [ ] ; List < BatchObservableCallbackRecord > _batchCallbacks = [ ] ; addCallback ( ObservableCallback callback , ObservableInstrument instrument ) { final idx = this . _findCallback ( callback , instrument ) ; if ( idx >= 0 ) { return ; } this . _callbacks . push ( { "callback" : callback , "instrument" : instrument } ) ; } removeCallback ( ObservableCallback callback , ObservableInstrument instrument ) { final idx = this . _findCallback ( callback , instrument ) ; if ( idx < 0 ) { return ; } this . _callbacks . splice ( idx , 1 ) ; } addBatchCallback ( BatchObservableCallback callback , List < Observable > instruments ) {
 // Create a set of unique instruments.
 final observableInstruments = new Set ( instruments . filter ( isObservableInstrument ) ) ; if ( identical ( observableInstruments . size , 0 ) ) { api . diag . error ( "BatchObservableCallback is not associated with valid instruments" , instruments ) ; return ; } final idx = this . _findBatchCallback ( callback , observableInstruments ) ; if ( idx >= 0 ) { return ; } this . _batchCallbacks . push ( { "callback" : callback , "instruments" : observableInstruments } ) ; } removeBatchCallback ( BatchObservableCallback callback , List < Observable > instruments ) {
 // Create a set of unique instruments.
 final observableInstruments = new Set ( instruments . filter ( isObservableInstrument ) ) ; final idx = this . _findBatchCallback ( callback , observableInstruments ) ; if ( idx < 0 ) { return ; } this . _batchCallbacks . splice ( idx , 1 ) ; }
 /**
   * 
   */
 Promise< List < unknown > > observe ( HrTime collectionTime , [ num timeoutMillis ] ) { final callbackFutures = this . _observeCallbacks ( collectionTime , timeoutMillis ) ; final batchCallbackFutures = this . _observeBatchCallbacks ( collectionTime , timeoutMillis ) ; final results = ; final rejections = results . filter ( isPromiseAllSettledRejectionResult ) . map ( ( it ) => it . reason ) ; return rejections ; } _observeCallbacks ( HrTime observationTime , [ num timeoutMillis ] ) { return this . _callbacks . map ( ( { callback , instrument } ) { final observableResult = new ObservableResultImpl ( instrument . _descriptor ) ; Promise callPromise = Promise . resolve ( callback ( observableResult ) ) ; if ( timeoutMillis != null ) { callPromise = callWithTimeout ( callPromise , timeoutMillis ) ; } ; instrument . _metricStorages . forEach ( ( metricStorage ) { metricStorage . record ( observableResult . _buffer , observationTime ) ; } ) ; } ) ; } _observeBatchCallbacks ( HrTime observationTime , [ num timeoutMillis ] ) { return this . _batchCallbacks . map ( ( { callback , instruments } ) { final observableResult = new BatchObservableResultImpl ( ) ; Promise callPromise = Promise . resolve ( callback ( observableResult ) ) ; if ( timeoutMillis != null ) { callPromise = callWithTimeout ( callPromise , timeoutMillis ) ; } ; instruments . forEach ( ( instrument ) { final buffer = observableResult . _buffer . get ( instrument ) ; if ( buffer == null ) { return ; } instrument . _metricStorages . forEach ( ( metricStorage ) { metricStorage . record ( buffer , observationTime ) ; } ) ; } ) ; } ) ; } _findCallback ( ObservableCallback callback , ObservableInstrument instrument ) { return this . _callbacks . findIndex ( ( record ) { return identical ( record . callback , callback ) && identical ( record . instrument , instrument ) ; } ) ; } _findBatchCallback ( BatchObservableCallback callback , Set< ObservableInstrument > instruments ) { return this . _batchCallbacks . findIndex ( ( record ) { return identical ( record . callback , callback ) && setEquals ( record . instruments , instruments ) ; } ) ; } }