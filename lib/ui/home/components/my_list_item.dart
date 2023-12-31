import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/utils/spenza_extensions.dart';

import '../../../utils/color_utils.dart';

class MyListItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String description;
  final VoidCallback onTap;

  const MyListItem({
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.onTap,
  });



  @override
  Widget build(BuildContext context) {
    final arialFont = GoogleFonts.openSans().fontFamily;
    final robotoFont = GoogleFonts.roboto().fontFamily;
    Color textColor = name == "New List" ? ColorUtils.colorPrimary : ColorUtils.primaryText;

    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          leadingWidget(imageUrl),
          SizedBox(height: 6),
          Text(
            name.length > 13 ? '${name.substring(0, 13)}...' : name,
            style:  TextStyle(
              fontFamily: robotoFont,
              decoration: TextDecoration.none,
              color: textColor,
              //fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }


  Widget leadingWidget(String fileName) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: CachedNetworkImage(
          errorWidget: (context, url, error) => Stack(
            children: [
              Image.asset(
                "add_new_list_button.png".assetImageUrl,
                fit: BoxFit.fill,
                width: 110,
                height: 110,
              ),

            ],
          ),
          imageUrl: fileName,
          fit: BoxFit.fill,
          width: 110,
          height: 110,
        ),
      ),
    );


  }

}
