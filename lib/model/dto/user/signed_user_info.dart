part of '../user_dto.dart';

class SignedUserInfo extends Equatable {
  final UserSummaryInfo userInfo;
  final LoginToken loginToken;

  const SignedUserInfo({
    required this.userInfo,
    required this.loginToken,
  });

  @override
  List<Object?> get props => [
        userInfo,
        loginToken,
      ];
}
