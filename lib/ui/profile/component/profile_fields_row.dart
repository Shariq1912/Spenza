import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';


class ProfileFieldRow extends StatelessWidget {
  final String name1;
  final TextEditingController controller;
  final bool isNumericField;

  ProfileFieldRow({
    required this.name1,
    required this.controller,
    this.isNumericField = false,

  });

  final poppinsFont = GoogleFonts.poppins().fontFamily;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                name1,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: poppinsFont,
                ),
              ),
            ),
            SizedBox(width: 30),
            Expanded(
              flex: 2,
              child: /* TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: name1,
                ),
              )*/
              TextFormField(
                controller: controller,
                keyboardType: isNumericField ? TextInputType.number : TextInputType.text,
                inputFormatters: isNumericField ? [FilteringTextInputFormatter.digitsOnly] : [],
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF0CA9E6)),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),

            ),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }
}

