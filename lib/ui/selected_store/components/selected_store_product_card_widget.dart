import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SelectedStoreProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;
  final String measure;
  final int quantity;
  final VoidCallback onClick;
  final bool isMissing;

  const SelectedStoreProductCard({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.measure,
    required this.quantity,
    required this.isMissing,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () => onClick.call(),
        child: Card(
          elevation: 2,
          child: Padding(
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
                        title,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "\$ $price / $measure",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [

                    if (!isMissing) ...[
                      Text(
                        "$quantity $measure",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "\$ ${price * quantity}",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],

                    if(isMissing) ...[
                      Text(
                        "${measure == "kg" ? "1 kg" : measure}",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ]

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
