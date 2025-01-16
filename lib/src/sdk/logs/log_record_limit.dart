// https://opentelemetry.io/docs/specs/otel/logs/sdk/#logrecord-limits
abstract class LogRecordLimits {
  // https://opentelemetry.io/docs/specs/otel/common/#configurable-parameters
  factory LogRecordLimits({
    int attributeCountLimit = 128,
    int attributeValueLengthLimit = -1,
  }) =>
      _LogRecordLimits(
        attributeCountLimit: attributeCountLimit,
        attributeValueLengthLimit: attributeValueLengthLimit,
      );

  int get attributeCountLimit;

  int get attributeValueLengthLimit;
}

class _LogRecordLimits implements LogRecordLimits {
  final int _attributeCountLimit;
  final int _attributeValueLengthLimit;

  _LogRecordLimits({
    int attributeCountLimit = 128,
    int attributeValueLengthLimit = -1,
  })  : _attributeCountLimit = attributeCountLimit,
        _attributeValueLengthLimit = attributeValueLengthLimit;

  @override
  int get attributeCountLimit => _attributeCountLimit;

  @override
  int get attributeValueLengthLimit => _attributeValueLengthLimit;
}
