import 'package:cuteshrew/core/data/dto/user_dto.dart';
import 'package:cuteshrew/core/data/mapper/mapper.dart';
import 'package:cuteshrew/core/domain/entity/user_detail_entity.dart';
import 'package:cuteshrew/core/domain/entity/user_entity.dart';

class UserMapper extends Mapper<UserDTO, UserEntity> {
  @override
  UserEntity map(UserDTO object) {
    return UserDetailEntity(
      email: object.email,
      name: object.nickname,
      postingCount: object.postingCount ?? -1,
      commentCount: object.commentCount ?? -1,
      introduction: "introduction",
    );
  }
}
