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
  const BottomNavigationWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<BottomNavigationWidget> createState() =>
      _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState
    extends ConsumerState<BottomNavigationWidget> {
  final List<CustomBottomNavItem> customBottomNavItems = [
    CustomBottomNavItem.fromSvgAsset(iconAsset: 'home_icon.svg', label: 'Home'),
    CustomBottomNavItem.fromSvgAsset(
        iconAsset: 'store_icon.svg', label: 'Stores'),
    CustomBottomNavItem.fromSvgAsset(
        iconAsset: 'my_list_icon.svg', label: 'My List'),
    CustomBottomNavItem.fromSvgAsset(
      iconAsset: 'preloaded_list_icon.svg',
      label: 'Preloaded',
    ),
    CustomBottomNavItem(
      iconAsset: Icons.account_circle,
      label: 'Account',
    ),
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    final position = ref.watch(selectedIndexProvider);

    return Visibility(
      visible: false,
      child: NavigationBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        selectedIndex: position,
        onDestinationSelected: (value) => _onTap(value),
        destinations: customBottomNavItems.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;

          Color color = Colors.grey;
          if (index == position) {
            color = ColorUtils.colorPrimary;
          }
          if (item.iconAsset is String) {
            // If iconAsset is a String, assume it's an SVG asset

            return NavigationDestination(
              icon: Container(
                height: 22,
                width: 22,
                child: SvgPicture.asset(
                  item.iconAsset
                      .toString()
                      .assetSvgIconUrl, // Use the SVG asset path
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                ),
              ),
              label: item.label,
            );
          } else if (item.iconAsset is IconData) {
            // If iconAsset is IconData, use it as-is
            return NavigationDestination(
              icon: Icon(
                item.iconAsset, // Use the IconData
              ),
              label: item.label,
            );
          } else {
            // Handle other cases if needed
            return NavigationDestination(
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
        context.goNamed(RouteManager.storeScreenBottomPath);
        break;

      case 2:
        context.goNamed(RouteManager.myListScreenBottomPath);
        break;

      case 3:
        context.goNamed(RouteManager.preloadedListScreenBottomPath);
        break;
      /*case 4:
        context.goNamed(RouteManager.displayReceiptScreen);
        break;*/

      case 4:
        context.goNamed(RouteManager.profileScreenBottomPath);
        break;
      default:
    }
  }
}
