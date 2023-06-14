import 'package:hive/hive.dart';
part 'login_token_hive.g.dart';

@HiveType(typeId: 0)
class LoginTokenHiveDTO {
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

  LoginTokenHiveDTO({
    required this.name,
    required this.email,
    required this.accessToken,
    required this.tokenType,
    this.expires,
  });
}
