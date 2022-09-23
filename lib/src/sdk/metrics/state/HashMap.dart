
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
 import "package:@opentelemetry/api-metrics.dart" show MetricAttributes ; import "../utils.dart" show hashAttributes ; typedef HashCodeType Hash < ValueType , HashCodeType > ( ValueType value ) ; class HashMap < KeyType , ValueType , HashCodeType > { Hash< KeyType , HashCodeType > _hash ; var _valueMap = new Map< HashCodeType , ValueType > ( ) ; var _keyMap = new Map< HashCodeType , KeyType > ( ) ; HashMap ( this . _hash ) { } get ( KeyType key , [ HashCodeType hashCode ] ) { hashCode ?  ?  = this . _hash ( key ) :  :  ; return this . _valueMap . get ( hashCode ) ; } getOrDefault ( KeyType key , ValueType defaultFactory ( ) ) { final hash = this . _hash ( key ) ; if ( this . _valueMap . has ( hash ) ) { return this . _valueMap . get ( hash ) ; } final val = defaultFactory ( ) ; if ( ! this . _keyMap . has ( hash ) ) { this . _keyMap . set ( hash , key ) ; } this . _valueMap . set ( hash , val ) ; return val ; } set ( KeyType key , ValueType value , [ HashCodeType hashCode ] ) { hashCode ?  ?  = this . _hash ( key ) :  :  ; if ( ! this . _keyMap . has ( hashCode ) ) { this . _keyMap . set ( hashCode , key ) ; } this . _valueMap . set ( hashCode , value ) ; } has ( KeyType key , [ HashCodeType hashCode ] ) { hashCode ?  ?  = this . _hash ( key ) :  :  ; return this . _valueMap . has ( hashCode ) ; } IterableIterator< > keys ( ) { final keyIterator = this . _keyMap . entries ( ) ; var next = keyIterator . next ( ) ; while ( ! identical ( next . done , true ) ) { ; next = keyIterator . next ( ) ; } } IterableIterator< > entries ( ) { final valueIterator = this . _valueMap . entries ( ) ; var next = valueIterator . next ( ) ; while ( ! identical ( next . done , true ) ) {
 // next.value[0] here can not be undefined

 // eslint-disable-next-line @typescript-eslint/no-non-null-assertion
 ; next = valueIterator . next ( ) ; } } get size { return this . _valueMap . size ; } } class AttributeHashMap < ValueType > extends HashMap< MetricAttributes , ValueType , String > { AttributeHashMap ( ) : super ( hashAttributes ) { /* super call moved to initializer */ ; } }