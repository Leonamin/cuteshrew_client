import 'package:equatable/equatable.dart';

// 유저 생성 정보를 담은 엔티티
class UserCreateEntity extends Equatable {
  final String name;
  final String email;
  final String password;

  const UserCreateEntity({
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
