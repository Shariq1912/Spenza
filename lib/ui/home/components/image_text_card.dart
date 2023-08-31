import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageTextCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback onTap;

  const ImageTextCard({
    required this.imageUrl,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 150,
        child: Card(
          elevation: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    width: 130,
                    height: 130,
                  ),
                ],
              ),
              Text(
                title,
                style: const TextStyle(
                  decoration: TextDecoration.none,
                  color: Color(0xFF0CA9EA),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),

            ],
          ),
        ),
      ),
    );
  }
}