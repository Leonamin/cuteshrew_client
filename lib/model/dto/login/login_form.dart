part of '../login_dto.dart';

class LoginForm extends Equatable {
  final String username;
  final String password;

  const LoginForm({
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [
        username,
        password,
      ];
}
