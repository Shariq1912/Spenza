import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:spenza/utils/color_utils.dart';

class MatchingStoreCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String totalPrice;
  final String distance;
  final String address;
  final int matchingPercentage;
  final bool isCheapestVisible;
  final bool isFavouriteStore;
  final VoidCallback onClick;

  const MatchingStoreCard({
    required this.imageUrl,
    required this.title,
    required this.totalPrice,
    required this.matchingPercentage,
    required this.address,
    required this.distance,
    this.isCheapestVisible = true,
    this.isFavouriteStore = false,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick.call(),
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 4.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$matchingPercentage% Match",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: ColorUtils.colorPrimary,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 14,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 90,
                              width: 90,
                              child: CachedNetworkImage(
                                imageUrl: imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // Position the heart icon on the top right corner
                            Positioned(
                              top: 1,
                              right: 5,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(8.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      blurRadius: 5,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: isFavouriteStore
                                    ? Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                        size: 20,
                                      )
                                    : Icon(
                                        Icons.favorite_border,
                                        color: Colors.grey[400],
                                        size: 20,
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              address,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 18),
                            Container(
                              // Wrap the distance text in a container
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 4),
                              color: Colors.white,
                              child: Text(
                                distance,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: ColorUtils.colorPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: false,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _getColorForPercentage(matchingPercentage),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text(
                        "$matchingPercentage% Match",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    bottom: 3,
                    child: Text(
                      '\$ $totalPrice', // Display the actual price here
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getColorForPercentage(int percentage) {
    if (percentage > 80) {
      return Colors.green;
    } else if (percentage >= 30) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}
