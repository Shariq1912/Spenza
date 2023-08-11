import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/network/api_responses.dart';
import 'package:spenza/ui/receipts/data/image_pick_state.dart';
import 'package:spenza/ui/receipts/data/receipt_model.dart';
import 'package:spenza/utils/spenza_extensions.dart';

part 'upload_receipt_repo.g.dart';

@riverpod
class UploadReceiptRepo extends _$UploadReceiptRepo {

  @override
  ImagePickState build() {
     return ImagePickState();
   }
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> pickImage(BuildContext context) async {
    final pickedImage = await ImagePicker().pickImageFromGallery(context);
    if (pickedImage != null) {
      state = ImagePickState.selected(File(pickedImage.path));
    }
  }

  Future<void> uploadReceipt (File? image, String name) async {
    try {

      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getUserId();

      String? downloadURL;
      if (image != null) {
        downloadURL = await image.uploadImageToFirebase("receipts");
      }
      final receiptModel = ReceiptModel(name: name, receipt: "", uid: userId);

      final myListCollection = _firestore.collection("receipt");
      final myListRequest = receiptModel.copyWith(receipt: downloadURL);

      await myListCollection.add(myListRequest.toJson());
      state = ImagePickState.uploaded(msg: "uploaded successfully");
    } catch (error) {
      state = ImagePickState.error(msg : error.toString());
    }
  }
}