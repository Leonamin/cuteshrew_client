import 'dart:convert';

import 'package:cuteshrew/core/data/datasource/remote/cuteshrew_remote_datasource.dart';
import 'package:cuteshrew/core/data/datasource/remote/http_constants.dart';
import 'package:cuteshrew/core/data/dto/remote/user_create_dto.dart';
import 'package:cuteshrew/core/data/dto/remote/user_dto.dart';
import 'package:http/http.dart';

class UserRemoteDataSource extends CuteShrewRemoteDataSource {
  Future<void> postSignin(UserCreateDTO user) async {
    try {
      final response = await post(HttpConstants.requestSignup,
          headers: {
            "Content-Type": "application/json",
          },
          encoding: Encoding.getByName('utf-8'),
          body: jsonEncode(user.toJson()));
      if (response.statusCode != 201) {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserDTO> getUserDetail(String userName) async {
    try {
      Response response = await get(
        HttpConstants.getUserDetail(userName),
      );
      if (response.statusCode != 200) {
        throw Exception();
      }
      return UserDTO.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } catch (e) {
      rethrow;
    }
  }
}
