import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spenza/ui/splash/provider/splash_provider.dart';
import 'package:spenza/utils/color_utils.dart';
import 'package:spenza/utils/spenza_extensions.dart';

class SplashScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    /*Future.delayed(Duration(seconds: 2), () {
      context.goNamed(RouteManager.splashScreen);
    });*/

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  _loadData() async {
    ref.read(splashProvider.notifier).isLoggedIn();
  }

  @override
  void dispose() {
    ref.invalidate(splashProvider);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(splashProvider, (previous, next) {
      next.maybeWhen(
        data: (data) {
          if (data == null) {
            return;
          }
          Future.delayed(Duration(seconds: 1), () {
            context.goNamed(data);
          });

        },
        error: (error, stackTrace) =>
            context.showSnackBar(message: "Something went wrong!"),
        orElse: () {},
      );
    });

    return Scaffold(
      body: Container(
        color: ColorUtils.colorPrimary,
        child: Center(
          child: TweenAnimationBuilder<double>(
            duration: Duration(seconds: 2),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (BuildContext context, double value, Widget? child) {
              return Opacity(
                opacity: value,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/LOGO_Spenza-letters-white.png',
                      // colorFilter: ColorFilter.mode(Colors.red, BlendMode.color),
                      fit: BoxFit.fitWidth,
                      width: 230,
                      height: 100,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
