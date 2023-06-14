// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posting_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostingReq _$PostingReqFromJson(Map<String, dynamic> json) => PostingReq(
      title: json['title'] as String,
      body: json['body'] as String,
      isLocked: json['is_locked'] as bool,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$PostingReqToJson(PostingReq instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'is_locked': instance.isLocked,
      'password': instance.password,
    };
