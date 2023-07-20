import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TextStyle textStyle;
  final displayActionIcon;

  final VoidCallback onBackIconPressed;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.textStyle,
    required this.onBackIconPressed,
    required this.displayActionIcon,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
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
          ), // Replace with Apple_back_icon
          onPressed: onBackIconPressed,
        ),
      ),
      actions: [
        displayActionIcon
            ? Padding(
                padding: const EdgeInsets.only(
                  top: 5,
                ),
                child: InkWell(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 40,
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: 'https://picsum.photos/250?image=9',
                      ),
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
