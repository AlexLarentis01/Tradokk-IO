class TimeoutError extends Error{
   final Object? message;

  /// Creates an assertion error with the provided [message].
  TimeoutError([this.message]);

  String toString() {
    if (message != null) {
      return "Lobby Service Timeout: $stackTrace";
    }
    return "Lobby Service Timeout";
  }
}