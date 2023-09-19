import 'package:flutter/material.dart';
import 'package:spenza/utils/color_utils.dart';

class SearchBox extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final ValueChanged<String>? onSearch;
  final FocusNode? focusNode; // Callback for focus change
  final Color colors; // Callback for focus change

  const SearchBox({
    required this.controller,
    this.onSearch,
    required this.hint,
    this.focusNode,
    required this.colors
  });

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: GestureDetector(
        onTap: () {
          // When the user taps outside the text field, unfocus it
          FocusScope.of(context).unfocus();
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
                      border: InputBorder.none,
                      hintText: hint,
                    ),
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
