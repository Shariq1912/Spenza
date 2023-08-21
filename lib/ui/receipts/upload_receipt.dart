import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/ui/receipts/repo/upload_receipt_repo.dart';
import 'package:spenza/utils/spenza_extensions.dart';

class UploadReceipt extends ConsumerStatefulWidget {
@override
_UploadReceiptState createState() => _UploadReceiptState();
}

class _UploadReceiptState extends ConsumerState<UploadReceipt> {
  final poppinsFont = GoogleFonts.poppins().fontFamily;
  File? SelectedImage;

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {
              context.pop();
            },
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
                  child: state.maybeWhen(
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


                    error: (error) => Container(child: Text(error),),
                    orElse: () => Container(),
                  ),
              ),
            ),
            SizedBox(height: 20),

            Consumer(
                builder: (context, ref, child) =>
                    ref.watch(uploadReceiptRepoProvider).maybeWhen(
                            () => ElevatedButton(
                              onPressed: () async {
                                if(SelectedImage == null || SelectedImage?.path == null){
                                  context.showSnackBar(message: "Please choose receipt");
                                  return;
                                }
                                ref.read(uploadReceiptRepoProvider.notifier).uploadReceipt(SelectedImage, "receipt", context);
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
                              child: Text("Upload"),
                            ),
                        loading: () =>Center(
                          child: CircularProgressIndicator(),
                        ),
                      orElse: () => ElevatedButton(
                        onPressed: () async {
                          if(SelectedImage == null || SelectedImage?.path == null){
                            context.showSnackBar(message: "Please choose receipt");
                            return;
                          }
                          ref.read(uploadReceiptRepoProvider.notifier).uploadReceipt(SelectedImage, "receipt", context);
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
                        child: Text("Upload"),
                      ),
                    )),

          ],
        ),
      ),
    );
  }
}
