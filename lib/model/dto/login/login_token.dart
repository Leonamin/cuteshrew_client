part of '../login_dto.dart';

class LoginToken extends Equatable {
  final String accessToken;
  final String tokenType;
  final int expires;

  const LoginToken({
    required this.accessToken,
    required this.tokenType,
    required this.expires,
  });

  @override
  List<Object?> get props => [
        accessToken,
        tokenType,
        expires,
      ];
}
