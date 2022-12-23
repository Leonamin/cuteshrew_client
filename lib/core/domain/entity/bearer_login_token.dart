import 'package:cuteshrew/core/domain/entity/login_token_entity.dart';

// bearer 토큰
class BearerLoginTokenEntity extends LoginTokenEntity {
  const BearerLoginTokenEntity({
    required String accessToken,
    required String tokenType,
    required int expires,
  }) : super(accessToken: accessToken, tokenType: tokenType, expires: expires);
}
