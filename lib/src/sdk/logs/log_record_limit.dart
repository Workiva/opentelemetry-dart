// https://opentelemetry.io/docs/specs/otel/logs/sdk/#logrecord-limits
abstract class LogRecordLimits {
  // https://opentelemetry.io/docs/specs/otel/common/#configurable-parameters

  int get attributeCountLimit;

  int get attributeValueLengthLimit;
}

class LogRecordLimitsImpl implements LogRecordLimits {
  final int _attributeCountLimit;
  final int _attributeValueLengthLimit;

  const LogRecordLimitsImpl({
    int attributeCountLimit = 128,
    int attributeValueLengthLimit = -1,
  })  : _attributeCountLimit = attributeCountLimit,
        _attributeValueLengthLimit = attributeValueLengthLimit;

  @override
  int get attributeCountLimit => _attributeCountLimit;

  @override
  int get attributeValueLengthLimit => _attributeValueLengthLimit;
}
