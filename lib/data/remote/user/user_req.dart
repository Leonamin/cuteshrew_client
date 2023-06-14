import 'package:json_annotation/json_annotation.dart';

part 'user_req.g.dart';

@JsonSerializable()
class UserReq {
  @JsonKey(name: 'nickname')
  final String nickname;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'password')
  final String password;

  const UserReq({
    required this.nickname,
    required this.email,
    required this.password,
  });

  factory UserReq.fromJson(Map<String, dynamic> json) =>
      _$UserReqFromJson(json);

  Map<String, dynamic> toJson() => _$UserReqToJson(this);
}
