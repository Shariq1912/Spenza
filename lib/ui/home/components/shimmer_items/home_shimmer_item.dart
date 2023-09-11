import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmerItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              width: 100,
              height: 100,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: 80,
            height: 10,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
