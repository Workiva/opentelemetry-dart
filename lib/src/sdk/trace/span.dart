import 'dart:html' show window;

import 'package:fixnum/fixnum.dart';

import '../../api/common/attributes.dart';
import '../../api/instrumentation_library.dart';
import '../../api/resource/resource.dart';
import '../../api/span_processors/span_processor.dart';
import '../../api/trace/span.dart' as span_api;
import '../../api/trace/span_status.dart';
import '../../sdk/trace/span_context.dart';
import '../common/attributes.dart' as attributes_sdk;
import 'span_id.dart';

/// A representation of a single operation within a trace.
class Span implements span_api.Span {
  final SpanContext _spanContext;
  final SpanId _parentSpanId;
  final SpanStatus _status = SpanStatus();
  final List<SpanProcessor> _processors;
  final Resource _resource;
  final InstrumentationLibrary _instrumentationLibrary;
  Int64 _startTime;
  Int64 _endTime;

  bool _usesMarksForStart = false;
  bool _usesMarksForEnd = false;
  String _markStartName;
  String _markEndName;

  @override
  String name;

  @override
  bool get isRecording => _endTime == null;

  /// Construct a [Span].
  Span(this.name, this._spanContext, this._parentSpanId, this._processors,
      this._resource, this._instrumentationLibrary,
      {Attributes attributes}) {
    // Cache these so they don't have to be recomputed.
    // (most span IDs are Int64s, whose `toString` isn't the fastest)
    final _markPrefix = '$name[${_spanContext.spanId}]';
    _markStartName = '$_markPrefix.start';
    _markEndName = '$_markPrefix.end';
    window.performance.mark(_markStartName);
    _usesMarksForStart = true;

    _startTime = Int64(DateTime.now().toUtc().microsecondsSinceEpoch);
    this.attributes = attributes ?? attributes_sdk.Attributes.empty();

    for (var i = 0; i < _processors.length; i++) {
      _processors[i].onStart();
    }
  }

  @override
  SpanContext get spanContext => _spanContext;

  @override
  Int64 get endTime => _endTime;

  @override
  Int64 get startTime => _startTime;

  @override
  SpanId get parentSpanId => _parentSpanId;

  /// A tag used to specify a custom measure name for a [Span]
  /// (the measure name default to [Span.name]).
  ///
  /// For instance, in the browser, this is the name that will be shown in the
  /// "User Timing" section of a timeline profile.
  ///
  /// This is useful when you want to display additional information
  /// for local debugging.
  ///
  ///     new Span('redraw_on', attributes: {
  ///       'component.name': 'MyClass',
  ///       devMeasureName: 'MyClass.redrawOn ($instanceCounter)',
  ///     })
  final String devMeasureName = 'dev.measure_name';

  /// The measure name, which is what's shown in the "User Timing" section of a
  /// browser dev tools timeline.
  ///
  /// Includes the name, spanId, and any references to other spans.
  ///
  /// If a consumer specifies a [devMeasureName] attribute, that will be used
  /// instead of the name.
  ///
  /// Compute this on-demand instead of during initialization since consumers
  /// may add attributes later in the span's lifetime.
  String get _measureName =>
      '${attributes.get(devMeasureName) ?? name}$_measureSuffix';

  /// A suffix for the measure name that includes additional information for use
  /// when debugging.
  ///
  /// Always include the span ID as a workaround for a bug where overlapping
  /// measures with the same name are displayed incorrectly in the dev tools:
  /// https://bugs.chromium.org/p/chromium/issues/detail?id=865780
  String get _measureSuffix =>
      ' - ${spanContext.spanId}[parentSpan:$parentSpanId]';

  // /// A short string representation of the referenced spans (including the
  // /// parentContext) for debugging purposes.
  // String get _referencesDebugString {
  //   final referencesParts = <String>[];
  //   if (parentContext != null) {
  //     referencesParts.add(getParentContextDebugString(parentContext));
  //   }

  //   // Remove the duplicate context in the debug string as seen when we've
  //   // already printed the context in cases where the parentContext is set
  //   // by the first childOf reference.
  //   for (final reference in references) {
  //     if (reference.referencedContext == parentContext) continue;
  //     referencesParts.add(getReferenceDebugString(reference));
  //   }

  //   return referencesParts.isEmpty ? '' : '[${referencesParts.join(', ')}]';
  // }

  // /// A short string representation of the span ID, for debugging purposes.
  // String get _spanIdDebugString => getSpanIdDebugString(context.spanId);

  // const int _truncationLength = 3;
  // // Fancy version of for `parseInt('0x' + 'f' * _truncationLength)`
  // final int _truncationMask = pow(16, _truncationLength) - 1;

  // /// Returns the last 3 hexadecimal digits of [int64], padded with 0s.
  // ///
  // /// 3 digits is a good balance of preventing collisions and not being too long
  // /// when used in a measure name.
  // String _truncatedInt64(Int64 int64) => (int64 & _truncationMask)
  //     .toHexString()
  //     .toLowerCase()
  //     .padLeft(_truncationLength, '0');

  // /// Returns a string representation of [spanId] for use in debugging,
  // /// truncated to 3 characters.
  // String getSpanIdDebugString(dynamic spanId) {
  //   if (spanId is Int64) return _truncatedInt64(spanId);

  //   const maxLength = 3;
  //   final idString = spanId.toString();
  //   // Take up to the last `maxLength` characters of the idString
  //   return idString.substring(max(idString.length - maxLength, 0));
  // }

  @override
  void end() {
    _endTime ??= Int64(DateTime.now().toUtc().microsecondsSinceEpoch);
    window.performance.mark(_markEndName);
    _usesMarksForEnd = true;
    if (_usesMarksForStart && _usesMarksForEnd) {
      window.performance.measure(_measureName, _markStartName, _markEndName);
    }

    for (var i = 0; i < _processors.length; i++) {
      _processors[i].onEnd(this);
    }
  }

  @override
  void setStatus(StatusCode status, {String description}) {
    // A status cannot be Unset after being set, and cannot be set to any other
    // status after being marked "Ok".
    if (status == StatusCode.unset || _status.code == StatusCode.ok) {
      return;
    }

    _status.code = status;

    // Description is ignored for statuses other than "Error".
    if (status == StatusCode.error && description != null) {
      _status.description = description;
    }
  }

  @override
  SpanStatus get status => _status;

  @override
  Resource get resource => _resource;

  @override
  InstrumentationLibrary get instrumentationLibrary => _instrumentationLibrary;

  @override
  Attributes attributes;
}
