import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spenza/ui/home/data/my_list_model.dart';
import 'package:spenza/ui/home/provider/image_picker_provider.dart';
import 'package:spenza/ui/home/provider/save_mylist_provider.dart';
import 'package:spenza/ui/receipts/component/store_pick_dialog.dart';
import 'package:spenza/ui/receipts/repo/upload_receipt_repo.dart';
import 'package:spenza/utils/spenza_extensions.dart';

import '../../utils/color_utils.dart';

class UploadReceiptScreen extends ConsumerStatefulWidget {
  UploadReceiptScreen({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  ConsumerState<UploadReceiptScreen> createState() =>
      _UploadReceiptScreenState();
}

class _UploadReceiptScreenState extends ConsumerState<UploadReceiptScreen> {
  final poppinsFont = GoogleFonts.poppins().fontFamily;
  final robotoFont = GoogleFonts.roboto().fontFamily;
  File? selectedImage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  final fieldValidator = MultiValidator([
    RequiredValidator(errorText: 'Field is required'),
  ]);

  Future<void> _saveData(BuildContext context) async {
    File defaultImage =
        await getImageFileFromAssets('images/app_icon_spenza.png');
    MyListModel myListData = MyListModel(
      name: nameController.text.trim(),
      uid: "",
      usersRef: "",
      myListPhoto: selectedImage?.path ?? 'assets/images/app_icon_spenza.png',
      description: '',
    );
    if (selectedImage != null) {
      ref
          .read(saveMyListProvider.notifier)
          .saveMyListFun(myListData, selectedImage, context);
    } else {
      ref
          .read(saveMyListProvider.notifier)
          .saveMyListFun(myListData, defaultImage, context);
    }
  }

  @override
  void dispose() {
    ref.read(imagePickerProvider.notifier).state = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Upload receipt",
          style: TextStyle(
              color: Color(0xFF7B868C),
              fontFamily: poppinsFont,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        leading: IconButton(
            onPressed: () {
              ref.read(imagePickerProvider.notifier).state = null;
              context.pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Color(0xFF7B868C),
              size: 20,
            )),
      ),
      body: Container(
        child: contentBox(context),
      ),
    );
  }

  contentBox(context) {
    bool isPhotoSelected = ref.watch(imagePickerProvider) != null;
    return Container(
      padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                final pickedImage =
                    await ImagePicker().pickImageFromGallery(context);
                if (pickedImage != null) {
                  ref.read(imagePickerProvider.notifier).state = pickedImage;
                }
              },
              child: Container(
                width: 100,
                height: 100,
                child: Consumer(builder: (context, ref, child) {
                  selectedImage = ref.watch(imagePickerProvider);
                  return selectedImage != null
                      ? Image.file(selectedImage!, fit: BoxFit.cover)
                      : Image.asset('upload_images.png'.assetImageUrl,
                          fit: BoxFit.cover);
                }),
              ),
            ),
            Visibility(
              visible: !isPhotoSelected,
              child: Text(
                "Upload photo for your receipt",
                style: TextStyle(
                    color: Color(0xFF7B868C),
                    fontFamily: robotoFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 52,
              child: ListTile(
                leading: Icon(Icons.logout, color: Colors.grey.shade600),
                title: Text(
                  "Choose Store",
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: robotoFont,
                      color: ColorUtils.primaryText),
                ),
                trailing:
                    Icon(Icons.arrow_drop_down, color: Colors.grey.shade600),
                onTap: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StorePickDialog();
                    },
                    barrierDismissible: false),
                tileColor: Color(0xFFE5E7E8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 52,
              color: Color(0xFFE5E7E8),
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.attach_money),
                  hintText: "Amount Paid",
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Color(0xFFE5E7E8),
                ),
                validator: fieldValidator,
                controller: nameController,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: double.infinity,
              child: Consumer(
                  builder: (context, ref, child) =>
                      ref.watch(saveMyListProvider).maybeWhen(
                            loading: () => Center(
                              child: CircularProgressIndicator(),
                            ),
                            orElse: () => ElevatedButton(
                              onPressed: () async {
                                if (selectedImage == null ||
                                    selectedImage?.path == null) {
                                  context.showSnackBar(
                                      message: "Please choose receipt");
                                  return;
                                }
                                ref
                                    .read(uploadReceiptRepoProvider.notifier)
                                    .uploadReceipt(
                                        selectedImage, context, widget.path);
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
                              child: Text(
                                "Upload",
                                style: TextStyle(fontFamily: robotoFont),
                              ),
                            ),
                          )),
            ),
          ],
        ),
      ),
    );
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.create(recursive: true);
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }
}
