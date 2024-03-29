import 'dart:convert';
import 'package:cuteshrew/core/data/datasource/remote/cuteshrew_remote_datasource.dart';
import 'package:cuteshrew/core/data/datasource/remote/http_constants.dart';
import 'package:cuteshrew/core/data/dto/remote/comment_create_dto.dart';
import 'package:cuteshrew/core/data/dto/remote/comment_dto.dart';
import 'package:cuteshrew/core/data/dto/remote/login_token_dto.dart';
import 'package:http/http.dart';

class CommentRemoteDataSource extends CuteShrewRemoteDataSource {
  // TODO 나중에 커뮤니티이름 부분이 없어질 수 있다.
  Future<List<CommentDTO>> getCommentPage(
      String communityName, int postId, int pageNum, int commentCount) async {
    try {
      final response = await get(HttpConstants.getCommentList(
          communityName, postId, pageNum, commentCount));
      return [
        for (final e in json.decode(utf8.decode(response.bodyBytes)))
          CommentDTO.fromJson(e),
      ];
    } catch (e) {
      rethrow;
    }
  }

  // TODO 나중에 커뮤니티이름 부분이 없어질 수 있다.
  Future<void> uploadComment(String communityName, int postId,
      LoginTokenDTO token, CommentCreateDTO comment) async {
    try {
      await post(HttpConstants.uploadComment(communityName, postId),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "${token.tokenType} ${token.accessToken}",
          },
          encoding: Encoding.getByName('utf-8'),
          body: jsonEncode(comment.toJson()));
    } catch (e) {
      rethrow;
    }
  }

  // TODO 나중에 커뮤니티이름 부분이 없어질 수 있다.
  Future<void> updateComment(String communityName, int postId, int commentId,
      LoginTokenDTO token, CommentCreateDTO comment) async {
    try {
      await post(
          HttpConstants.basicCommentUrl(communityName, postId, commentId),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "${token.tokenType} ${token.accessToken}",
          },
          encoding: Encoding.getByName('utf-8'),
          body: jsonEncode(comment.toJson()));
    } catch (e) {
      rethrow;
    }
  }

  // TODO 나중에 커뮤니티이름 부분이 없어질 수 있다.
  Future<void> deleteComment(String communityName, int postId, int commentId,
      LoginTokenDTO token) async {
    try {
      await delete(
        HttpConstants.basicCommentUrl(communityName, postId, commentId),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "${token.tokenType} ${token.accessToken}",
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  // TODO 나중에 검색 쪽으로 분리 될 수 있다.
  // FIXME 서버 바꿀 때 임시로
  Future<List<CommentDTO>> searchComments([
    String? userName,
    int? startId,
    int? loadPageNum,
  ]) async {
    try {
      final response = await get(
          HttpConstants.searchComments(null, userName, startId, loadPageNum));

      // FIXME 서버 바꿀 때 까지 임시로
      final decodedData = json.decode(utf8.decode(response.bodyBytes));
      return [for (final e in decodedData) CommentDTO.fromJson(e)];
      // 이거 null이면 expected int but string 뜸
      // if (decodedData['comments'] == null) {
      //   return [for (final e in decodedData) CommentDTO.fromJson(e)];
      // } else {
      //   return [
      //     for (final e in decodedData['comments']) CommentDTO.fromJson(e)
      //   ];
      // }
    } catch (e) {
      rethrow;
    }
  }
}
