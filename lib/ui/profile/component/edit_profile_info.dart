import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spenza/ui/profile/component/profile_fields_row.dart';
import 'package:spenza/ui/profile/profile_screen.dart';
import 'package:spenza/utils/spenza_extensions.dart';

import '../data/user_profile_data.dart';
import '../profile_repository.dart';

class EditProfileInformation extends ConsumerStatefulWidget {
  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends ConsumerState<EditProfileInformation> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController streetNumberController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final poppinsFont = GoogleFonts.poppins().fontFamily;
  String sex = "Male";
  File? selectedImage;

  @override
  void initState() {
    super.initState();
  }



  Future<void> _saveData() async {
    UserProfileData userProfileData = UserProfileData(
      name: nameController.text,
      surName: surnameController.text,
      mobileNo: mobileNumberController.text,
      street: streetController.text,
      streetNumber: streetNumberController.text,
      district: districtController.text,
      state: stateController.text,
      zipCode: zipCodeController.text,
      profilePhoto: selectedImage!.path
    );


    bool isDataSaved = await ref
        .read(profileRepositoryProvider.notifier)
        .saveZipCodeToServer(userProfileData,selectedImage);


    if (isDataSaved) {

     /* Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProfileScreen(),
      ));*/
    } else {

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Failed to save data. Please try again."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: topAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer(
            builder: (context, ref, child) {
              final userProvider = ref.watch(profileRepositoryProvider);
              return userProvider.maybeWhen(() => Container(),
                  loading: () => Center(heightFactor : 400,child: CircularProgressIndicator()),
                  error: (message) {
                    print("errorMsg $message");
                    return Center(child: Text(message));
                  },
                  orElse: () {
                    return Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              
                              Center(child: leadingWidget("")),
                              buildCard(
                                "Profile Information",
                                [
                                  ProfileFieldRow(
                                    name1: "Name",
                                    controller: nameController,
                                  ),
                                  ProfileFieldRow(
                                    name1: "Surname",
                                    controller: surnameController,
                                  ),
                                  ProfileFieldRow(
                                    name1: "Mobile No.",
                                    controller: mobileNumberController,
                                    isNumericField: true,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              buildCard(
                                "Address",
                                [
                                  ProfileFieldRow(
                                    name1: "Street",
                                    controller: streetController,
                                  ),
                                  ProfileFieldRow(
                                    name1: "Number",
                                    controller: streetNumberController,
                                  ),
                                  ProfileFieldRow(
                                    name1: "Zip code",
                                    controller: zipCodeController,
                                    isNumericField: true,
                                  ),
                                ],
                              )
                            ]));
                  },

                  );
            },
          ),
        ),
      ),
    );
  }

  Widget buildCard(String title, List<ProfileFieldRow> rows) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: poppinsFont,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0CA9E6),
                ),
              ),
              SizedBox(height: 10),
              ...rows,
            ],
          ),
        ),
      ),
    );
  }

  AppBar topAppBar() {
    return AppBar(
        elevation: 5.0,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
              onPressed: () async {
                await _saveData();
                //ref.watch(profileRepositoryProvider.notifier).getStateName("45110");

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ));
              },
              child: Text(
                "Save",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: poppinsFont,
                    color :Color(0xFF0CA9E6)
                ),
              )),
        ]);
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    mobileNumberController.dispose();

    super.dispose();
  }

  Widget leadingWidget(String fileName) {
    return GestureDetector(
      onTap: () async {
        final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (pickedImage != null) {
          setState(() {
            selectedImage = File(pickedImage.path);
          });
        }
      },
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          CircleAvatar(
            radius: 50,
            child: selectedImage != null
                ? Image.file(
              selectedImage!, // Use the selected image file if not null
              fit: BoxFit.cover,
              width: 100,
              height: 100,
            )
                : (fileName.isEmpty
                ? Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.fill,
              width: 100,
              height: 100,
            )
                : CircleAvatar(
              radius: 50,
              backgroundImage: CachedNetworkImageProvider(fileName),
            )),
          ),
        ],
      ),
    );
  }



}
