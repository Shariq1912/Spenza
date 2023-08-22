import 'package:flutter/material.dart';

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
