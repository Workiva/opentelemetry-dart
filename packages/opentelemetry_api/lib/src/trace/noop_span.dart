
import 'package:opentelemetry_api/src/trace/span_context.dart';

import 'package:opentelemetry_api/src/trace/status.dart';

import 'span.dart';

class NoopSpan implements Span {
  @override
  void addEvent(String name, {Map<String, Object> attributes, DateTime startTime}) {
    // TODO: implement addEvent
  }

  @override
  // TODO: implement context
  SpanContext get context => null;

  @override
  void end({DateTime endTime}) {
    // TODO: implement end
  }

  @override
  // TODO: implement isRecording
  bool get isRecording => null;

  @override
  void setAllAttributes(Map<String, Object> attributes) {
    // TODO: implement setAllAttributes
  }

  @override
  void setAttribute(String key, Object value) {
    // TODO: implement setAttribute
  }

  @override
  void setStatus(StatusCode code, {String description}) {
    // TODO: implement setStatus
  }

  @override
  void updateName(String name) {
    // TODO: implement updateName
  }

}
