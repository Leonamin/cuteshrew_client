// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityRes _$CommunityResFromJson(Map<String, dynamic> json) => CommunityRes(
      id: json['id'] as int,
      communityShowName: json['showname'] as String?,
      communityName: json['name'] as String?,
      postingsCount: json['postings_count'] as int?,
      createdAt: json['created_at'] as int?,
    );

Map<String, dynamic> _$CommunityResToJson(CommunityRes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.communityName,
      'showname': instance.communityShowName,
      'postings_count': instance.postingsCount,
      'created_at': instance.createdAt,
    };
