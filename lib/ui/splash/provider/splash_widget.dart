import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spenza/router/app_router.dart';

import '../../../utils/color_utils.dart';

class SplashWidget extends ConsumerStatefulWidget {
  @override
  ConsumerState<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends ConsumerState<SplashWidget> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      context.goNamed(RouteManager.splashScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    SvgPicture.asset(
                      'assets/images/spenza_white.svg',
                     // colorFilter: ColorFilter.mode(Colors.red, BlendMode.color),
                      fit: BoxFit.fitWidth,
                      width: 50,
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
