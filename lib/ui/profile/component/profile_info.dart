import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class ProfileInfo extends StatelessWidget{
  final String name1;
  final String value;

  ProfileInfo({
    required this.name1,
    required this.value,

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
              child:  Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: poppinsFont,
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