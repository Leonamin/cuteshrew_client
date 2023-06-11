part of '../user_dto.dart';

class UserCreateForm extends Equatable {
  final String name;
  final String email;
  final String password;

  const UserCreateForm({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
        name,
        email,
      ];
}
