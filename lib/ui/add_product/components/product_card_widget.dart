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
        child: /*Container(
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
                      height: 90,
                      width: 90,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          Image.asset(
                              'app_icon_spenza.png'.assetImageUrl),
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
          )*/
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Card(
          surfaceTintColor: Color(0xFFE5E7E8),
          color: Color(0xFFE5E7E8),
          child: Padding(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 3),
                        Text(
                          measure,
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          priceRange,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
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
            ),
        // ),
      ),
    );
  }
}
