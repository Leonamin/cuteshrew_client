import 'package:cuteshrew/core/domain/entity/user_entity.dart';

class UserPreviewEntity extends UserEntity {
  const UserPreviewEntity({required String name, required String email})
      : super(
          name: name,
          email: email,
        );
}
