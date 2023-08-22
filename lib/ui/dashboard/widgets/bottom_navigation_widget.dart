import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/dashboard/provider/dashboard_controller_provider.dart';
import 'package:spenza/utils/color_utils.dart';

class BottomNavigationWidget extends ConsumerStatefulWidget {
  const BottomNavigationWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<BottomNavigationWidget> createState() =>
      _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState
    extends ConsumerState<BottomNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    final position = ref.watch(selectedIndexProvider);

    return BottomNavigationBar(
      currentIndex: position,
      onTap: (value) => _onTap(value),
      selectedItemColor: ColorUtils.colorPrimary,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(
        color: ColorUtils.colorPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelStyle: const TextStyle(
        color: Colors.grey,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.house), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Stores'),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: 'My List'),
        BottomNavigationBarItem(icon: Icon(Icons.lock_reset_outlined), label: 'Preloaded'),
        BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Receipts'),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Account'),
      ],
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

      case 5:
        context.goNamed(RouteManager.profileScreenBottomPath);
        break;
      default:
    }
  }
}
