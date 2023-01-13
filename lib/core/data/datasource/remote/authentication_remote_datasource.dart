import 'dart:convert';
import 'package:cuteshrew/core/data/datasource/remote/cuteshrew_remote_datasource.dart';
import 'package:cuteshrew/core/data/datasource/remote/http_constants.dart';
import 'package:cuteshrew/core/data/dto/remote/login_token_dto.dart';
import 'package:http/http.dart';

class AuthenticationRemoteDataSource extends CuteShrewRemoteDataSource {
  // FIXME 이게 보안상으로 위배되지 않는 행위일까?
  Future<LoginTokenDTO> postLogin(String nickname, String password) async {
    Map data = {'username': nickname, 'password': password};
    String encodedBody = data.keys.map((key) => "$key=${data[key]}").join("&");

    try {
      final response = await post(HttpConstants.requestLogin,
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
          encoding: Encoding.getByName('utf-8'),
          body: encodedBody);
      if (response.statusCode != 200) {
        throw Exception();
      }
      return LoginTokenDTO.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));
    } catch (e) {
      rethrow;
    }
  }
}
