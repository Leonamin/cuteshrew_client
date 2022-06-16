import 'package:cuteshrew/model/models.dart';
import 'package:flutter/widgets.dart';

class LoginProvider with ChangeNotifier {
  String _nickname = "";
  String get userNickname => _nickname;
  LoginToken? _loginToken = null;
  LoginToken? get loginToken => _loginToken;

  // TODO 유저 클래스 + 토큰 혹은 유저 안에 토큰 넣자
  void setUserId(String name) {
    _nickname = name;
    notifyListeners();
  }

  void deleteUserId() {
    _nickname = "";
    notifyListeners();
  }

  void setToken(LoginToken token) {
    _loginToken = token;
    notifyListeners();
  }

  void removeToken() {
    _loginToken = null;
    notifyListeners();
  }
}
