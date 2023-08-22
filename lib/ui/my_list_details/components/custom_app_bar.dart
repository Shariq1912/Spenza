import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spenza/utils/spenza_extensions.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final String logo;
  final TextStyle textStyle;
  final displayActionIcon;
  final VoidCallback onBackIconPressed;
  final VoidCallback? onActionIconPressed; // Optional callback parameter

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.textStyle,
    this.logo = "https://picsum.photos/250?image=9",
    required this.onBackIconPressed,
    required this.displayActionIcon,
    this.onActionIconPressed, // Pass the optional callback here
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, ref) {
    return AppBar(
      elevation: 5.0,
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF0CA9E6),
            size: 24,
          ),
          onPressed: onBackIconPressed,
        ),
      ),
      actions: [
        displayActionIcon
            ? InkWell(
                onTap: onActionIconPressed,
                child: CircleAvatar(
                  radius: 40,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      errorWidget: (context, url, error) =>
                          Image.asset('list_image.png'.assetImageUrl),
                      placeholder: (context, url) =>
                          Image.asset('list_image.png'.assetImageUrl),
                      imageUrl: logo,
                    ),
                  ),
                ),
              )
            : Container()
      ],
      title: Text(
        title,
        style: textStyle,
      ),
      centerTitle: true,
    );
  }
}