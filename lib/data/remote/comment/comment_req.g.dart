// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentReq _$CommentReqFromJson(Map<String, dynamic> json) => CommentReq(
      comment: json['comment'] as String,
      groupId: json['group_id'] as int?,
      commentClass: json['comment_class'] as int?,
    );

Map<String, dynamic> _$CommentReqToJson(CommentReq instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'group_id': instance.groupId,
      'comment_class': instance.commentClass,
    };
