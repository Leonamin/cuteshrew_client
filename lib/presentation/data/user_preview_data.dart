import 'package:cuteshrew/core/domain/entity/user_entity.dart';

// 기본 유저 정보를 상속 받고 최소 정보만 담긴 데이터
class UserPreviewData extends UserEntity {
  const UserPreviewData({
    required String name,
    required String email,
  }) : super(name: name, email: email);
}
