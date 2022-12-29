import 'package:cuteshrew/core/domain/entity/login_token_entity.dart';
import 'package:cuteshrew/core/domain/entity/user_entity.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  /*
    Unauthorized
    RequestAuthorization
    Authorized
  */
  const factory AuthenticationState.unauthorized() = UnauthorizedState;
  const factory AuthenticationState.reqeustAuthorization() =
      RequestAuthorizationState;
  const factory AuthenticationState.authorized({
    required UserEntity userInfo,
    required LoginTokenEntity loginToken,
  }) = AuthorizedState;
}

class UnauthorizedState extends AuthenticationState {
  const UnauthorizedState() : super();

  @override
  List<Object?> get props => [];
}

class RequestAuthorizationState extends AuthenticationState {
  const RequestAuthorizationState() : super();

  @override
  List<Object?> get props => [];
}

class AuthorizedState extends AuthenticationState {
  const AuthorizedState({
    required this.userInfo,
    required this.loginToken,
  });

  final UserEntity userInfo;
  final LoginTokenEntity loginToken;

  String get userName => userInfo.name;
  String get userEmail => userInfo.email;

  @override
  List<Object?> get props => [
        userInfo,
        loginToken,
      ];
}
