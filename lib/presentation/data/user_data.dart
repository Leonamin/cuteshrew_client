import 'package:equatable/equatable.dart';

// 프레젠테이션 계층에서 사용할 유저 데이터 기본 구조
abstract class UserData extends Equatable {
  final String name;
  final String email;
  const UserData({required this.name, required this.email});

  @override
  List<Object?> get props => [
        name,
        email,
      ];
}
