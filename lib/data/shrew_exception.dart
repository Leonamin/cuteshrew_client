import 'package:cuteshrew/common/logger.dart';
import 'package:dio/dio.dart';

class LokksExceptionUtil {
  static void logging(ShrewException e, {int upperStackCnt = 0}) {
    switch (e.type) {
      case ShrewExceptionType.api:
        if (e.exception is CustomDioException) {
          final customDioException = e.exception as CustomDioException;

          if (customDioException.response?.statusCode == 401 ||
              customDioException.type == DioExceptionType.cancel ||
              customDioException.type == DioExceptionType.connectionTimeout) {
            logger.w('', customDioException, e.stackTrace);
          } else {
            logger.e('', customDioException, e.stackTrace);
          }
        }
        break;
      case ShrewExceptionType.handled:
        logger.w(e.msg, e.exception, e.stackTrace);
        break;
      case ShrewExceptionType.warn:
        logger.w(e.msg, e.exception, e.stackTrace);
        break;
      case ShrewExceptionType.unknown:
        logger.e(e.msg, e.exception, e.stackTrace);
        break;
    }
  }

  static bool isShowToastFromDioException(ShrewException e) {
    if (e.exception is CustomDioException) {
      final customDioException = e.exception as CustomDioException;
      return customDioException.response?.statusCode != 401 &&
          customDioException.type != DioExceptionType.cancel;
    }

    return true;
  }
}

class ShrewException {
  final ShrewExceptionType type;
  final Object exception;
  final StackTrace stackTrace;
  final String msg;

  ShrewException({
    required this.type,
    required this.exception,
    required this.stackTrace,
    required this.msg,
  });
}

enum ShrewExceptionType { api, handled, warn, unknown }

extension ExceptionTypeExt on ShrewExceptionType {
  bool get isHandled => this == ShrewExceptionType.handled;
  bool get isUnknown => this == ShrewExceptionType.unknown;
  bool get isWarn => this == ShrewExceptionType.warn;
  bool get isApi => this == ShrewExceptionType.api;
}

class CustomDioException extends DioException {
  CustomDioException({
    required DioException e,
  })  : logMsg = _getDioExceptionMsg(e),
        super(
          requestOptions: e.requestOptions,
          error: e.error,
          response: e.response,
          type: e.type,
        );
  final String logMsg;

  static String _getDioExceptionMsg(DioException dioError) =>
      '\t[${dioError.requestOptions.method}] path = ${dioError.requestOptions.path}\n\tqueryParam = ${dioError.requestOptions.queryParameters}\n\trequest body = ${dioError.requestOptions.data}\n\tresponse = ${dioError.response}\n\theaders = ${dioError.requestOptions.headers}';

  @override
  String toString() {
    var msg = 'DioException [$type]: $message';
    msg += '\n$logMsg';
    if (error is Error) {
      msg += '\n${(error as Error).stackTrace}';
    }
    msg += '\nSource stack:\n$stackTrace';
    return msg;
  }
}
