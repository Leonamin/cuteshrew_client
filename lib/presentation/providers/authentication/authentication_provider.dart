import 'package:cuteshrew/core/domain/entity/user_detail_entity.dart';
import 'package:cuteshrew/core/domain/usecase/login_usecase.dart';
import 'package:cuteshrew/core/resources/failure.dart';
import 'package:cuteshrew/presentation/providers/authentication/authentication_state.dart';
import 'package:flutter/widgets.dart';

class AuthenticationProvider extends ValueNotifier<AuthenticationState> {
  // TODO 나중에 바꾸자
  late LoginUseCase _loginUseCase;

  AuthenticationProvider({required LoginUseCase loginUseCase})
      : super(const AuthenticationState.unauthorized()) {
    _loginUseCase = loginUseCase;
  }

  Future<void> login(String id, String password) async {
    if (value is AuthorizedState) {
      await logout();
    }

    if (value is UnauthorizedState) {
      value = const AuthenticationState.reqeustAuthorization();

      final result = await _loginUseCase(id, password);

      result.fold((Failure failure) {
        value = const AuthenticationState.unauthorized();
      }, (data) {
        value = AuthenticationState.authorized(
          userInfo: UserDetailEntity(
            email: id,
            name: id,
          ),
          loginToken: data,
        );
      });
    }
  }

  Future<void> logout() async {
    // TODO 나중에 여기서 로컬에 저장된 값을 지우지 않을까
    if (value is AuthorizedState) {
      value = const AuthenticationState.unauthorized();
    }
  }
}
