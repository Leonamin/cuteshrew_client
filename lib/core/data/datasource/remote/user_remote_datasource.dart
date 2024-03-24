import 'dart:convert';

import 'package:cuteshrew/core/data/datasource/remote/cuteshrew_remote_datasource.dart';
import 'package:cuteshrew/core/data/datasource/remote/http_constants.dart';
import 'package:cuteshrew/core/data/dto/remote/user_create_dto.dart';
import 'package:cuteshrew/2_data/remote/user/user_summary_res.dart';
import 'package:http/http.dart';

class UserRemoteDataSource extends CuteShrewRemoteDataSource {
  Future<void> postSignin(UserCreateDTO user) async {
    try {
      await post(HttpConstants.requestSignup,
          headers: {
            "Content-Type": "application/json",
          },
          encoding: Encoding.getByName('utf-8'),
          body: jsonEncode(user.toJson()));
    } catch (e) {
      rethrow;
    }
  }

  Future<UserSummaryRes> getUserDetail(String userName) async {
    try {
      Response response = await get(
        HttpConstants.getUserDetail(userName),
      );
      return UserSummaryRes.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));
    } catch (e) {
      rethrow;
    }
  }
}
