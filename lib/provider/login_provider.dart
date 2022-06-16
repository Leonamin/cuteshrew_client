import 'package:flutter/widgets.dart';

class LoginProvider with ChangeNotifier {
  String _nickname = "";
  String get userNickname => _nickname;
  String _accessToken = "";
  String get accessToken => _accessToken;

  // TODO 유저 클래스 + 토큰 혹은 유저 안에 토큰 넣자
  void setUserId(String name) {
    _nickname = name;
    notifyListeners();
  }

  void deleteUserId() {
    _nickname = "";
    notifyListeners();
  }

  void setToken(String token) {
    _accessToken = token;
    notifyListeners();
  }

  void removeToken() {
    _accessToken = "";
    notifyListeners();
  }
}
