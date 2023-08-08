import 'package:flutter/material.dart';

import '../data/departments_data.dart';

class ChipsWidget extends StatelessWidget {
  final List<DepartmentDataClass> departments;
  final List<String> selectedChips;
  final Function(String) onChipSelected;

  ChipsWidget({
  required this.departments,
  required this.selectedChips,
  required this.onChipSelected,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: departments.length,
        itemBuilder: (context, index) {
          final department = departments[index];
          final isSelected = selectedChips.contains(department.name);

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                onChipSelected(department.name);
              },
              child: Chip(
                label: Text(department.name),
                backgroundColor: isSelected ? const Color(0xFF0CA9E6) : Colors.white,
                labelStyle:
                TextStyle(color: isSelected ? Colors.white : Colors.black),
              ),
            ),
          );
        },
      ),
    );
  }

}
