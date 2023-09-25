import 'package:flutter/material.dart';
import 'package:spenza/utils/color_utils.dart';

class SearchBox extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final ValueChanged<String>? onSearch;
  final VoidCallback? onSearchClick;
  final FocusNode? focusNode; // Callback for focus change
  final Color colors;
  final bool isEnabled;

  const SearchBox({
    required this.controller,
    this.onSearch,
    this.onSearchClick,
    required this.hint,
    this.focusNode,
    this.isEnabled = true,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: GestureDetector(
        onTap: () {
          onSearchClick?.call();
        },
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: colors,
              border: Border.all(color: ColorUtils.colorSurface),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.grey),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    enabled: isEnabled,
                    focusNode: focusNode,
                    controller: controller,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) {
                      // Perform search or any other action when the user presses the search button on the keyboard.
                      // Here, we can handle the search logic.
                      // Example:

                      if (controller.text.isNotEmpty) {
                        print('Performing search...');
                        onSearch!(controller.text);
                      }
                    },
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey.shade700),
                      border: InputBorder.none,
                      hintText: hint,
                    ),
                    style: TextStyle(color:  Colors.grey.shade700), // Set the text color to black
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
