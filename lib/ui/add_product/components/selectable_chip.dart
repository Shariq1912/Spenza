import 'package:flutter/material.dart';
import 'package:spenza/utils/color_utils.dart';

class SelectableChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onSelect;
  final VoidCallback? onDeselect;

  const SelectableChip({
    this.label = "All",
    this.isSelected = false,
    this.onSelect,
    this.onDeselect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isSelected) {
          onDeselect?.call();
        } else {
          onSelect?.call();
        }
      },
      child: Material(
        child: Chip(
          label: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
          backgroundColor: isSelected ? ColorUtils.colorPrimary : Colors.grey.shade200,
        ),
      ),
    );
  }
}
