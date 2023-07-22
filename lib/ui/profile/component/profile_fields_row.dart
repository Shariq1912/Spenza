import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/*class ProfileFieldRow extends StatelessWidget {
  final String name1;
  final String name2;

  ProfileFieldRow({required this.name1, required this.name2});

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
            SizedBox(
              width: 30,
            ),
            Expanded(
              flex: 2,
              child: Text(
                name2,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: poppinsFont
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10,)
      ],
    );
  }
}*/

class ProfileFieldRow extends StatelessWidget {
  final String name1;
  final String name2;
  final bool isEditing;

  ProfileFieldRow({
    required this.name1,
    required this.name2,
    required this.isEditing,
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
              child: isEditing
                  ? TextField(
                decoration: InputDecoration(
                  hintText: name2,
                ),
              )
                  : Text(
                name2,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: poppinsFont,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10,)
      ],
    );
  }
}
