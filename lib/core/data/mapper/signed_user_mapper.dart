import 'package:cuteshrew/core/data/dto/hive/login_token_hive_dto.dart';
import 'package:cuteshrew/core/domain/entity/bearer_login_token.dart';
import 'package:cuteshrew/core/domain/entity/signed_user_entity.dart';
import 'package:cuteshrew/core/domain/entity/user_preview_entity.dart';

import 'mapper.dart';

class SignedUserMapper extends Mapper<LoginTokenHiveDTO, SignedUserEntity> {
  @override
  SignedUserEntity map(LoginTokenHiveDTO object) {
    return SignedUserEntity(
      userInfo: UserPreviewEntity(name: object.name, email: object.email),
      loginTokenEntity: BearerLoginTokenEntity(
          accessToken: object.accessToken,
          tokenType: object.tokenType,
          expires: object.expires ?? 0),
    );
  }
}
