import 'package:json_annotation/json_annotation.dart';

part 'posting_req.g.dart';

@JsonSerializable()
class PostingReq {
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'body')
  final String body;
  @JsonKey(name: 'is_locked')
  final bool isLocked;
  @JsonKey(name: 'password')
  final String? password;

  const PostingReq({
    required this.title,
    required this.body,
    required this.isLocked,
    required this.password,
  });

  factory PostingReq.fromJson(Map<String, dynamic> json) =>
      _$PostingReqFromJson(json);

  Map<String, dynamic> toJson() => _$PostingReqToJson(this);
}
