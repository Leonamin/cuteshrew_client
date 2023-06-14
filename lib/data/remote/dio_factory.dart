import 'package:cuteshrew/common/build_config.dart';
import 'package:cuteshrew/common/logger.dart';
import 'package:dio/dio.dart';

class DioFactory {
  static int defulatTimeout = 10000;
  static int multipartTimeout = 600000;
  static int invalidTokenStatusCode = 401;
  static int successStatusCode = 200;
  static int deviceIdNotMatchCode = 10003;
  static final LogInterceptor _logInterceptor = LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (obj) => logger.i(obj.toString()));

  static Dio getDioClientForCuteShrew() {
    var dio = Dio();
    return dio
      ..options.baseUrl = BuildConfig.cuteshrewApiAddress
      ..options.connectTimeout = Duration(microseconds: defulatTimeout)
      ..options.receiveTimeout = Duration(microseconds: defulatTimeout)
      ..options.sendTimeout = Duration(microseconds: defulatTimeout)
      ..options.headers['Accept'] = 'application/json'
      ..interceptors.add(_logInterceptor);
  }
}
