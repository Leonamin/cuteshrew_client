import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class LoginTokenHiveDTO {
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String accessToken;
  @HiveField(4)
  final String tokenType;
  @HiveField(5)
  final int? expires;

  const LoginTokenHiveDTO({
    required this.name,
    required this.email,
    required this.accessToken,
    required this.tokenType,
    this.expires,
  });
}
