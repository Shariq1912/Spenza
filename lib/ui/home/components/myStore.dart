import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/my_store/data/all_store.dart';

import '../../../utils/color_utils.dart';
import 'image_text_card.dart';

class MyStores extends StatelessWidget {
  final List<AllStores> data;
  final String title;
  final TextStyle poppinsFont;
  final VoidCallback onAllStoreClicked;

  MyStores({
    required this.data,
    required this.title,
    required this.poppinsFont,
    required this.onAllStoreClicked,
  });
  final arialFont = GoogleFonts.openSans().fontFamily;
  final poppinFont = GoogleFonts.poppins().fontFamily;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            onAllStoreClicked();
          },
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: ColorUtils.primaryText,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      fontFamily: poppinFont,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                      Icons.arrow_forward_ios,
                      color: ColorUtils.primaryText,
                      size: 18,
                    ),
                ),
              ),
            ],
          ),
        ),
        /*SizedBox(height: 10),*/
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: data.isNotEmpty
              ? Container(
            height: 200, // Adjust the height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (context, index) {
                AllStores store = data[index];
                return ImageTextCard(
                  imageUrl: store.logo,
                  title: store.name,
                  onTap: () {
                    context.pushNamed(
                      RouteManager.myStoreProductScreen,
                      queryParameters: {
                        "store_id": store.documentId!,
                        "logo": store.logo,
                      },
                    );
                  },
                );
              },
            ),
          )
              : Center(
            child: Text(
              "No stores available.",
              style: TextStyle(
                fontSize: 16,
                fontFamily: poppinsFont.fontFamily,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

