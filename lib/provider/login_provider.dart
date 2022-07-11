import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/network/http_service.dart';
import 'package:flutter/widgets.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class LoginProvider with ChangeNotifier {
  String? _nickname;
  LoginToken? _loginToken;
  Status _status = Status.Uninitialized;
  final HttpService _httpService = HttpService();

  String? get userNickname => _nickname;
  LoginToken? get loginToken => _loginToken;
  Status get status => _status;

  // TODO 유저 클래스 + 토큰 혹은 유저 안에 토큰 넣자
  void setUserId(String name) {
    _nickname = name;
    notifyListeners();
  }

  void deleteUserId() {
    _nickname = null;
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

  Future<bool> login(String id, String password) async {
    // TODO login 성공 체크 변경
    try {
      var result = await _httpService.postLogin(id, password);
      _nickname = id;
      _loginToken = result;
      _status = Status.Authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  bool logout() {
    _nickname = null;
    _loginToken = null;
    _status = Status.Unauthenticated;
    notifyListeners();

    return true;
  }
}
