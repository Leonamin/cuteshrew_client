import 'dart:convert';

import 'package:cuteshrew/core/data/datasource/remote/cuteshrew_remote_datasource.dart';
import 'package:cuteshrew/core/data/datasource/remote/http_constants.dart';
import 'package:cuteshrew/core/data/dto/remote/login_token_dto.dart';
import 'package:cuteshrew/core/data/dto/remote/posting_create_dto.dart';
import 'package:cuteshrew/core/data/dto/remote/posting_dto.dart';
import 'package:http/http.dart';

class PostingRemoteDataSource extends CuteShrewRemoteDataSource {
  Future<PostingDTO> getPosting(
    String communityName,
    int postId, [
    String? password,
  ]) async {
    try {
      final response =
          await get(HttpConstants.getPosting(communityName, postId, password));
      // TODO 응답 코드 예외 세분화 성공/비밀번호 필요/게시글 없음
      if (response.statusCode != 200) {
        throw Exception();
      }
      return PostingDTO.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } catch (e) {
      rethrow;
    }
  }

  // FIXME 서버 바꿀 떄 반드시 바꾸길 바란다.
  Future<List<PostingDTO>> getPostings(
    String communityName,
    int pageNum,
    int postingCount,
  ) async {
    try {
      final response = await get(
          HttpConstants.getCommunityPage(communityName, pageNum, postingCount));
      if (response.statusCode != 200) {
        throw Exception();
      }
      // FIXME 서버 바꿀 때 까지 임시로
      final decodedData = json.decode(utf8.decode(response.bodyBytes));
      if (decodedData['posting_list'] == null) {
        return [for (final e in decodedData) PostingDTO.fromJson(e)];
      } else {
        return [
          for (final e in decodedData['posting_list']) PostingDTO.fromJson(e)
        ];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> uploadPosting(
    String communityName,
    LoginTokenDTO token,
    PostingCreateDTO posting,
  ) async {
    try {
      final response = await post(HttpConstants.uploadPosting(communityName),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "${token.tokenType} ${token.accessToken}"
          },
          encoding: Encoding.getByName('utf-8'),
          body: jsonEncode(posting.toJson()));
      if (response.statusCode != 201) {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updatePosting(
    String communityName,
    int postId,
    LoginTokenDTO token,
    PostingCreateDTO posting,
  ) async {
    try {
      final response =
          await put(HttpConstants.updatePosting(communityName, postId),
              headers: {
                "Content-Type": "application/json",
                "Authorization": "${token.tokenType} ${token.accessToken}"
              },
              encoding: Encoding.getByName('utf-8'),
              body: jsonEncode(posting.toJson()));
      if (response.statusCode != 202) {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deletePosting(
    String communityName,
    int postId,
    LoginTokenDTO token,
  ) async {
    try {
      final response = await delete(
        HttpConstants.deletePosting(communityName, postId),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "${token.tokenType} ${token.accessToken}"
        },
      );
      if (response.statusCode != 204) {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }

  // TODO 나중에 검색 쪽으로 분리 될 수 있다.
  // FIXME 서버 바꿀 때 임시로
  Future<List<PostingDTO>> searchPostings([
    String? userName,
    int? startPostId,
    int? loadPageNum,
  ]) async {
    try {
      final response = await get(HttpConstants.searchPostings(
          null, userName, startPostId, loadPageNum));
      if (response.statusCode != 200) {
        throw Exception();
      }
      // FIXME 서버 바꿀 때 까지 임시로
      final decodedData = json.decode(utf8.decode(response.bodyBytes));
      return [for (final e in decodedData) PostingDTO.fromJson(e)];
      // if (decodedData['postings'] == null) {
      //   return [for (final e in decodedData) PostingDTO.fromJson(e)];
      // } else {
      //   return [
      //     for (final e in decodedData['postings']) PostingDTO.fromJson(e)
      //   ];
      // }
    } catch (e) {
      rethrow;
    }
  }
}
