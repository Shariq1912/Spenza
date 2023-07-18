import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function()? onTap;

   CardItem({required this.icon, required this.title, this.onTap});
  final poppinsFont = GoogleFonts.poppins().fontFamily;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        leading: Icon(icon, color: Color(0xFF0CA9E6)),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontFamily: poppinsFont,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
