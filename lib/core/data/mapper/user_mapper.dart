import 'package:cuteshrew/core/data/dto/remote/user_dto.dart';
import 'package:cuteshrew/core/data/mapper/mapper.dart';
import 'package:cuteshrew/core/domain/entity/user_detail_entity.dart';
import 'package:cuteshrew/core/domain/entity/user_entity.dart';

class UserDetailMapper extends Mapper<UserDTO, UserEntity> {
  @override
  UserDetailEntity map(UserDTO object) {
    return UserDetailEntity(
      email: object.email,
      name: object.nickname,
      postingCount: object.postingCount ?? -1,
      commentCount: object.commentCount ?? -1,
      introduction: "introduction",
    );
  }
}
