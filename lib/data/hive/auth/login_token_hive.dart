import 'package:cuteshrew/model/dto/login_dto.dart';
import 'package:cuteshrew/model/dto/user_dto.dart';
import 'package:hive/hive.dart';
part 'login_token_hive.g.dart';

@HiveType(typeId: 0)
class LoginTokenHive {
  @HiveField(0)
  String name;
  @HiveField(1)
  String email;
  @HiveField(2)
  String accessToken;
  @HiveField(3)
  String tokenType;
  @HiveField(4)
  int? expires;

  LoginTokenHive({
    required this.name,
    required this.email,
    required this.accessToken,
    required this.tokenType,
    this.expires,
  });
}

extension LoginTokenHiveX on LoginTokenHive {
  SignedUserInfo toSignedUser() => SignedUserInfo(
        userInfo: UserSummaryInfo(name: name, email: email),
        loginToken: LoginToken(
          accessToken: accessToken,
          tokenType: tokenType,
          expires: expires ?? 0,
        ),
      );
  LoginToken toTokenDto() => LoginToken(
        accessToken: accessToken,
        tokenType: tokenType,
        expires: expires ?? 0,
      );
}
