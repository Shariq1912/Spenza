import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_data.freezed.dart';
part 'user_profile_data.g.dart';

@freezed
class UserProfileData with _$UserProfileData {
  const factory UserProfileData({

   required String zipCode,
     String? name,
     String? surName,
     String? mobileNo,
     String? street,
     String? streetNumber,
     String? district,
     String? state,
    String? profilePhoto,
  }) = _UserProfileData;

  factory UserProfileData.fromJson(Map<String, dynamic> json) =>
      _$UserProfileDataFromJson(json);
}
