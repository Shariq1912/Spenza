import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spenza/utils/color_utils.dart';
import 'package:spenza/utils/spenza_extensions.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final String logo;
  final TextStyle textStyle;
  final displayActionIcon;
  final VoidCallback onBackIconPressed;
  final VoidCallback? onActionIconPressed; // Optional callback parameter
  final String? source; // Optional callback parameter

  const CustomAppBar({
    Key? key,
    required this.title,
    this.subtitle = "",
    required this.textStyle,
    this.logo = "https://picsum.photos/250?image=9",
    required this.onBackIconPressed,
    required this.displayActionIcon,
    this.onActionIconPressed,
    this.source
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, ref) {
    debugPrint("bottomValue $source");
    return AppBar(
      elevation: 5.0,
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      leading: Visibility(
        visible: source!="bottom",
        child: Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: GestureDetector(
            onTap: () {
              onBackIconPressed();
            },
            child: Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: Image.asset(
                  "back_Icon_blue.png".assetImageUrl,
                ),
              ),
            ),
          ),
        ),
      ),
      actions: [
        displayActionIcon
            ? InkWell(
                onTap: onActionIconPressed,
                child: CircleAvatar(
                  radius: 40,
                  child: ClipOval(
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: logo,
                        placeholder: (context, url) =>
                            Image.asset('app_icon_spenza.png'.assetImageUrl),
                        errorWidget: (context, url, error) =>
                            Image.asset('placeholder_myList.png'.assetImageUrl),
                      ),
                    ),
                  ),
                ),
              )
            : Container()
      ],
      title: Column(
        children: [
          Text(
            title,
            style: textStyle,
          ),
          Visibility(
            visible: subtitle.isNotEmpty,
            child: Text(
              subtitle,
              style: textStyle.copyWith(fontSize: 14),
            ),
          ),
        ],
      ),
      centerTitle: true,
    );
  }
}
