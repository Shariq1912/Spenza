import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/utils/spenza_extensions.dart';

class ZipCodeWidget extends StatelessWidget {
  final TextEditingController zipCodeController;
  final GlobalKey<FormState> formKey;
  final VoidCallback onPressed;
  final MultiValidator validator;
  final poppinsFont = GoogleFonts.poppins().fontFamily;

  ZipCodeWidget({
    required this.zipCodeController,
    required this.formKey,
    required this.onPressed,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.asset(
            'marker.png'.assetImageUrl,
            fit: BoxFit.fitWidth,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Share your location with Spenza to find stores near you',
            style: TextStyle(fontSize: 14, fontFamily: poppinsFont),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            child: Form(
              key: formKey,
              child: TextFormField(
                controller: zipCodeController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF99D6EF)),
                  ),
                  hintText: 'Enter ZIP code',
                ),
                validator: validator,
                keyboardType: TextInputType.number,
              ),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                onPressed();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter the zip code.')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF0CA9E6),
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: poppinsFont,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: const BorderSide(color: Color(0xFF99D6EF)),
              ),
            ),
            child: Text('Get Location'),
          ),
        ],
      ),
    );
  }
}
