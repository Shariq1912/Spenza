import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/profile/profile_screen.dart';
import 'package:spenza/utils/color_utils.dart';
import 'package:spenza/utils/spenza_extensions.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String priceRange;
  final String measure;
  final VoidCallback onClick;
  final bool isPriceRangeVisible;
  final int quantity;
  final Function(bool hasIncreased)? quantityChanged;

  const ProductCard({
    required this.imageUrl,
    required this.title,
    required this.priceRange,
    required this.measure,
    required this.onClick,
    this.isPriceRangeVisible = true,
    this.quantity = 0,
    this.quantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    final robotoFont = GoogleFonts.roboto().fontFamily;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: GestureDetector(
        onTap: () => onClick.call(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Divider(
                height: 1,
                color: ColorUtils.colorSurface,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>
                            Image.asset('app_icon_spenza.png'.assetImageUrl)),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13, fontFamily: robotoFont),
                        ),
                        SizedBox(height: 3),
                        Text(
                          measure,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: robotoFont
                          ),
                        ),
                        SizedBox(height: 18),
                        Text(
                          priceRange,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 13,
                          fontFamily: robotoFont),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: quantity > 0
                        ? _buildQuantityModifier()
                        : _buildAddIcon(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Divider(
                height: 1,
                color: ColorUtils.colorSurface,
              ),
            ),
          ],
        ),
        // ),
      ),
    );
  }

  _buildQuantityModifier() {
    return Container(
      alignment: AlignmentDirectional.topEnd,
      padding: EdgeInsets.only(right: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              quantityChanged?.call(true);
            },
            child: Container(
              height: 20,
              width: 20,
              child: Image.asset(
                "add_icon.png".assetImageUrl,
              ),
            ),
          ),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              quantity.toString().padLeft(2, '0'),
              style: TextStyle(
                  fontSize: 14,
                  color: ColorUtils.primaryText,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: 15),
          InkWell(
            onTap: () {
              quantityChanged?.call(false);
            },
            child: Container(
              height: 20,
              width: 20,
              child: Image.asset(
                "Minus_GW.png".assetImageUrl,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildAddIcon() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          height: 20,
          width: 20,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              "plus_blue.png".assetImageUrl,
            ),
          ),
        ),
      ),
    );
  }
  Widget buildMaterialButton(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          context.pop();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0CA9E6),
          foregroundColor: Colors.white,
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: poppinsFont,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: const BorderSide(color: Color(0xFF99D6EF)),
          ),
          //fixedSize: const Size(310, 40),
        ),
        child: Text(
          priceRange,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 13,
              ),
        ),
      ),
    );
  }
}