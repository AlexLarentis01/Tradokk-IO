class NoOpenChannelError extends Error{
   final Object? message;

  /// Creates an assertion error with the provided [message].
  NoOpenChannelError([this.message]);

  String toString() {
    if (message != null) {
      return "No open Channel: ${Error.safeToString(message)}";
    }
    return "No open Channel";
  }
}