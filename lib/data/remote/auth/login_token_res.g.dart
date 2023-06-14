// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_token_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginTokenRes _$LoginTokenResFromJson(Map<String, dynamic> json) =>
    LoginTokenRes(
      accessToken: json['access_token'] as String,
      tokenType: json['token_type'] as String,
      expires: json['expires'] as int?,
    );

Map<String, dynamic> _$LoginTokenResToJson(LoginTokenRes instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'expires': instance.expires,
    };
