import 'package:cuteshrew/core/data/datasource/remote/http_constants.dart';
import 'package:cuteshrew/core/data/datasource/remote/remote_datasource.dart';

class CuteShrewRemoteDataSource extends RemoteDataSource {
  CuteShrewRemoteDataSource()
      : super(
            baseUrl: HttpConstants.cuteshrewBaseUrl,
            scheme: HttpConstants.cuteshrewScheme);

  @override
  Uri urlCreate({required String endpoint, Map<String, dynamic>? queryParams}) {
    return Uri(
        host: baseUrl,
        scheme: scheme,
        path: HttpConstants.endpointApi + endpoint,
        queryParameters: queryParams);
  }
}
