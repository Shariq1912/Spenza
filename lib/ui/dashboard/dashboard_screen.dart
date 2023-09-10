import 'package:flutter/material.dart';
import 'package:spenza/ui/common/spenza_circular_progress.dart';
import 'package:spenza/ui/home/components/shimmer_items/home_shimmer_list_view.dart';

import 'widgets/bottom_navigation_widget.dart';

class DashboardScreen extends StatelessWidget {
  final Widget child;

  const DashboardScreen({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
