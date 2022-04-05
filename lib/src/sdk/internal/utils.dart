class Utils {
  ///Check argument
  // ignore: avoid_positional_boolean_parameters
  static void checkArgument(bool isValid, String errorMessage) {
    if (!isValid) throw ArgumentError(errorMessage);
  }
}
