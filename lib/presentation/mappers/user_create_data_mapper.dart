import 'package:cuteshrew/core/data/mapper/mapper.dart';
import 'package:cuteshrew/core/domain/entity/user_create_entity.dart';
import 'package:cuteshrew/presentation/data/user_create_data.dart';

class UserCreateDataMapper extends Mapper<UserCreateData, UserCreateEntity> {
  @override
  UserCreateEntity map(UserCreateData object) {
    return UserCreateEntity(
      name: object.name,
      email: object.email,
      password: object.password,
    );
  }
}
