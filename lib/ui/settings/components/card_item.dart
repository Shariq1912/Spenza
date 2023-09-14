import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/color_utils.dart';

class CardItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function()? onTap;

   CardItem({required this.icon, required this.title, this.onTap});
  final poppinsFont = GoogleFonts.poppins().fontFamily;

  @override
  Widget build(BuildContext context) {
    return Container(

      //surfaceTintColor: Color(0xFFE5E7E8),
      color: Color(0xFFE5E7E8),
      child: ListTile(
        leading: Icon(icon, color: Color(0xFF0CA9E6)),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontFamily: poppinsFont,
              color: ColorUtils.primaryText
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
