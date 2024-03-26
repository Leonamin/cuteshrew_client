import 'dart:convert';

import 'package:cuteshrew/0_foundation/config/build_config.dart';
import 'package:cuteshrew/2_data/remote/posting/posting_summary_res.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart' as http;

final apiCuteShrewProvider = Provider<ApiCuteShrew>((ref) => ApiCuteShrew());

class ApiCuteShrew {
  final String _baseUrl = BuildConfig.cuteshrewUrl;
  static final ApiCuteShrew _instance = ApiCuteShrew._();

  ApiCuteShrew._();

  factory ApiCuteShrew() => _instance;

  static setQueryParam(
    Map<String, dynamic> queryParam,
    String key,
    dynamic value,
  ) {
    if (value != null) queryParam[key] = value;
  }

  // FIXME: host 예외처리 불편함
  Uri genUrl(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) =>
      Uri(
        scheme: _baseUrl.startsWith('https') ? 'https' : 'http',
        host: _baseUrl.replaceAll(RegExp(r'^https?://'), ''),
        path: path,
        queryParameters: queryParameters,
      );

  // TODO: 아예 최신만 가져오는거 API 없음
  Future<List<PostingSummaryRes>> getLatestPostings() async {
    return getPostingsOnCommunity('general');
  }

  Future<List<PostingSummaryRes>> getPostingsOnCommunity(
    String communityName,
  ) async {
    print('asdads');
    try {
      print(genUrl(
        '/apiv2/posting/details',
        queryParameters: {
          'community_name': communityName,
        },
      ));
    } catch (e) {
      print(e);
    }

    final response = await http.get(
      genUrl(
        '/apiv2/posting/details',
        queryParameters: {
          'community_name': communityName,
        },
      ),
    );
    final decodedData = json.decode(utf8.decode(response.bodyBytes));
    return [for (final e in decodedData) PostingSummaryRes.fromJson(e)];
  }
}
