import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/color_utils.dart';

class ImageTextCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback onTap;

  const ImageTextCard({
    required this.imageUrl,
    required this.title,
    required this.onTap,
  });


  @override
  Widget build(BuildContext context) {
    final robotoFont = GoogleFonts.roboto().fontFamily;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        //padding: EdgeInsets.all(4.0),
        width: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    width: 110,
                    height: 110,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              title,
              style:  TextStyle(
                fontFamily: robotoFont,
                decoration: TextDecoration.none,
                color: ColorUtils.primaryText,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),

          ],
        ),
      ),
    );
  }
}