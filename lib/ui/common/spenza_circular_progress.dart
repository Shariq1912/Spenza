import 'package:flutter/material.dart';
import 'package:spenza/utils/color_utils.dart';
import 'package:spenza/utils/spenza_extensions.dart';


class SpenzaCircularProgress extends StatelessWidget {
  const SpenzaCircularProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'spenza_cart_blue.png'.assetImageUrl,
            fit: BoxFit.cover,
            height: 50,
            width: 50,
          ),
          Positioned.fill(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(ColorUtils.colorSecondary),
              strokeWidth: 3.0,
            ),
          ),
        ],
      ),
    );
  }
}
