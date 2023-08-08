// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserProfileData _$$_UserProfileDataFromJson(Map<String, dynamic> json) =>
    _$_UserProfileData(
      zipCode: json['zipCode'] as String,
      name: json['name'] as String?,
      surName: json['surName'] as String?,
      mobileNo: json['mobileNo'] as String?,
      street: json['street'] as String?,
      streetNumber: json['streetNumber'] as String?,
      district: json['district'] as String?,
      state: json['state'] as String?,
      profilePhoto: json['profilePhoto'] as String?,
    );

Map<String, dynamic> _$$_UserProfileDataToJson(_$_UserProfileData instance) =>
    <String, dynamic>{
      'zipCode': instance.zipCode,
      'name': instance.name,
      'surName': instance.surName,
      'mobileNo': instance.mobileNo,
      'street': instance.street,
      'streetNumber': instance.streetNumber,
      'district': instance.district,
      'state': instance.state,
      'profilePhoto': instance.profilePhoto,
    };
