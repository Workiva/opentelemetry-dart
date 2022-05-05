import 'dart:html' show window;
import 'dart:math' show max, pow;

import 'package:fixnum/fixnum.dart';

import '../../../../../api.dart' as api;
import '../../../../../sdk.dart' as sdk;
import '../user_timing_filters/mark_measure_filter.dart';
import '../user_timing_filters/window_measure_filter.dart';

class UserTimingSpanProcessor implements api.SpanProcessor {
  final api.SpanExporter _exporter;
  bool _isShutdown = false;

  // Cache these so they don't have to be recomputed.
  // (most span IDs are Int64s, whose `toString` isn't the fastest)
  String _markPrefix;
  String _markStartName;
  String _markEndName;

  UserTimingSpanProcessor(this._exporter) {
    initSpanFilter();
  }

  /// A tag used to specify a custom measure name for a [api.Span]
  /// (the measure name default to [api.Span.name]).
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
  static const String devMeasureName = 'wk.dev.measure_name';

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
  String _measureName(span) =>
      '${span.attributes.get(devMeasureName) ?? span.name}${_measureSuffix(span.spanContext.spanId, span.parentSpanId)}';

  /// A suffix for the measure name that includes additional information for use
  /// when debugging.
  ///
  /// Always include the span ID as a workaround for a bug where overlapping
  /// measures with the same name are displayed incorrectly in the dev tools:
  /// https://bugs.chromium.org/p/chromium/issues/detail?id=865780
  String _measureSuffix(spanId, parentSpanId) =>
      ' - ${_spanIdDebugString(spanId)}${_parentSpanDebugString(parentSpanId)}';

  /// A short string representation of the referenced spans (including the
  /// parentSpanId) for debugging purposes.
  String _parentSpanDebugString(parentSpanId) {
    return parentSpanId == null
        ? ''
        : '[childOf:${getSpanIdDebugString(parentSpanId)}]';
  }

  /// A short string representation of the span ID, for debugging purposes.
  String _spanIdDebugString(spanId) => getSpanIdDebugString(spanId);

  static const int _truncationLength = 3;
  // Fancy version of for `parseInt('0x' + 'f' * _truncationLength)`
  final int _truncationMask = pow(16, _truncationLength) - 1;

  /// Returns the last 3 hexadecimal digits of [int64], padded with 0s.
  ///
  /// 3 digits is a good balance of preventing collisions and not being too long
  /// when used in a measure name.
  String _truncatedInt64(Int64 int64) => (int64 & _truncationMask)
      .toHexString()
      .toLowerCase()
      .padLeft(_truncationLength, '0');

  /// Returns a string representation of [spanId] for use in debugging,
  /// truncated to 3 characters.
  String getSpanIdDebugString(dynamic spanId) {
    if (spanId is Int64) return _truncatedInt64(spanId);

    const maxLength = 3;
    final idString = spanId.toString();
    // Take up to the last `maxLength` characters of the idString
    return idString.substring(max(idString.length - maxLength, 0));
  }

  @override
  void forceFlush() {}

  @override
  void onEnd(api.Span span) {
    if (_isShutdown) {
      return;
    }

    if (MarkMeasureFilter.doesSpanPassFilters(span)) {
      window.performance.mark(_markEndName);
      window.performance.measure(
          _measureName(span as sdk.Span), _markStartName, _markEndName);
    }

    _exporter.export([span]);
  }

  @override
  void onStart(api.Span span, api.Context context) {
    if (MarkMeasureFilter.doesSpanPassFilters(span)) {
      _markPrefix = '${span.name}[${span.spanContext.spanId}]';
      _markStartName = '$_markPrefix.start';
      _markEndName = '$_markPrefix.end';
      window.performance.mark(_markStartName);
    }
  }

  @override
  void shutdown() {
    forceFlush();
    _isShutdown = true;
    _exporter.shutdown();
  }
}
