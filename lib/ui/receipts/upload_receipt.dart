import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/ui/receipts/repo/upload_receipt_repo.dart';

class UploadReceipt extends ConsumerWidget {
  final poppinsFont = GoogleFonts.poppins().fontFamily;
   File? SelectedImage ;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(uploadReceiptRepoProvider);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Text(
          "Upload Receipt",
          style: TextStyle(
            fontFamily: poppinsFont,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xFF0CA9E6),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back_ios, color: Color(0xFF0CA9E6))),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            InkWell(
              onTap: () => ref
                  .read(uploadReceiptRepoProvider.notifier)
                  .pickImage(context),
              child: Container(
                  padding: EdgeInsets.all(15),
                  child: state.when(
                    () => Container(
                        color: Colors.grey.shade200,
                        child: Icon(
                          Icons.file_upload,
                          size: 50,
                          color: Colors.grey,
                        )),
                    selected: (selectedState) {
                      SelectedImage = selectedState;
                      return Container(
                        width: 200,
                          height: 200,
                          child: Image.file(selectedState, fit: BoxFit.cover));
                    },

                    uploaded:(uploaded)=> AlertDialog(title: Text(uploaded),
                    ),
                    error: (error) => Container(child: Text(error),)
                  ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
               ref.read(uploadReceiptRepoProvider.notifier).uploadReceipt(SelectedImage, "receipt");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0CA9E6),
                foregroundColor: Colors.white,
                textStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: poppinsFont,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text("Create new list"),
            ),
          ],
        ),
      ),
    );
  }
}
