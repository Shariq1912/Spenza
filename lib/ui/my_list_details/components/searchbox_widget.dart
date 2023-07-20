import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const SearchBox({required this.controller, this.onChanged, required this.hint});

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: GestureDetector(
        onTap: () {
          // When the user taps outside the text field, unfocus it
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.grey),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: controller,
                    onChanged: onChanged,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) {
                      // Perform search or any other action when the user presses the search button on the keyboard.
                      // Here, we can handle the search logic.
                      // Example:
                      _performSearch();
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

  // Example function for handling the search action.
  void _performSearch() {
    print('Performing search...');
    // Implement your search logic here.
  }
}
