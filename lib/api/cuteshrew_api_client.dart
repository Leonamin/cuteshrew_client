import 'dart:convert';

import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/models/comment_create.dart';
import 'package:cuteshrew/models/comment_detail.dart';
import 'package:cuteshrew/models/login_token.dart';
import 'package:cuteshrew/models/post_detail.dart';
import 'package:cuteshrew/api/cuteshrew_api_constants.dart';
import 'package:http/http.dart';

class CuteshrewApiClient {
  const CuteshrewApiClient();

  Map<String, dynamic> mapCodeAndData(int c, d) => {'code': c, 'data': d};

  Future<List<Community>?> getMainPage() async {
    Response response = await get(CuteShrewApiConstants.getMainPage);

    if (response.statusCode == 200) {
      return [
        for (final e in json.decode(utf8.decode(response.bodyBytes)))
          Community.fromJson(e),
      ];
    }
    return null;
  }

  Future<Map<String, dynamic>> getPosting(String communityName, int postId,
      [String? password]) async {
    final response = await get(
        CuteShrewApiConstants.getPosting(communityName, postId, password));

    if (response.statusCode == 200) {
      var post =
          PostDetail.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      return mapCodeAndData(response.statusCode, post);
    } else {
      return mapCodeAndData(response.statusCode, null);
    }
  }

  Future<LoginToken?> postLogin(String nickname, String password) async {
    Map data = {'username': nickname, 'password': password};
    String encodedBody = data.keys.map((key) => "$key=${data[key]}").join("&");

    final response = await post(CuteShrewApiConstants.requestLogin,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        encoding: Encoding.getByName('utf-8'),
        body: encodedBody);

    if (response.statusCode == 200) {
      return LoginToken.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    }
    return null;
  }

  Future<void> postSignin(UserCreate user) async {
    final response = await post(CuteShrewApiConstants.requestSignin,
        headers: {
          "Content-Type": "application/json",
        },
        encoding: Encoding.getByName('utf-8'),
        body: jsonEncode(user.toMap()));

    if (response.statusCode != 200) {
      throw Exception(response);
    }
  }

  Future<void> uploadPosting(
      String communityName, LoginToken token, PostCreate posting) async {
    final response =
        await post(CuteShrewApiConstants.uploadPosting(communityName),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "${token.tokenType} ${token.accessToken}"
            },
            encoding: Encoding.getByName('utf-8'),
            body: jsonEncode(posting.toJson()));
    if (response.statusCode != 201) {
      throw Exception(response);
    }
  }

  Future<void> updatePosting(String communityName, LoginToken token, int postId,
      PostCreate posting) async {
    final response =
        await put(CuteShrewApiConstants.updatePosting(communityName, postId),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "${token.tokenType} ${token.accessToken}"
            },
            encoding: Encoding.getByName('utf-8'),
            body: jsonEncode(posting.toJson()));
    if (response.statusCode != 202) {
      throw Exception(response);
    }
  }

  Future<bool> deletePosting(
      String communityName, LoginToken token, int postId) async {
    final response = await delete(
      CuteShrewApiConstants.deletePosting(communityName, postId),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "${token.tokenType} ${token.accessToken}"
      },
    );

    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }

  Future<Community?> getCommunity(communityName, pageNum, postingCount) async {
    final response = await get(CuteShrewApiConstants.getCommunity(
        communityName, pageNum, postingCount));

    if (response.statusCode == 200) {
      return Community.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    }
    return null;
  }

  Future<List<CommentDetail>?> getCommentPage(
      String communityName, int postId, int pageNum, int commentCount) async {
    final response = await get(CuteShrewApiConstants.getCommentList(
        communityName, postId, pageNum, commentCount));

    if (response.statusCode == 200) {
      return [
        for (final e in json.decode(utf8.decode(response.bodyBytes)))
          CommentDetail.fromJson(e),
      ];
    }
    return null;
  }

  Future<void> uploadComment(LoginToken token, String communityName, int postId,
      CommentCreate comment) async {
    final response =
        await post(CuteShrewApiConstants.uploadComment(communityName, postId),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "${token.tokenType} ${token.accessToken}",
            },
            encoding: Encoding.getByName('utf-8'),
            body: jsonEncode(comment.toJson()));

    if (response.statusCode != 201) {
      throw Exception(response);
    }
  }

  Future<void> uploadReply(LoginToken token, String communityName, int postId,
      int groupId, CommentCreate comment) async {
    final response = await post(
        CuteShrewApiConstants.uploadReply(communityName, postId, groupId),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "${token.tokenType} ${token.accessToken}",
        },
        encoding: Encoding.getByName('utf-8'),
        body: jsonEncode(comment.toJson()));

    if (response.statusCode != 201) {
      throw Exception(response);
    }
  }

  Future<void> updateComment(LoginToken token, String communityName, int postId,
      int commentId, CommentCreate comment) async {
    final response = await post(
        CuteShrewApiConstants.basicCommentUrl(communityName, postId, commentId),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "${token.tokenType} ${token.accessToken}",
        },
        encoding: Encoding.getByName('utf-8'),
        body: jsonEncode(comment.toJson()));

    if (response.statusCode != 201) {
      throw Exception(response);
    }
  }

  Future<void> deleteComment(
      LoginToken token, String communityName, int postId, int commentId) async {
    final response = await delete(
      CuteShrewApiConstants.basicCommentUrl(communityName, postId, commentId),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "${token.tokenType} ${token.accessToken}",
      },
    );

    if (response.statusCode != 204) {
      throw Exception(response);
    }
  }

  Future<Map<String, dynamic>> searchPostings(
      [int? userId,
      String? userName,
      int? startPostId,
      int? loadPageNum]) async {
    final response = await get(CuteShrewApiConstants.searchPostings(
        userId, userName, startPostId, loadPageNum));
    if (response.statusCode == 200) {
      var post = ResponseSearchPostings.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));
      return mapCodeAndData(response.statusCode, post);
    } else {
      return mapCodeAndData(response.statusCode, null);
    }
  }

  Future<Map<String, dynamic>> searchComments(
      [int? userId,
      String? userName,
      int? startCommentId,
      int? loadPageNum]) async {
    final response = await get(CuteShrewApiConstants.searchComments(
        userId, userName, startCommentId, loadPageNum));
    if (response.statusCode == 200) {
      var post = ResponseSearchComments.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));
      return mapCodeAndData(response.statusCode, post);
    } else {
      return mapCodeAndData(response.statusCode, null);
    }
  }
}
