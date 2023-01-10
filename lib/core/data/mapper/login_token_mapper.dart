import 'package:cuteshrew/core/data/dto/remote/login_token_dto.dart';
import 'package:cuteshrew/core/data/mapper/mapper.dart';
import 'package:cuteshrew/core/domain/entity/bearer_login_token.dart';
import 'package:cuteshrew/core/domain/entity/login_token_entity.dart';

class LoginTokenMapper extends Mapper<LoginTokenDTO, LoginTokenEntity> {
  @override
  LoginTokenEntity map(LoginTokenDTO object) {
    return BearerLoginTokenEntity(
      accessToken: object.accessToken,
      tokenType: object.tokenType,
      expires: object.expires ?? 0,
    );
  }

  LoginTokenDTO toDTO(LoginTokenEntity object) {
    return LoginTokenDTO(
      accessToken: object.accessToken,
      tokenType: object.tokenType,
      expires: object.expires,
    );
  }
}
