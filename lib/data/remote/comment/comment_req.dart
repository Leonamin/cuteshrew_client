import 'package:json_annotation/json_annotation.dart';

part 'comment_req.g.dart';

@JsonSerializable()
class CommentReq {
  @JsonKey(name: 'comment')
  final String comment;
  @JsonKey(name: 'group_id')
  final int? groupId;
  @JsonKey(name: 'comment_class')
  final int? commentClass;

  const CommentReq({
    required this.comment,
    this.groupId,
    this.commentClass,
  });

  factory CommentReq.fromJson(Map<String, dynamic> json) =>
      _$CommentReqFromJson(json);

  Map<String, dynamic> toJson() => _$CommentReqToJson(this);
}
