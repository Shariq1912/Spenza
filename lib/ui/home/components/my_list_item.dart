import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spenza/utils/spenza_extensions.dart';

class MyListItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String description;
  final VoidCallback onTap;

  const MyListItem({
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          leadingWidget(imageUrl),
          SizedBox(height: 8),
          Text(
            // Use the '...' property to handle long text
            name.length > 20 ? '${name.substring(0, 20)}...' : name,
            style: const TextStyle(
              decoration: TextDecoration.none,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget leadingWidget(String fileName) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: CachedNetworkImage(
        errorWidget: (context, url, error) => Image.asset(
          "logo.png".assetImageUrl,
          fit: BoxFit.fill,
          width: 100,
          height: 130,
        ),
        placeholder: (context, url) => Image.asset(
          "logo.png".assetImageUrl,
          fit: BoxFit.fill,
          width: 100,
          height: 130,
        ),
        imageUrl: fileName,
        fit: BoxFit.fill,
        width: 120,
        height: 120,
      ),
    );
  }
}
