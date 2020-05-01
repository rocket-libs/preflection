class PreflectorError extends Error{
  final String message;

  PreflectorError(this.message);

  @override
  String toString() => message;
}