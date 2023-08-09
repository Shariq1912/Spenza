import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spenza/ui/my_list_details/provider/user_product_list_provider.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final String logo;
  final TextStyle textStyle;
  final displayActionIcon;

  final VoidCallback onBackIconPressed;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.textStyle,
    this.logo = "https://picsum.photos/250?image=9",
    required this.onBackIconPressed,
    required this.displayActionIcon,
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
            ? Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: CircleAvatar(
                      radius: 40,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: logo,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 30,
                    top: 10,
                    child: PopupMenuButton<String>(
                      onSelected: (value) {
                        // Handle the selected menu item here
                        if (value == 'copy') {
                          // Handle copy action
                          ref.read(userProductListProvider.notifier).copyTheList(context: context);

                        } else if (value == 'delete') {
                          // Handle delete action
                          ref.read(userProductListProvider.notifier).deleteTheList(context: context);

                        } else if (value == 'edit') {
                          // Handle edit action
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem<String>(
                            value: 'copy',
                            child: Text('Copy'),
                          ),
                          PopupMenuItem<String>(
                            value: 'delete',
                            child: Text('Delete'),
                          ),
                          PopupMenuItem<String>(
                            value: 'edit',
                            child: Text('Edit'),
                          ),
                        ];
                      },
                      icon: Icon(Icons.more_vert),
                    ),
                  ),
                ],
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
