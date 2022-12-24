import 'package:equatable/equatable.dart';

// 로그인 요청을 보낼 때 사용하는 엔티티
class LoginRequestEntity extends Equatable {
  final String username;
  final String password;

  const LoginRequestEntity({
    required this.username,
    required this.password,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        username,
        password,
      ];
}
