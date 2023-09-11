import 'package:flutter/material.dart';
import 'package:go_router/src/route.dart';

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
