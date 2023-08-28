import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/ui/location/data/zipcode_model.dart';
import 'package:spenza/utils/spenza_extensions.dart';

import '../zipcode_provider.dart';

class ZipCodeWidget extends ConsumerStatefulWidget {
  final TextEditingController zipCodeController;
  final GlobalKey<FormState> formKey;
  final VoidCallback onPressed;
  final MultiValidator validator;
  final List<int> zipcode;

  ZipCodeWidget({
    required this.zipCodeController,
    required this.formKey,
    required this.onPressed,
    required this.validator,
    required this.zipcode
  });

  @override
  ConsumerState<ZipCodeWidget> createState() => _ZipCodeWidgetState();
}

class _ZipCodeWidgetState extends ConsumerState<ZipCodeWidget> {
  final poppinsFont = GoogleFonts.poppins().fontFamily;

  List<int> zipCodeOptions = [
    67890,
    54321,
    12345,
  ];

  String? selectedZipCode;
  bool showDropdown = false;




  @override
  Widget build(BuildContext context) {
    print(" ztt${widget.zipcode}");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              child: ClipOval(
                child: Image.asset(
                  'location_image_pin.jpg'.assetImageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top:5),
              child: Text(
                'Nearby Stores',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontFamily: poppinsFont, color: Color(0xFF0CA9E6), fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top:5),
              child: Text(
                'Select your area to explore nearby stores',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontFamily: poppinsFont, color: Color(0xFF323e48)),
              ),
            ),
            SizedBox(height: 16),
            Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Form(
                  key: widget.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputDecorator(
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                          contentPadding: const EdgeInsets.only(left: 16, right: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Color(0xFFE5E7E8),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: widget.zipCodeController,
                                decoration: InputDecoration(
                                  hintText: 'Enter Zip code',
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                ),
                                validator: widget.validator,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  showDropdown = !showDropdown;
                                });
                              },
                              icon: Icon(showDropdown ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                            ),
                          ],
                        ),
                      ),
                      if (showDropdown)
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: widget.zipcode.map((zipCode) {
                              return ListTile(
                                title: Text(zipCode.toString()),
                                onTap: () {
                                  setState(() {
                                    selectedZipCode = zipCode.toString();
                                    widget.zipCodeController.text = zipCode.toString();
                                    showDropdown = false;
                                  });
                                },
                              );
                            }).toList(),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (widget.formKey.currentState!.validate()) {
                          widget.onPressed();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please enter the zip code.')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0CA9E6),
                        foregroundColor: Color(0xFF0CA9E6),
                        surfaceTintColor: Color(0xFF0CA9E6),
                        padding: const  EdgeInsets.only(bottom: 6, top: 6),
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: poppinsFont,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: const BorderSide(color: Color(0xFF99D6EF)),
                        ),
                        //fixedSize: const Size(310, 35),
                      ),
                      child: Text('Continue',style: TextStyle( fontFamily: poppinsFont, color: Colors.white, fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
