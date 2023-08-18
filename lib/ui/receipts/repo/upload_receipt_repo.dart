import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/helpers/fireStore_pref_mixin.dart';
import 'package:spenza/network/api_responses.dart';
import 'package:spenza/ui/receipts/data/image_pick_state.dart';
import 'package:spenza/ui/receipts/data/receipt_model.dart';
import 'package:spenza/utils/spenza_extensions.dart';

part 'upload_receipt_repo.g.dart';

@riverpod
class UploadReceiptRepo extends _$UploadReceiptRepo with FirestoreAndPrefsMixin {

  @override
  ImagePickState build() {
     return ImagePickState();
   }


  Future<void> pickImage(BuildContext context) async {
    final pickedImage = await ImagePicker().pickImageFromGallery(context);
    if (pickedImage != null) {
      state = ImagePickState.selected(File(pickedImage.path));
    }
  }

  Future<void> uploadReceipt (File? image, String name, BuildContext context) async {
    try {

       state = ImagePickState.loading();
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getUserId();

      String? downloadURL;
      if (image != null) {
        downloadURL = await image.uploadImageToFirebase( path: "receipts");
      }
      final receiptModel = ReceiptModel(name: name, receipt: "", uid: userId);

      final myListCollection = fireStore.collection("receipt");
      final myListRequest = receiptModel.copyWith(receipt: downloadURL);

      await myListCollection.add(myListRequest.toJson());
      state = ImagePickState.uploaded(msg: "uploaded successfully");
      context.pop(true);

    } catch (error) {
      state = ImagePickState.error(msg : error.toString());
    }
  }
}