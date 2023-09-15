import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/helpers/fireStore_pref_mixin.dart';
import 'package:spenza/network/api_responses.dart';
import 'package:spenza/ui/home/provider/home_preloaded_list.dart';
import 'package:spenza/ui/receipts/data/image_pick_state.dart';
import 'package:spenza/ui/receipts/data/receipt_model.dart';
import 'package:spenza/utils/fireStore_constants.dart';
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
  Future<void> uploadReceipt(File? image, BuildContext context, String path, String amount) async {
    try {
      state = ImagePickState.loading();

      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getUserId();

      DateTime currentDate = DateTime.now();
      String formattedDate = DateFormat('dd/MM/yyyy').format(currentDate);

      DocumentReference documentReference = fireStore.doc(path);

      String? downloadURL;
      if (image != null) {
        downloadURL = await image.uploadImageToFirebase(path: "receipts");
      }

      DocumentSnapshot docSnapshot;
      try {
        docSnapshot = await documentReference.get();
      } catch (error) {
        print("Error fetching document: $error");
        return;
      }

      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;

        String name = data['name'] ?? "Name Not Available";
        String description = data['description'] ?? "Description Not Available";

        final myListCollection = fireStore.collection(ReceiptConstant.collectionName);
        await myListCollection.add({
          'uid': userId,
          'list_ref': documentReference,
          'name': name,
          'receipt': downloadURL,
          'date': formattedDate,
          'description': description,
          'amount': amount
        });

        state = ImagePickState.uploaded(msg: "Uploaded successfully");
        ref.read(homePreloadedListProvider.notifier).fetchPreloadedList();
        context.pop(true);
      } else {
        print("Document does not exist");
      }
    } catch (error) {
      state = ImagePickState.error(msg: error.toString());
    }
  }

}