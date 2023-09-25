import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/ui/add_product/data/user_product.dart';
import 'package:spenza/ui/my_list_details/provider/user_product_list_provider.dart';
import 'package:spenza/utils/color_utils.dart';
import 'package:spenza/utils/spenza_extensions.dart';

class PreloadedProductCard extends ConsumerWidget {
  final String imageUrl;
  final String title;
  final String priceRange;
  final String department;
  final String listId;
  final String measure;
  final UserProduct product;
  final bool isLastCard;

  // final Function(int quantity) quantity;

  const PreloadedProductCard({
    required this.imageUrl,
    required this.title,
    required this.department,
    required this.priceRange,
    required this.product,
    required this.measure,
    required this.listId,
    required this.isLastCard,
  });

  @override
  Widget build(BuildContext context, ref) {
    final robotoFont = GoogleFonts.roboto().fontFamily;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0.0, right: 0.0),
          child: Divider(
            height: 1,
            color: ColorUtils.colorSurface,
          ),
        ),
        Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              color: Colors.white,
              margin: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      errorWidget: (context, url, error) => Image.asset(
                        "app_icon_spenza.png".assetImageUrl,
                        fit: BoxFit.fill,
                        width: 110,
                        height: 110,
                      ),
                      imageUrl: imageUrl,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          department.length > 16
                              ? '${department.substring(0, 16)}...'
                              : department,
                          style: TextStyle(
                            fontFamily: robotoFont,
                            fontSize: 12,
                            color: Color(0xFF7B868C),
                          ),
                        ),
                        Text(
                          title,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF323E48),
                              fontFamily: robotoFont),
                        ),
                        /*Text(
                            priceRange,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),*/
                        const SizedBox(height: 38),
                        Text(
                          measure,
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF323E48),
                              fontFamily: robotoFont),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: () {
                            ref
                                .read(userProductListProvider.notifier)
                                .updateUserProductList(
                                  product: product,
                                  quantity: product.quantity + 1,
                                );
                          },
                          child: Container(
                            height: 20,
                            width: 20,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                "plus_blue.png".assetImageUrl,
                              ),
                            ),
                          ),),
                      SizedBox(height: 15),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          product.quantity.toString().padLeft(2, '0'),
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF323E48),
                              fontFamily: robotoFont,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(height: 15),
                      InkWell(
                          onTap: () {
                            if (product.quantity > 1) {
                              ref
                                  .read(userProductListProvider.notifier)
                                  .updateUserProductList(
                                    product: product,
                                    quantity: product.quantity - 1,
                                  );
                            }
                          },
                          child: Container(
                            height: 20,
                            width: 20,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                "minus_blue.png".assetImageUrl,
                              ),
                            ),
                          ),),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Divider(
            height: 1,
            color: ColorUtils.colorSurface,
          ),
        ),
        if (isLastCard) // Conditionally render the extra container
          Container(
            height: 110, // Adjust the height as needed
            color: Colors.transparent, // Set the color as per your design
          ),
      ],
    );
  }
}
