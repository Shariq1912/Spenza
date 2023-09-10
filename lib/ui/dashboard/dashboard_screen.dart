import 'package:flutter/material.dart';
import 'package:go_router/src/route.dart';
import 'package:spenza/ui/common/spenza_circular_progress.dart';
import 'package:spenza/ui/home/components/shimmer_items/home_shimmer_list_view.dart';

import 'widgets/bottom_navigation_widget.dart';

class DashboardScreen extends StatelessWidget {
  // final Widget child;
  // final String location;
  final StatefulNavigationShell navigationShell;

  // const DashboardScreen({Key? key, required this.child, required this.location}) : super(key: key);
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
