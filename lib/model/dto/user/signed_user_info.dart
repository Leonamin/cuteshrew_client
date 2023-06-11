part of '../user_dto.dart';

class SignedUserInfo extends Equatable {
  final UserSummaryInfo userInfo;
  final LoginToken loginTokenEntity;

  const SignedUserInfo({
    required this.userInfo,
    required this.loginTokenEntity,
  });

  @override
  List<Object?> get props => [
        userInfo,
        loginTokenEntity,
      ];
}
