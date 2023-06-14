import 'package:json_annotation/json_annotation.dart';

part 'community_res.g.dart';

@JsonSerializable()
class CommunityRes {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String? communityName;
  @JsonKey(name: 'showname')
  final String? communityShowName;
  @JsonKey(name: 'postings_count')
  final int? postingsCount;
  @JsonKey(name: 'created_at')
  final int? createdAt;

  const CommunityRes({
    required this.id,
    this.communityShowName,
    this.communityName,
    this.postingsCount,
    this.createdAt,
  });

  factory CommunityRes.fromJson(Map<String, dynamic> json) =>
      _$CommunityResFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityResToJson(this);
}
