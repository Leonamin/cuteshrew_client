// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentRes _$CommentResFromJson(Map<String, dynamic> json) => CommentRes(
      commentId: json['id'] as int,
      writerId: json['user_id'] as int?,
      comment: json['comment'] as String?,
      createdAt: json['created_at'] as int?,
      postId: json['post_id'] as int?,
      commentClass: json['comment_class'] as int?,
      order: json['order'] as int?,
      groupId: json['group_id'] as int?,
      writerInfo: json['creator'] == null
          ? null
          : UserRes.fromJson(json['creator'] as Map<String, dynamic>),
      posting: json['posting'] == null
          ? null
          : PostingRes.fromJson(json['posting'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentResToJson(CommentRes instance) =>
    <String, dynamic>{
      'id': instance.commentId,
      'user_id': instance.writerId,
      'comment': instance.comment,
      'created_at': instance.createdAt,
      'post_id': instance.postId,
      'comment_class': instance.commentClass,
      'order': instance.order,
      'group_id': instance.groupId,
      'creator': instance.writerInfo,
      'posting': instance.posting,
    };
