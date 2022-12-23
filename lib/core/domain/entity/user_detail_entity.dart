import 'package:cuteshrew/core/domain/entity/user_entity.dart';

// 기본 유저 정보를 상속 받고 자세한 유저 정보를 필요로 하는 엔티티
class UserDetailEntity extends UserEntity {
  const UserDetailEntity({required String name, required String email})
      : super(name: name, email: email);
}
