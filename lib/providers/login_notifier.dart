import 'package:cuteshrew/api/cuteshrew_api_client.dart';
import 'package:cuteshrew/models/user_info.dart';
import 'package:cuteshrew/states/login_state.dart';
import 'package:flutter/widgets.dart';

class LoginNotifier extends ValueNotifier<LoginState> {
  LoginNotifier({required this.api}) : super(LoginState.unauthorized());

  final CuteshrewApiClient api;

  Future<void> login(id, password) async {
    if (value is UnauthorizedState) {
      value = LoginState.reqeustAuthorization();
      try {
        final result = await api.postLogin(id, password);
        if (result != null) {
          value = LoginState.authorized(
              userInfo: UserInfo(email: id, name: id), loginToken: result);
        } else {
          value = LoginState.unauthorized();
        }
      } catch (error) {
        value = LoginState.unauthorized();
      }
    }
  }

  Future<void> logout() async {
    value = LoginState.unauthorized();
  }
}
