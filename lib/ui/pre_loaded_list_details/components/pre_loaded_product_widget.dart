import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spenza/ui/add_product/data/user_product.dart';
import 'package:spenza/ui/my_list_details/provider/user_product_list_provider.dart';
import 'package:spenza/utils/color_utils.dart';

class PreloadedProductCard extends ConsumerWidget {
  final String imageUrl;
  final String title;
  final String priceRange;
  final String department;
  final String listId;
  final String measure;
  final UserProduct product;

  // final Function(int quantity) quantity;

  const PreloadedProductCard({
    required this.imageUrl,
    required this.title,
    required this.department,
    required this.priceRange,
    required this.product,
    required this.measure,
    required this.listId,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 2,
        child: Stack(
          alignment: Alignment.topRight,
          // Align the delete icon to the top right
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          department,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          priceRange,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          measure,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  Row(
                    children: [

                      SizedBox(width: 4),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // Set the background color to white
                          border:
                              Border.all(color: Colors.black.withOpacity(0.3)),
                        ),
                        child: Text(
                          "x ${product.quantity}",
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorUtils.colorPrimary,
                          ),
                        ),
                      ),
                      SizedBox(width: 4),

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
