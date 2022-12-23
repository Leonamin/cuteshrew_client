import 'package:cuteshrew/core/data/datasource/remote_datasource.dart';
import 'package:cuteshrew/core/resources/constants.dart';

class CuteShrewRemoteDataSource extends RemoteDataSource {
  CuteShrewRemoteDataSource()
      : super(
            baseUrl: Constants.cuteshrewBaseUrl,
            scheme: Constants.cuteshrewScheme);

  @override
  Uri urlCreate({required String endpoint, Map<String, dynamic>? queryParams}) {
    return Uri(
        host: baseUrl,
        scheme: scheme,
        path: Constants.apiUrl + endpoint,
        queryParameters: queryParams);
  }
}
