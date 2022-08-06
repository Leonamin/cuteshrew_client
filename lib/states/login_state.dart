import 'package:cuteshrew/models/login_token.dart';
import 'package:cuteshrew/models/user_info.dart';

abstract class LoginState {
  const LoginState();

  /*
    Unauthorized
    RequestAuthorization
    Authorized
  */
  const factory LoginState.unauthorized() = UnauthorizedState;
  const factory LoginState.reqeustAuthorization() = RequestAuthorizationState;
  const factory LoginState.authorized(
      {required UserInfo userInfo,
      required TestLoginToken loginToken}) = AuthorizedState;
}

class UnauthorizedState extends LoginState {
  const UnauthorizedState() : super();
}

class RequestAuthorizationState extends LoginState {
  const RequestAuthorizationState() : super();
}

class AuthorizedState extends LoginState {
  const AuthorizedState({required this.userInfo, required this.loginToken});

  final UserInfo userInfo;
  final TestLoginToken loginToken;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuthorizedState &&
          userInfo == other.userInfo &&
          loginToken == other.loginToken);

  @override
  int get hashCode => Object.hash(userInfo, loginToken);
}
