class CustomException {
  final CustomExceptionType type;
  final Object exception;
  final StackTrace stackTrace;
  final String msg;

  CustomException({
    required this.type,
    required this.exception,
    required this.stackTrace,
    required this.msg,
  });
}

enum CustomExceptionType {
  api,
  type,
  unknown,
  error,
}
