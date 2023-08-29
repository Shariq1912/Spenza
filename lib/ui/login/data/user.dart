import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class Users with _$Users {
  const factory Users({
    required String uid,
    @Default("") String name,
    @Default("") String zipCode,
    @Default("https://firebasestorage.googleapis.com/v0/b/spenzabeta-74e04.appspot.com/o/images%2Fuser.png?alt=media&token=dc1f756f-b9a7-44b2-9c1a-d98ae5376a85") String profilePhoto,
    required String email,

  }) = _Users;

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);
}
