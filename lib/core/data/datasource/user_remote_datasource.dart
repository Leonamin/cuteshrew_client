import 'dart:convert';

import 'package:cuteshrew/core/data/datasource/cuteshrew_remote_datasource.dart';
import 'package:cuteshrew/core/data/datasource/http_constants.dart';
import 'package:cuteshrew/core/data/dto/user_create_dto.dart';
import 'package:http/http.dart';

class UserRemoteDataSource extends CuteShrewRemoteDataSource {
  Future<void> postSignin(UserCreateDTO user) async {
    try {
      await post(HttpConstants.requestSignin,
          headers: {
            "Content-Type": "application/json",
          },
          encoding: Encoding.getByName('utf-8'),
          body: jsonEncode(user.toJson()));
    } catch (e) {
      rethrow;
    }
  }
}
