import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spenza/ui/home/components/shimmer_items/home_shimmer_item.dart';

class ShimmeringHeaderRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 8, // Adjust the height as needed
          color: Colors.white,
        ),
      ],
    );
  }
}

class HomeShimmerListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Expanded(
        child: Column(
          children: [
            ShimmeringHeaderRow(),
            SizedBox(height: 8),
            Row(
              children: List.generate(
                3, // Number of shimmer items
                (index) => HomeShimmerItem(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
