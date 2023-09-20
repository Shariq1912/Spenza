import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/ui/location/location_provider.dart';
import 'package:spenza/ui/profile/profile_repository.dart';
import 'package:spenza/utils/spenza_extensions.dart';

class LocationDialog extends ConsumerStatefulWidget {
  LocationDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<LocationDialog> createState() => _LocationDialogState();
}

class _LocationDialogState extends ConsumerState<LocationDialog> {
  final poppinsFont = GoogleFonts.poppins().fontFamily;
  final robotoFont = GoogleFonts.roboto().fontFamily;
  File? selectedImage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController zipCodeController = TextEditingController();

  final fieldValidator = MultiValidator([
    RequiredValidator(errorText: 'Field is required'),
    LengthRangeValidator(min: 5, max: 5, errorText: 'Zip code must be 5 digits'),

  ]);

  Future<void> _saveData(BuildContext context) async {
     await ref.read(locationPermissionProvider.notifier).processZipCodeEnteredByUser(
          zipCodeController.text,
        );
     Navigator.of(context).pop();
     await ref.read(profileRepositoryProvider.notifier).getUserProfileData();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      height: 310,
      padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 20,
                  width: 20,
                  child: Image.asset(
                    "x_close.png".assetImageUrl,
                  ),
                ),
              ),
            ),
            Container(
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset('location_image_pin.jpg'.assetImageUrl,
                      fit: BoxFit.cover),
                )),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                hintText: "Enter zip code",
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
              controller: zipCodeController,
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: double.infinity,
              child: Consumer(
                builder: (context, ref, child) =>
                    ref.watch(locationPermissionProvider).maybeWhen(
                          () => ElevatedButton(
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
                            child: Text(
                              "Save",
                              style: TextStyle(fontFamily: robotoFont),
                            ),
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
                            child: Text(
                              "Save",
                              style: TextStyle(fontFamily: robotoFont),
                            ),
                          ),
                          loading: () => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
