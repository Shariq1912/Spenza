// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MyListModel _$$_MyListModelFromJson(Map<String, dynamic> json) =>
    _$_MyListModel(
      description: json['description'] as String,
      name: json['name'] as String,
      uid: json['uid'] as String,
      usersRef: json['usersRef'] as String,
      myListPhoto: json['myListPhoto'] as String?,
      documentId: json['documentId'] as String? ?? null,
    );

Map<String, dynamic> _$$_MyListModelToJson(_$_MyListModel instance) =>
    <String, dynamic>{
      'description': instance.description,
      'name': instance.name,
      'uid': instance.uid,
      'usersRef': instance.usersRef,
      'myListPhoto': instance.myListPhoto,
      'documentId': instance.documentId,
    };
