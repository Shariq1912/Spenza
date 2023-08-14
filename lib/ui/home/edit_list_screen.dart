

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spenza/di/app_providers.dart';
import 'package:spenza/ui/home/data/my_list_model.dart';
import 'package:spenza/ui/home/provider/edit_list_provider.dart';
import 'package:spenza/ui/home/provider/image_picker_provider.dart';
import 'package:spenza/ui/my_list_details/provider/list_details_provider.dart';
import 'package:spenza/utils/spenza_extensions.dart';

class EditListScreen extends ConsumerStatefulWidget {
  const EditListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _EditListState();
}

class _EditListState extends ConsumerState<EditListScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(listDetailsProvider.notifier).getSelectedListDetails();
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    descriptionController.dispose();
    ref.invalidate(imagePickerProvider);
    ref.invalidate(networkImageProvider);
  }

  @override
  Widget build(BuildContext context) {
    final poppinsFont = ref.watch(poppinsFontProvider).fontFamily;

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


    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    // Call the pickImageFromGallery extension function
                    final pickedImage =
                        await ImagePicker().pickImageFromGallery(context);
                    if (pickedImage != null) {
                      debugPrint("PICKED IMAGE = $pickedImage");
                      ref.read(imagePickerProvider.notifier).state =
                          pickedImage;
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
                SizedBox(height: 10),
                TextFormField(
                  style: TextStyle(fontFamily: poppinsFont),
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Name",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                  ),
                  validator: fieldValidator,
                ),
                SizedBox(height: 10),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2)),
                  child: TextFormField(
                    validator: fieldValidator,
                    controller: descriptionController,
                    maxLines: 3,
                    style: TextStyle(fontFamily: poppinsFont),
                    decoration: InputDecoration(
                      hintText: "Add description",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
                SizedBox(height: 10),
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
        ? Image.file(selectedImage, fit: BoxFit.cover)
        : networkImage.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: networkImage,
                fit: BoxFit.cover,
              )
            : Image.asset(
                'list_image.png'.assetImageUrl,
                fit: BoxFit.cover,
              );
  }
}
