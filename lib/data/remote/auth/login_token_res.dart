import 'package:json_annotation/json_annotation.dart';

part 'login_token_res.g.dart';

@JsonSerializable()
class LoginTokenRes {
  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'token_type')
  final String tokenType;
  @JsonKey(name: 'expires')
  final int? expires;

  const LoginTokenRes({
    required this.accessToken,
    required this.tokenType,
    this.expires,
  });

  factory LoginTokenRes.fromJson(Map<String, dynamic> json) =>
      _$LoginTokenResFromJson(json);

  Map<String, dynamic> toJson() => _$LoginTokenResToJson(this);
}
