// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRes _$UserResFromJson(Map<String, dynamic> json) => UserRes(
      nickname: json['nickname'] as String,
      email: json['email'] as String,
      password: json['password'] as String?,
      introduction: json['introduction'] as String?,
      postingCount: json['posting_count'] as int?,
      commentCount: json['comment_count'] as int?,
    );

Map<String, dynamic> _$UserResToJson(UserRes instance) => <String, dynamic>{
      'nickname': instance.nickname,
      'email': instance.email,
      'password': instance.password,
      'introduction': instance.introduction,
      'posting_count': instance.postingCount,
      'comment_count': instance.commentCount,
    };
