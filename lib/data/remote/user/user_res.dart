import 'package:json_annotation/json_annotation.dart';

part 'user_res.g.dart';

@JsonSerializable()
class UserRes {
  @JsonKey(name: 'nickname')
  final String nickname;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'password')
  final String? password;
  @JsonKey(name: 'introduction')
  final String? introduction;
  @JsonKey(name: 'posting_count')
  final int? postingCount;
  @JsonKey(name: 'comment_count')
  final int? commentCount;

  const UserRes({
    required this.nickname,
    required this.email,
    this.password,
    this.introduction,
    this.postingCount,
    this.commentCount,
  });

  factory UserRes.fromJson(Map<String, dynamic> json) =>
      _$UserResFromJson(json);

  Map<String, dynamic> toJson() => _$UserResToJson(this);
}
