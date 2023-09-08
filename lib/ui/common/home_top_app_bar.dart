import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/profile/profile_repository.dart';
import 'package:spenza/utils/color_utils.dart';
import 'package:spenza/utils/spenza_extensions.dart';

class HomeTopAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final TextStyle poppinsFont;
  final String title;
  final bool isUserIconVisible;

  HomeTopAppBar({
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
      automaticallyImplyLeading: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: ColorUtils.colorPrimary,
        // <-- SEE HERE
        statusBarIconBrightness: Brightness.dark,
        //<-- For Android SEE HERE (dark icons)
        statusBarBrightness: Brightness.light,
        // statusBarColor: ColorUtils.colorPrimary
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            top: 5,
          ),
          child: InkWell(
            onTap: () {
              context.pushNamed(RouteManager.settingScreen);
            },
            child: Consumer(
              builder: (context, ref, child) {
                final profilePro = ref.watch(profileRepositoryProvider);
                return profilePro.when(
                  () => Container(),
                  loading: () => Center(child: CircularProgressIndicator()),
                  error: (message) => CircleAvatar(
                    child: Image.asset('assets/images/user.png'),
                  ),
                  success: (data) {
                    final zipcode = data.zipCode;
                    print("zzz $zipcode");
                    if (data.profilePhoto != null &&
                        data.profilePhoto!.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 10, bottom: 18, top: 18, right: 10),
                        child: ClipOval(
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: data.profilePhoto!,
                              placeholder: (context, url) => Image.asset(
                                  'app_icon_spenza.png'.assetImageUrl),
                              errorWidget: (context, url, error) => Image.asset(
                                  'user_placeholder.png'.assetImageUrl),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 10, bottom: 18, top: 18, right: 10),
                        child: ClipOval(
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Image.asset(
                              'user_placeholder.png'.assetImageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
        )
      ],
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            maxLines: 2,
            //AppLocalizations.of(context)!.,
            title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: poppinsFont.fontFamily,
              decoration: TextDecoration.none,
              color: ColorUtils.colorWhite,
              fontWeight: FontWeight.bold,
              fontSize: 17,
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
                  return _buildNearbyText(data.zipCode, 12);
                },
              );
            },
          ),
        ],
      ),
      centerTitle: false,
    );
  }

  Text _buildNearbyText(String? zipCode, double fontSize) {
    return Text.rich(
      TextSpan(
        text: "Nearby",
        style: TextStyle(
          fontFamily: poppinsFont.fontFamily,
          decoration: TextDecoration.none,
          color: ColorUtils.colorWhite,
          fontWeight: FontWeight.normal,
          fontSize: fontSize,
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
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
