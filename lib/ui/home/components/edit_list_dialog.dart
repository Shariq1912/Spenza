import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spenza/ui/home/data/my_list_model.dart';
import 'package:spenza/ui/home/provider/edit_list_provider.dart';
import 'package:spenza/ui/home/provider/image_picker_provider.dart';
import 'package:spenza/ui/my_list_details/provider/list_details_provider.dart';
import 'package:spenza/utils/spenza_extensions.dart';

class EditListDialog extends ConsumerStatefulWidget {
  EditListDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<EditListDialog> createState() => _EditListDialogState();
}

class _EditListDialogState extends ConsumerState<EditListDialog> {
  final poppinsFont = GoogleFonts.poppins().fontFamily;
  final robotoFont = GoogleFonts.roboto().fontFamily;
  File? selectedImage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final fieldValidator = MultiValidator([
    RequiredValidator(errorText: 'Field is required'),
  ]);

  void _saveData(BuildContext context) {
    final selectedImage = ref.read(imagePickerProvider.notifier).state;
    final networkImage = ref.read(networkImageProvider.notifier).state;

    if (selectedImage == null && networkImage.isEmpty) {
      context.showSnackBar(message: "Please choose image");
      return;
    }

    MyListModel myListData = MyListModel(
      description: descriptionController.text.trim(),
      name: nameController.text.trim(),
      uid: "",
      usersRef: "",
      myListPhoto: selectedImage == null ? networkImage : selectedImage.path,
    );

    ref
        .read(editListProvider.notifier)
        .saveTheListDetails(myListData, selectedImage, context);
  }

  @override
  void dispose() {
    ref.read(imagePickerProvider.notifier).state = null;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(listDetailsProvider.notifier).getSelectedListDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(listDetailsProvider, (previous, next) {
      next.maybeWhen(
        orElse: () {},
        data: (data) {
          nameController.text = data.name.trim();
          descriptionController.text = data.description.trim();
          ref.read(networkImageProvider.notifier).state =
              data.myListPhoto ?? "";
        },
      );
    });
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17),
      ),
      child: contentBox(context),
      elevation: 0,
    );
  }

  contentBox(context) {
    return Container(
      height: 420,
      padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    ref.read(imagePickerProvider.notifier).state = null;
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: Image.asset(
                        "x_close.png".assetImageUrl,
                      ),
                    ),
                  ),
                )),
            InkWell(
              onTap: () async {
                final pickedImage =
                    await ImagePicker().pickImageFromGallery(context);
                if (pickedImage != null) {
                  debugPrint("PICKED IMAGE = $pickedImage");
                  ref.read(imagePickerProvider.notifier).state = pickedImage;
                }
              },
              child: Container(
                width: 130,
                height: 130,
                child: Consumer(
                  builder: (context, ref, child) => _buildImageWidget(ref),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Name your list",
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
            SizedBox(height: 10),
            Container(
              height: 50,
              child: TextFormField(
                controller: descriptionController,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Add description",
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Color(0xFFE5E7E8),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: double.infinity,
              child: Consumer(
                  builder: (context, ref, child) =>
                      ref.watch(editListProvider).maybeWhen(
                            loading: () => Center(
                              child: CircularProgressIndicator(),
                            ),
                            orElse: () => ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _saveData(context);
                                }
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
                              child: Text("Update".toUpperCase()),
                            ),
                          )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageWidget(WidgetRef ref) {
    final selectedImage = ref.watch(imagePickerProvider);
    final networkImage = ref.watch(networkImageProvider);

    debugPrint("SELECTED IMAGE = $selectedImage");
    debugPrint("NETWORK IMAGE = $networkImage");

    return selectedImage != null
        ? ClipOval(child: Image.file(selectedImage, fit: BoxFit.cover))
        : networkImage.isNotEmpty
            ? ClipOval(
                child: CachedNetworkImage(
                  imageUrl: networkImage,
                  fit: BoxFit.cover,
                ),
              )
            : ClipOval(
                child: Container(
                  child: Image.asset(
                    'list_image.png'.assetImageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              );
  }
}
