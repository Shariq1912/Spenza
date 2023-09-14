import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/utils/color_utils.dart';
import 'package:spenza/utils/spenza_extensions.dart';
import '../../router/app_router.dart';
import '../login/login_provider.dart';
import '../profile/profile_repository.dart';
import 'components/card_item.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  final poppinsFont = GoogleFonts.poppins().fontFamily;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });

    print("KEY on SETTINGS IS ${widget.key}");
    super.initState();
  }

  _loadData() async {
    ref.read(profileRepositoryProvider.notifier).getUserProfileData();
  }

  @override
  void dispose() {
    ref.invalidate(profileRepositoryProvider);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topAppBar(),
      body: Padding(
        padding: EdgeInsets.only(top: 10.0, left: 10, right: 10),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CardItem(
                  icon: Icons.list,
                  title: "My Lists",
                  onTap: () {
                    context.push(RouteManager.myListScreen);
                  }),
              CardItem(
                  icon: Icons.receipt,
                  title: "My Receipts",
                  onTap: () {
                    context.pushNamed(RouteManager.displayReceiptScreen,
                        queryParameters: {'list_ref': ''});
                  }),
              CardItem(
                  icon: Icons.store,
                  title: "My Stores",
                  onTap: () {
                    context.pushNamed(RouteManager.storesScreen);
                  }),
              SizedBox(height: 10),
              Container(
                color: Color(0xFFE5E7E8),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.notification_important,
                          color: Colors.grey.shade600),
                      title: Text(
                        "Notifications",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: poppinsFont,
                            color: ColorUtils.primaryText
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.lock_rounded,
                          color: Colors.grey.shade600),
                      title: Text(
                        "Privacy Policy",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: poppinsFont,
                            color: ColorUtils.primaryText
                        ),
                      ),
                    ),
                    ListTile(
                      leading:
                          Icon(Icons.lock_rounded, color: Colors.grey.shade600),
                      title: Text(
                        "Terms and Condition",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: poppinsFont,
                            color: ColorUtils.primaryText
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                color: Color(0xFFE5E7E8),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.favorite, color: ColorUtils.colorSecondary),
                      title: Text(
                        "Share and earn",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: poppinsFont,
                            color: ColorUtils.primaryText
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                color: Color(0xFFE5E7E8),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.logout, color: Colors.grey.shade600),
                      title: Text(
                        "Sign Out",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: poppinsFont,
                          color: ColorUtils.primaryText
                        ),
                      ),
                      onTap: () async {
                        ref
                            .read(loginRepositoryProvider.notifier)
                            .signOut()
                            .then(
                              (value) =>
                              context.goNamed(RouteManager.loginScreen),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageWidget(String? image) {
    return image != null
        ? CircleAvatar(
            radius: MediaQuery.of(context).size.width * 0.08,
            backgroundColor: Colors.white,
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: image!,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          )
        : CircleAvatar(
            radius: MediaQuery.of(context).size.width * 0.08,
            backgroundColor: Colors.white,
            child: ClipOval(child: Image.asset('assets/images/user.png')),
          );
  }

  AppBar topAppBar() {
    return AppBar(
      elevation: 5.0,
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      leading: widget.key == null
          ? IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(Icons.arrow_back_ios, color: Color(0xFF0CA9E6)),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 8.0),
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
                      if (data.profilePhoto != null &&
                          data.profilePhoto!.isNotEmpty) {
                        return CircleAvatar(
                          radius: 40,
                          child: ClipOval(
                            child: AspectRatio(
                              aspectRatio: 1.0,
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: data.profilePhoto!,
                                placeholder: (context, url) => Image.asset(
                                    'app_icon_spenza.png'.assetImageUrl),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                        'user_placeholder.png'.assetImageUrl),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return CircleAvatar(
                          radius: 35,
                          child: ClipOval(
                              child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Image.asset(
                              'user_placeholder.png'.assetImageUrl,
                              fit: BoxFit.cover,
                            ),
                          )),
                        );
                      }
                    },
                  );
                },
              ),
            ),
      actions: [
        Padding(
            padding: const EdgeInsets.only(
              top: 5,
            ),
            child: IconButton(
              onPressed: () {
                context.push(RouteManager.profileScreen);
              },
              icon: Icon(Icons.arrow_forward_ios, color: Color(0xFF0CA9E6)),
            )
            //),
            ),
      ],
      title: Text(
        "Account Information",
        style: TextStyle(
          fontFamily: poppinsFont,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: ColorUtils.primaryText,
        ),
      ),
      centerTitle: false,
    );
  }
}
