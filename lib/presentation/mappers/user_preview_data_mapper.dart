import 'package:cuteshrew/core/data/mapper/mapper.dart';
import 'package:cuteshrew/core/domain/entity/user_entity.dart';
import 'package:cuteshrew/presentation/data/user_preview_data.dart';

class UserPreviewDataMapper extends Mapper<UserEntity, UserPreviewData> {
  @override
  UserPreviewData map(UserEntity object) {
    return UserPreviewData(
      name: object.name,
      email: object.name,
    );
  }
}
