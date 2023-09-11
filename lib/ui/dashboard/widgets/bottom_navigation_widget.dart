import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/dashboard/provider/dashboard_controller_provider.dart';
import 'package:spenza/ui/dashboard/widgets/bottom_nav_model.dart';
import 'package:spenza/utils/color_utils.dart';
import 'package:spenza/utils/spenza_extensions.dart';

class BottomNavigationWidget extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;

  const BottomNavigationWidget({Key? key, required this.navigationShell})
      : super(key: key);

  @override
  ConsumerState<BottomNavigationWidget> createState() =>
      _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState
    extends ConsumerState<BottomNavigationWidget> {
  final List<CustomBottomNavItem> customBottomNavItems = [
    CustomBottomNavItem.fromSvgAsset(iconAsset: 'home_icon.svg', label: 'Home'),
    // CustomBottomNavItem.fromSvgAsset(iconAsset: 'store_icon.svg', label: 'Stores'),
    CustomBottomNavItem.fromSvgAsset(
        iconAsset: 'my_list_icon.svg', label: 'My Lists'),
    CustomBottomNavItem.fromSvgAsset(
        iconAsset: 'receipts_icon.svg', label: 'Receipts'),
    // CustomBottomNavItem.fromSvgAsset(iconAsset: 'preloaded_list_icon.svg', label: 'Preloaded'),
    CustomBottomNavItem.fromSvgAsset(
        iconAsset: 'account_icon.svg', label: 'Account'),
    // Add more items as needed
  ];

  @override
  void initState() {
    super.initState();
  }

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final position = widget.navigationShell.currentIndex;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 1,
          ),
        ],
        /*border: Border(
          top: BorderSide(color: Colors.grey, width: 1.0),
        ),*/
      ),
      child: BottomNavigationBar(
        currentIndex: position,
        onTap: _goBranch,
        selectedItemColor: ColorUtils.colorPrimary,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: ColorUtils.bottomNavIconAndTextColor,
        selectedLabelStyle: const TextStyle(
          color: ColorUtils.colorPrimary,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: const TextStyle(
          color: ColorUtils.bottomNavIconAndTextColor,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
        items: customBottomNavItems.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;

          if (item.iconAsset is String) {
            // If iconAsset is a String, assume it's an SVG asset

            Color color = ColorUtils.bottomNavIconAndTextColor;
            if (index == position) {
              color = ColorUtils.colorPrimary;
            }

            return BottomNavigationBarItem(
              icon: Container(
                height: 20,
                width: 20,
                child: SvgPicture.asset(
                  item.iconAsset
                      .toString()
                      .assetSvgIconUrl, // Use the SVG asset path
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                ),
              ),
              label: item.label,
            );
          } else {
            // Handle other cases if needed
            return BottomNavigationBarItem(
              icon: Icon(Icons.error), // Placeholder icon for unknown cases
              label: 'Unknown',
            );
          }
        }).toList(),
      ),
    );
  }

  void _onTap(int index) {
    final position = ref.read(selectedIndexProvider);
    if (position == index) {
      return;
    }

    ref.read(selectedIndexProvider.notifier).state = index;

    switch (index) {
      case 0:
        context.goNamed(RouteManager.homeScreen);
        break;

      case 1:
        context.pushNamed(RouteManager.myListScreenBottomPath);
        break;

      case 2:
        context.pushNamed(RouteManager.receiptListScreenBottomPath);
        break;

      case 3:
        // hasBackStackEntry(RouteManager.profileScreenBottomPath);
        context.pushNamed(RouteManager.settingsScreenBottomPath);
        break;
      default:
    }
  }

  bool hasBackStackEntry(String routePath) {
    final router = GoRouterState.of(context);
    var hasLocation = false;
    while (router.location != routePath) {
      debugPrint('Found ${router.location}');
    }

    return hasLocation;
  }
}
