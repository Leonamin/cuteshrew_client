import 'package:cuteshrew/core/domain/entity/signed_user_entity.dart';
import 'package:cuteshrew/core/domain/entity/user_preview_entity.dart';
import 'package:cuteshrew/core/domain/usecase/login_usecase.dart';
import 'package:cuteshrew/core/resources/failure.dart';
import 'package:cuteshrew/di/navigation_service.dart';
import 'package:cuteshrew/di/service_locator.dart';
import 'package:cuteshrew/presentation/config/route/routes.dart';
import 'package:cuteshrew/presentation/providers/authentication/authentication_state.dart';
import 'package:flutter/widgets.dart';

class AuthenticationProvider extends ValueNotifier<AuthenticationState> {
  // TODO 나중에 바꾸자
  late LoginUseCase _loginUseCase;
  final NavigationService _navigationService = locator<NavigationService>();

  AuthenticationProvider({required LoginUseCase loginUseCase})
      : super(const AuthenticationState.unauthorized()) {
    _loginUseCase = loginUseCase;
  }

  Future<void> initializeToken() async {
    final result = await _loginUseCase.getSignedUserFromLocal();
    result.fold((Failure failure) {
      value = AuthenticationState.unauthorized();
    }, (data) {
      if (data.loginTokenEntity.expires * 1000 >
          DateTime.now().millisecondsSinceEpoch) {
        value = AuthenticationState.authorized(
          userInfo: data.userInfo,
          loginToken: data.loginTokenEntity,
        );
      }
    });
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
        final saveResult = _loginUseCase.saveSignedUserToLocal(
            signedUserEntity: SignedUserEntity(
                userInfo: UserPreviewEntity(name: id, email: id),
                loginTokenEntity: data));
        // saveResult.fold((Failure failure) {}, (data) {});
        value = AuthenticationState.authorized(
          userInfo: UserPreviewEntity(
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
      String id = (value as AuthorizedState).userName;
      _loginUseCase.deleteSignedUserFromLocal();
      value = const AuthenticationState.unauthorized();
    }
  }

  // 이걸 한이유
  // 잘못된 설계로 인해 로그인 페이지 스택이 쌓여서 2개 이상이 되면
  // 알림이 스택에 쌓인 로그인 페이지만큼 발생한다.
  // 그래서 그냥 싸그리 지우고 홈으로 이동시키는게 낫다고 판단된다.
  void navigateAfterSiginIn() {
    _navigationService.navigateAndRemoveUntil(Routes.HomePageRoute);
  }
}
