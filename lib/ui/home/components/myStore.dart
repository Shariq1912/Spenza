import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/my_store/data/all_store.dart';
import '../../my_store_products/my_store_product.dart';
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                title,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Color(0xFF0CA9E6),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: poppinsFont.fontFamily,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: onAllStoreClicked,
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFF0CA9E6),
                    size: 32,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Container(
            height: 150, // Adjust the height as needed
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
          ),
        ),
      ],
    );
  }
}
