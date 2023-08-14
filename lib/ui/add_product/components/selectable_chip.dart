import 'package:flutter/material.dart';
import 'package:spenza/utils/color_utils.dart';

class SelectableChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function(bool isSelected)? onSelected;

  const SelectableChip({
    this.label = "All",
    this.isSelected = false,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelected?.call(!isSelected);
      },
      child: Material(
        child: Chip(
          label: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
          backgroundColor:
              isSelected ? ColorUtils.colorPrimary : Colors.grey.shade200,
        ),
      ),
    );
  }
}
