// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserReq _$UserReqFromJson(Map<String, dynamic> json) => UserReq(
      nickname: json['nickname'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$UserReqToJson(UserReq instance) => <String, dynamic>{
      'nickname': instance.nickname,
      'email': instance.email,
      'password': instance.password,
    };
