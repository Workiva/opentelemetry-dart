import 'package:meta/meta.dart';
import '../../../../../api.dart' as api;

/// The filter preference to use.
///
/// When using [allFilters], an empty rules list is always true.
///
/// When using [anyFilters], an empty rules list is always false.
///
/// Defaults to [allFilters].
enum MarkMeasureFilterMode {
  /// Spans that match any filter will be shown
  anyFilters,

  /// Spans that match all filters will be shown
  allFilters,
}

/// Returns true if a span matches the rule.
typedef MarkMeasureFilterRule = bool Function(api.Span span);

/// A global class which can be configured to filter which spans appear in
/// user timing metrics.
class MarkMeasureFilter {
  MarkMeasureFilterMode _filterMode = MarkMeasureFilterMode.allFilters;

  MarkMeasureFilter._();

  /// The [MarkMeasureFilterMode] currently being applied.
  static MarkMeasureFilterMode get filterMode => _current._filterMode;

  /// Assigns a new [MarkMeasureFilterMode].
  static set filterMode(MarkMeasureFilterMode mode) {
    _current._filterMode = mode;
  }

  /// Adds a new [MarkMeasureFilterRule] to the filter
  static void addFilter(MarkMeasureFilterRule rule) => _current._addRule(rule);

  /// Clears out all [MarkMeasureFilterRule]s.
  static void clearFilters() => _current._clearRules();

  /// Returns true if the span meets the requirements of the current [MarkMeasureFilterMode].
  static bool doesSpanPassFilters(api.Span span) =>
      _current._doesSpanPassFilters(span);

  static final MarkMeasureFilter _current = MarkMeasureFilter._();

  @visibleForTesting
  static List<MarkMeasureFilterRule> get rules => _current._rules;

  final List<MarkMeasureFilterRule> _rules = [];
  void _addRule(MarkMeasureFilterRule rule) => _rules.add(rule);
  void _clearRules() => _rules.clear();

  bool _doesSpanPassFilters(api.Span span) {
    switch (filterMode) {
      case MarkMeasureFilterMode.allFilters:
        return _doAllFiltersApplyToSpan(span);
      case MarkMeasureFilterMode.anyFilters:
        return _doAnyFiltersApplyToSpan(span);
    }

    // Not possible; just to make Analyzer happy
    return false;
  }

  bool _doAllFiltersApplyToSpan(api.Span span) =>
      _rules.every((rule) => rule(span));

  bool _doAnyFiltersApplyToSpan(api.Span span) =>
      _rules.any((rule) => rule(span));
}
