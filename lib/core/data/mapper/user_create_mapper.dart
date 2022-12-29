import 'package:cuteshrew/core/data/dto/user_create_dto.dart';
import 'package:cuteshrew/core/data/mapper/mapper.dart';
import 'package:cuteshrew/core/domain/entity/user_create_entity.dart';

class UserCreateMapper extends Mapper<UserCreateEntity, UserCreateDTO> {
  @override
  UserCreateDTO map(UserCreateEntity object) {
    return UserCreateDTO(
      nickname: object.name,
      email: object.email,
      password: object.password,
    );
  }
}
