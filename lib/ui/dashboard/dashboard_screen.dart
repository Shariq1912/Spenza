import 'package:flutter/material.dart';
import 'package:go_router/src/route.dart';
import 'package:spenza/ui/my_list_details/components/searchbox_widget.dart';
import 'package:spenza/utils/searchbox_delegate.dart';

import 'widgets/bottom_navigation_widget.dart';

class DashboardScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const DashboardScreen({Key? key, required this.navigationShell})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationWidget(
        navigationShell: navigationShell,
      ),
    );
  }
}

class CoolApp extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  void _openSearchDelegate(BuildContext context) async {
    final String? query = await showSearch(
      context: context,
      delegate: SearchBoxDelegate(), // Your custom search delegate
    );
    if (query != null && query.isNotEmpty) {
      // Handle the search query
      print('Search query from delegate: $query');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Custom Search Bar Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SearchBox(
                colors: Colors.white,
                controller: _searchController,
                hint: "Search Product",
                onSearch: (value) {
                  _openSearchDelegate(context); // Open search delegate on tap
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Open search results or perform search action
                  final query = _searchController.text;
                  print('Search query: $query');
                },
                child: Text('Search'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


