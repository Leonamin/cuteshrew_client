abstract class RemoteDataSource {
  final String baseUrl;
  final String scheme;

  RemoteDataSource({required this.baseUrl, required this.scheme});

  Uri urlCreate({required String endpoint, Map<String, dynamic>? queryParams});
}
