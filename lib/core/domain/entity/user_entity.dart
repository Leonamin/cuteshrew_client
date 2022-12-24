import 'package:equatable/equatable.dart';

// 다른 엔티티에서 의존성 문제를 회피하기 위해 기본 유저 정보만 담은 엔티티
abstract class UserEntity extends Equatable {
  final String name;
  final String email;
  const UserEntity({required this.name, required this.email});

  @override
  List<Object?> get props => [
        name,
        email,
      ];
}
