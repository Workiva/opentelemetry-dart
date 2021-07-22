abstract class Status {
  StatusCode get code;

  String get message;
}

enum StatusCode {
  ok,
  unset,
  error,
}
