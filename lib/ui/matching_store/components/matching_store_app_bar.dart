import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spenza/ui/home/components/location_dialog.dart';
import 'package:spenza/ui/profile/profile_repository.dart';
import 'package:spenza/utils/color_utils.dart';
import 'package:spenza/utils/spenza_extensions.dart';

class MatchingTopAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final TextStyle poppinsFont;
  final String title;
  final bool isUserIconVisible;

  MatchingTopAppBar({
    super.key,
    required this.poppinsFont,
    required this.title,
    this.isUserIconVisible = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(90.0);

  @override
  Widget build(BuildContext context, ref) {
    return AppBar(
      toolbarHeight: 90,
      elevation: 5.0,
      surfaceTintColor: Colors.white,
      backgroundColor: ColorUtils.colorPrimary,
      automaticallyImplyLeading: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: ColorUtils.colorPrimary,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      leading: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: Image.asset(
              "back_Icon_white.png".assetImageUrl,
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            //top: 5,
          ),

        )
      ],
      title: Align(
        alignment: Alignment.centerRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              maxLines: 2,
              //AppLocalizations.of(context)!.,
              title,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: poppinsFont.fontFamily,
                decoration: TextDecoration.none,
                color: ColorUtils.colorWhite,
                fontWeight: FontWeight.bold,
                fontSize: 17,
                height: 1
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Consumer(
              builder: (context, ref, child) {
                final profilePro = ref.watch(profileRepositoryProvider);
                return profilePro.when(
                      () => Container(),
                  loading: () => Container(),
                  error: (error) => Container(),
                  success: (data) {
                    return _buildNearbyText(context,data.zipCode, 12);
                  },
                );
              },
            ),
          ],
        ),
      ),
      centerTitle: false,
    );
  }

  Widget _buildNearbyText(BuildContext context, String? zipCode, double fontSize) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return LocationDialog();
            },
            barrierDismissible: true);
      },
      child: Text.rich(
        TextSpan(
          text: "Nearby",
          style: TextStyle(
            fontFamily: poppinsFont.fontFamily,
            decoration: TextDecoration.none,
            color: ColorUtils.colorWhite,
            fontWeight: FontWeight.normal,
            fontSize: fontSize,
            height: 1
          ),
          children: [
            TextSpan(
              text: " ${zipCode ?? ''}",
              style: TextStyle(
                fontFamily: poppinsFont.fontFamily,
                decoration: TextDecoration.none,
                color: ColorUtils.colorWhite,
                fontWeight: FontWeight.w700,
                fontSize: fontSize,
                height: 1
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}