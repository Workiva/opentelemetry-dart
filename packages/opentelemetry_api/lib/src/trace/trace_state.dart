abstract class TraceState {
  TraceState get(String key);

  TraceState set(String key, String value);

  TraceState unset(String key);

  String serialize();
}
