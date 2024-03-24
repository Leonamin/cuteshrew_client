import 'package:cuteshrew/2_data/remote/user/user_summary_res.dart';
import 'package:cuteshrew/core/data/mapper/mapper.dart';
import 'package:cuteshrew/core/domain/entity/user_detail_entity.dart';
import 'package:cuteshrew/core/domain/entity/user_entity.dart';

class UserDetailMapper extends Mapper<UserSummaryRes, UserEntity> {
  @override
  UserDetailEntity map(UserSummaryRes object) {
    return UserDetailEntity(
      email: object.email,
      name: object.nickname,
      postingCount: object.postingCount ?? -1,
      commentCount: object.commentCount ?? -1,
      introduction: "introduction",
    );
  }
}
