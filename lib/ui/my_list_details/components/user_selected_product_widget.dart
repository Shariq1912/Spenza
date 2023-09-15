import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/ui/add_product/data/user_product.dart';
import 'package:spenza/ui/my_list_details/provider/user_product_list_provider.dart';
import 'package:spenza/utils/color_utils.dart';
import 'package:spenza/utils/spenza_extensions.dart';

class UserSelectedProductCard extends ConsumerWidget {
  final String imageUrl;
  final String title;
  final String priceRange;
  final String department;
  final String listId;
  final String measure;
  final UserProduct product;

  // final Function(int quantity) quantity;

  const UserSelectedProductCard({
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
    final poppinsFont = GoogleFonts.poppins().fontFamily;
    final robotoFont = GoogleFonts.roboto().fontFamily;
    return Slidable(
      key: ValueKey(product.productId),
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        extentRatio: 0.25,
        children:  [
          SlidableAction(
            onPressed: (context){
              ref
                  .read(userProductListProvider.notifier)
                  .deleteProductFromUserList(
                listId: listId,
                product: product,
              );
            },
            backgroundColor: Color(0xFF7B868C),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),

        ],
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          surfaceTintColor: Colors.white,
          color: Colors.white,
          elevation: 2,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
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
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF323E48),
                              fontFamily: robotoFont
                            ),
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
                              fontFamily: robotoFont
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12),
                    /*Column(
                      children: [
                        SizedBox(
                          height: 62,
                        ),
                        Row(
                          children: [
                            GestureDetector(
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
                                padding: EdgeInsets.symmetric(
                                     horizontal: 4),
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF555C62)),
                                ),
                              ),
                            ),
                            SizedBox(width: 2),
                            *//*Container(
                              padding: EdgeInsets.symmetric(
                                   horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                // Set the background color to white
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.3)),
                              ),
                              child: Text(
                                product.quantity.toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: ColorUtils.colorPrimary,
                                ),
                              ),
                            ),
                            SizedBox(width: 2),
                            GestureDetector(
                              onTap: () => ref
                                  .read(userProductListProvider.notifier)
                                  .updateUserProductList(
                                    product: product,
                                    quantity: product.quantity + 1,
                                  ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                     horizontal: 4),
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF555C62)),
                                ),
                              ),
                            ),
                            SizedBox(width: 4),*//*

                          ],
                        ),
                      ],
                    ),*/
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: (){
                              ref
                                  .read(userProductListProvider.notifier)
                                  .updateUserProductList(
                                product: product,
                                quantity: product.quantity + 1,
                              );
                            },
                            child: Icon(CupertinoIcons.add_circled,color: ColorUtils.primaryText,)
                        ),
                        SizedBox(height: 11),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10),
                          child: Text(
                            product.quantity.toString().padLeft(2, '0'),
                            style: TextStyle(
                                fontSize: 14,
                                color: ColorUtils.primaryText,
                                fontFamily: robotoFont,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                        SizedBox(height: 11),
                        InkWell(
                            onTap: (){
                              if (product.quantity > 1) {
                                ref
                                    .read(userProductListProvider.notifier)
                                    .updateUserProductList(
                                  product: product,
                                  quantity: product.quantity - 1,
                                );
                              }
                            },
                            child: Icon(CupertinoIcons.minus_circle,color: ColorUtils.primaryText,)
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
