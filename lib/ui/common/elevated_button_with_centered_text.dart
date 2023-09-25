import 'package:flutter/material.dart';
import 'package:spenza/utils/color_utils.dart';

class ElevatedButtonWithCenteredText extends StatelessWidget {
  final String fontFamily;
  final String text;
  final VoidCallback onClick;
  final Size size;

  const ElevatedButtonWithCenteredText({
    super.key,
    required this.fontFamily,
    required this.text,
    required this.onClick,
    this.size = const Size(300, 40),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onClick.call(),
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorUtils.colorPrimary,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'nutmeg',
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        fixedSize: size,
      ),
      child: Text(text),
    );
  }
}
