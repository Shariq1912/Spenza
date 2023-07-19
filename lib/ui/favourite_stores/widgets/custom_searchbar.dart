import 'package:flutter/material.dart';

import '../data/favourite_stores.dart';
/*

class CustomSearchDelegate extends SearchDelegate {
  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Container();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

// second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }
}*/

class CustomSearchDelegate extends SearchDelegate<Stores> {
  final List<Stores> allStores;

  CustomSearchDelegate(this.allStores);

  @override
  Widget buildResults(BuildContext context) {
    // This method is called when the user taps on the "Search" button.
    // It should return the results of the search.
    final filteredStores = allStores
        .where((store) => store.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredStores.length,
      itemBuilder: (context, index) {
        final store = filteredStores[index];
        return ListTile(
          title: Text(store.name),
          onTap: () {
            // Close the search and return the selected store.
            close(context, store);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called when the user types in the search bar.
    // It should return a list of suggestions based on the user's input.
    final suggestions = allStores
        .where((store) => store.name
        .toLowerCase()
        .startsWith(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final store = suggestions[index];
        return ListTile(
          title: Text(store.name),
          onTap: () {
            // Update the query with the selected suggestion.
            query = store.name;
            // Refresh the results.
            showResults(context);
          },
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    // This method is called when the user clicks on the three dots in the search bar.
    // It should return a list of actions that the user can take.
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {

      },
      icon: Icon(Icons.arrow_back),
    );
  }
}
