import 'package:equatable/equatable.dart';

// 로그인 성공 후 받는 토큰 정보에 대한 엔티티
class LoginTokenEntity extends Equatable {
  final String accessToken;
  final String tokenType;
  final int expires;

  const LoginTokenEntity(
      {required this.accessToken,
      required this.tokenType,
      required this.expires});

  @override
  List<Object?> get props => [
        accessToken,
        tokenType,
        expires,
      ];
}
