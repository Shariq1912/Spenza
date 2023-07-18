import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../home/item_list_provider.dart';

class AddItemToList extends ConsumerStatefulWidget {
  const AddItemToList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddItemToListState();
}

class _AddItemToListState extends ConsumerState<AddItemToList> {
  final poppinsFont = GoogleFonts.poppins().fontFamily;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  File? selectedImage;

  Future<void> _selectImage() async {
    if (await _requestPermission()) {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          selectedImage = File(pickedImage.path);
        });
      }
    } else {
      // Show a message or take appropriate action if permission is denied.
    }
  }

  Future<bool> _requestPermission() async {
    final permissionStatus = await Permission.photos.request();
    return permissionStatus.isGranted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: _selectImage,
                child: Container(
                  width: 130,
                  height: 130,
                  child: selectedImage != null
                      ? Image.file(selectedImage!, fit: BoxFit.cover)
                      : Image.asset('assets/images/avatar.gif', fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                style: TextStyle(fontFamily: poppinsFont),
                decoration: InputDecoration(
                  hintText: "Name",
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 100,
                decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 2)),
                child: TextField(
                  maxLines: 3,
                  style: TextStyle(fontFamily: poppinsFont),
                  decoration: InputDecoration(
                    hintText: "Add description",
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final name = nameController.text;
                    final description = descriptionController.text;
                    ref.read(itemListProvider.notifier).addItem(name, description,selectedImage!);
                    Navigator.pop(context); // Go back to the previous screen
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

