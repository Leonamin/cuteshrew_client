import 'package:cuteshrew/model/dto/user_dto.dart';
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
  @JsonKey(name: 'profile_image_url')
  final String? profileImageUrl;

  const UserRes({
    required this.nickname,
    required this.email,
    this.password,
    this.introduction,
    this.postingCount,
    this.commentCount,
    this.profileImageUrl,
  });

  factory UserRes.fromJson(Map<String, dynamic> json) =>
      _$UserResFromJson(json);

  Map<String, dynamic> toJson() => _$UserResToJson(this);
}

extension UserResX on UserRes {
  UserSummaryInfo toSummaryInfo() => UserSummaryInfo(
        name: nickname,
        email: email,
        profileImageUrl: profileImageUrl,
      );
  UserDetailInfo toDetailInfo() => UserDetailInfo(
        name: nickname,
        email: email,
        introduction: introduction ?? '',
        postingCount: postingCount ?? 0,
        commentCount: commentCount ?? 0,
        profileImageUrl: profileImageUrl,
      );
}
