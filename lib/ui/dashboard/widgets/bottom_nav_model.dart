import 'package:flutter/material.dart';

class CustomBottomNavItem {
  final dynamic iconAsset;
  final String label;

  CustomBottomNavItem({
    required this.iconAsset,
    required this.label,
  });

  factory CustomBottomNavItem.fromSvgAsset({required String iconAsset, required String label}) {
    return CustomBottomNavItem(
      iconAsset: iconAsset, // Store the asset path as-is
      label: label,
    );
  }

  factory CustomBottomNavItem.fromIconData({required IconData iconAsset, required String label}) {
    return CustomBottomNavItem(
      iconAsset: iconAsset, // Store the IconData as-is
      label: label,
    );
  }
}
