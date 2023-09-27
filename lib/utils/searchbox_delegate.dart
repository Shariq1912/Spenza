import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spenza/utils/color_utils.dart';
import "package:collection/collection.dart";
import 'package:spenza/utils/spenza_extensions.dart';

class SearchBoxDelegate extends SearchDelegate<String> {
  final data = ["Tomate", "Milk",  "Egg", "Ketchup"];

  /*@override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.white,
        primary: Colors.white,
        onPrimary: ColorUtils.colorWhite,
        // secondary: ColorUtils.colorSecondary,
        // onSecondary: ColorUtils.colorWhite,
        // error: ColorUtils.colorError,
        // onError: ColorUtils.colorWhite,
        // background: ColorUtils.lightGrey,
        // onBackground: ColorUtils.colorPrimaryText,
      ),
      useMaterial3: true,
    );
  }*/

  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions for the search bar (e.g., clear button).
    return [
      IconButton(
        onPressed: () {
            query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading icon or widget (e.g., back button).
    return GestureDetector(
      onTap: () {
        close(context, '');
        context.pop();
      },
      child: Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: Image.asset(
            "back_Icon_blue.png".assetImageUrl,
          ),
        ),
      ),
    );
  }

  @override
  // ignore: missing_return
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) {
      close(context, query);
      context.pop();
    }
    return Container();
  }
  @override
  void showResults(BuildContext context) {
    close(context, query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Suggestions while the user is typing the query.
    // You can customize the suggestion UI here.

    print("Query Suggestion ==== $query");
    final filteredData = data.where(
      (element) {
        final trimmedQuery = query.trim().toLowerCase();
        final trimmedElement = element.trim().toLowerCase();

        return trimmedElement.startsWith(trimmedQuery);

        // element.toLowerCase().contains(query.trim().toLowerCase())
      },
    ).toList();

    return ListView.builder(
      itemCount: filteredData.length,
      itemBuilder: (context, index) {
        final item = filteredData[index];

        return ListTile(
          title: Text("$item "),
          onTap: () {
            // query = 'Suggestion $index';
            close(context, item);
          },
        );
      },
    );
  }
}
