// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posting_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostingRes _$PostingResFromJson(Map<String, dynamic> json) => PostingRes(
      postId: json['id'] as int,
      title: json['title'] as String?,
      body: json['body'] as String?,
      isLocked: json['is_locked'] as bool?,
      publishedAt: json['published_at'] as int?,
      updatedAt: json['updated_at'] as int?,
      writerInfo: json['creator'] == null
          ? null
          : UserRes.fromJson(json['creator'] as Map<String, dynamic>),
      ownCommunity: json['own_community'] == null
          ? null
          : CommunityDTO.fromJson(
              json['own_community'] as Map<String, dynamic>),
      commnetCount: json['comment_count'] as int?,
    );

Map<String, dynamic> _$PostingResToJson(PostingRes instance) =>
    <String, dynamic>{
      'id': instance.postId,
      'title': instance.title,
      'body': instance.body,
      'is_locked': instance.isLocked,
      'published_at': instance.publishedAt,
      'updated_at': instance.updatedAt,
      'creator': instance.writerInfo,
      'own_community': instance.ownCommunity,
      'comment_count': instance.commnetCount,
    };
