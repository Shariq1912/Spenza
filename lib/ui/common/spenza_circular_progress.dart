import 'package:flutter/material.dart';
import 'package:spenza/utils/color_utils.dart';
import 'package:spenza/utils/spenza_extensions.dart';

class SpenzaCircularProgress extends StatelessWidget {
  final String? label;

  const SpenzaCircularProgress({Key? key, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textSize = Theme.of(context).textTheme.bodyMedium?.fontSize;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
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
                  valueColor:
                      AlwaysStoppedAnimation<Color>(ColorUtils.colorSecondary),
                  strokeWidth: 3.0,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        label != null
            ? Text(
                label!,
                style: TextStyle(
                  color: ColorUtils.colorPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: textSize,
                ),
              )
            : Container(),
      ],
    );
  }
}
