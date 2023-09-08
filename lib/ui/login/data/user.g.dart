// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Users _$$_UsersFromJson(Map<String, dynamic> json) => _$_Users(
      uid: json['uid'] as String,
      name: json['name'] as String? ?? "",
      zipCode: json['zipCode'] as String? ?? "",
      profilePhoto: json['profilePhoto'] as String? ??
          "https://firebasestorage.googleapis.com/v0/b/spenzabeta-74e04.appspot.com/o/images%2Fuser.png?alt=media&token=dc1f756f-b9a7-44b2-9c1a-d98ae5376a85",
      email: json['email'] as String,
    );

Map<String, dynamic> _$$_UsersToJson(_$_Users instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'zipCode': instance.zipCode,
      'profilePhoto': instance.profilePhoto,
      'email': instance.email,
    };
