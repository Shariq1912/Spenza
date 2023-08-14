import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spenza/ui/home/provider/add_product_to%20_new_list_provider.dart';
import 'package:spenza/utils/spenza_extensions.dart';

import '../../home/data/my_list_model.dart';

class AddProductToNewList extends ConsumerStatefulWidget {
  final String productId;
  final String productRef;
  const AddProductToNewList({Key? key, required this.productId, required this.productRef}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddProductToNewListState();
}

class _AddProductToNewListState extends ConsumerState<AddProductToNewList> {
  final poppinsFont = GoogleFonts.poppins().fontFamily;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  File? selectedImage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final fieldValidator = MultiValidator([
    RequiredValidator(errorText: 'Field is required'),

  ]);

  Future<void> _saveData(BuildContext context) async {
    MyListModel myListData = MyListModel(
        description: descriptionController.text,
        name: nameController.text,
        uid: "",
        usersRef: "",
        myListPhoto: selectedImage!.path);


    //await ref.read(myListRepositoryProvider.notifier).saveMyList(myListData, selectedImage);
    ref.read(addProdToNewListProvider.notifier).addProductToNewList(myListData, selectedImage,widget.productId, widget.productRef,context);
  }


  @override
  Widget build(BuildContext context) {
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
                      setState(() {
                        selectedImage = File(pickedImage.path);
                      });
                    }
                  },
                  child: Container(
                    width: 130,
                    height: 130,
                    child: selectedImage != null
                        ? Image.file(selectedImage!, fit: BoxFit.cover)
                        : Image.asset('assets/images/avatar.gif',
                        fit: BoxFit.cover),
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
                          ref.watch(addProdToNewListProvider).maybeWhen(
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
                              child: Text("Create new list"),
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

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}