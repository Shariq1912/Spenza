import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spenza/utils/color_utils.dart';
import 'package:spenza/utils/spenza_extensions.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String priceRange;
  final String measure;
  final VoidCallback onClick;
  bool isPriceRangeVisible;

  ProductCard({
    required this.imageUrl,
    required this.title,
    required this.priceRange,
    required this.measure,
    required this.onClick,
    this.isPriceRangeVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: GestureDetector(
        onTap: () => onClick.call(),
        child: Container(
          color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          measure,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        if (isPriceRangeVisible) ...[
                          SizedBox(height: 4),
                          Text(
                            priceRange,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: 20,
                        width: 20,
                        child: Image.asset(
                          "add_icon.png".assetImageUrl,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
       // ),
      ),
    );
  }
}
