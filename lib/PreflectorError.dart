class PreflectorError extends Error {
  final String message;
  final String? code;

  PreflectorError(this.message, {this.code});

  @override
  String toString() => message;
}
