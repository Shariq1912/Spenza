// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Users _$$_UsersFromJson(Map<String, dynamic> json) => _$_Users(
      uid: json['uid'] as String,
      name: json['name'] as String? ?? "",
      zipCode: json['zipCode'] as String? ?? "",
      email: json['email'] as String,
    );

Map<String, dynamic> _$$_UsersToJson(_$_Users instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'zipCode': instance.zipCode,
      'email': instance.email,
    };
