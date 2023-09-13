import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () => onClick.call(),
        child: Card(
          elevation: 5,
          child: Container(
              //surfaceTintColor: Colors.white,
              // shape: RoundedRectangleBorder(),
              //elevation: 2,
              decoration: BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(16),),
                        color: Colors.white,
                boxShadow: [BoxShadow(blurRadius: 1.1,color: Colors.white)],
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.white,width: 5)

              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              fontWeight: FontWeight.bold,
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
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: 20,
                        width: 20,
                        child: SvgPicture.asset(
                          "add_icon.svg".assetImageUrl,
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
