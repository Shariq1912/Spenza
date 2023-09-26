import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spenza/helpers/bottom_nav_helper.dart';
import 'package:spenza/l10n/provider/language_provider.dart';
import 'package:spenza/router/go_router_provider.dart';
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
  final robotoFont = GoogleFonts.roboto().fontFamily;

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
      backgroundColor: Colors.white,
      appBar: topAppBar(),
      body: Padding(
        padding: EdgeInsets.only(top: 10.0, left: 0, right: 0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CardItem(
                  icon: Icons.list,
                  title: "My Lists",
                  onTap: () {
                    StatefulNavigationShell.of(context)
                        .goBranch(screenNameToIndex[ScreenName.myList]!);
                  }),
              CardItem(
                  icon: Icons.receipt,
                  title: "My Receipts",
                  onTap: () {
                    StatefulNavigationShell.of(context).goBranch(
                      screenNameToIndex[ScreenName.receipts]!,
                    );
                  }),
              CardItem(
                  icon: Icons.store,
                  title: "My Stores",
                  onTap: () {
                    context.pushNamed(RouteManager.storesScreen);
                  }),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Divider(
                  height: 1,
                  color: ColorUtils.colorSurface,
                ),
              ),
              ListTile(
                leading: Icon(Icons.notification_important,
                    color: Colors.grey.shade600),
                title: Text(
                  "Language",
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: robotoFont,
                      color: ColorUtils.primaryText),
                ),
                onTap: () async {
                  ref.read(languageProvider.notifier).state = 'es';
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString("language", 'es' );
                },
              ),
              ListTile(
                leading: Icon(Icons.notification_important,
                    color: Colors.grey.shade600),
                title: Text(
                  "Change Password",
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: robotoFont,
                      color: ColorUtils.primaryText),
                )
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Divider(
                  height: 1,
                  color: ColorUtils.colorSurface,
                ),
              ),
              SizedBox(height: 10),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.notification_important,
                          color: Colors.grey.shade600),
                      title: Text(
                        "Notifications",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: robotoFont,
                            color: ColorUtils.primaryText),
                      ),
                    ),
                    ListTile(
                      leading:
                          Icon(Icons.lock_rounded, color: Colors.grey.shade600),
                      title: Text(
                        "Privacy Policy",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: robotoFont,
                            color: ColorUtils.primaryText),
                      ),
                    ),
                    ListTile(
                      leading:
                          Icon(Icons.lock_rounded, color: Colors.grey.shade600),
                      title: Text(
                        "Terms and Condition",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: robotoFont,
                            color: ColorUtils.primaryText),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Divider(
                        height: 1,
                        color: ColorUtils.colorSurface,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.favorite,
                          color: ColorUtils.colorSecondary),
                      title: Text(
                        "Share and earn",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: robotoFont,
                            color: ColorUtils.primaryText),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.logout, color: Colors.grey.shade600),
                  title: Text(
                    "Sign Out",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: robotoFont,
                        color: ColorUtils.primaryText),
                  ),
                  onTap: () => handleLogout(
                    onConfirm: () {
                      ref
                          .read(loginRepositoryProvider.notifier)
                          .signOut()
                          .then(
                        (value) {
                          // context.goNamed(RouteManager.loginScreen);
                          ref
                              .read(initialLocationProvider.notifier).state =
                              RouteManager.loginScreen;
                          ref.invalidate(goRouterProvider);
                        },
                      );
                    },
                  ),

                  /*onTap: () =>
                      ref.read(loginRepositoryProvider.notifier).signOut().then(
                    (value) {
                      ref
                          .read(initialLocationProvider.notifier).state =
                          RouteManager.loginScreen;
                      ref.invalidate(goRouterProvider);
                    },
                  ),*/
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
            child: GestureDetector(
              onTap: () {
                context.push(RouteManager.profileScreen);
              },
              child: Container(
                padding: const EdgeInsets.only(
                    top: 5,right: 5
                ),
                child: SizedBox(
                  width: 18,
                  height: 18,
                  child: Image.asset(
                    "forward_Icon_blue.png".assetImageUrl,
                  ),
                ),
              ),
            )
            //),
            ),
      ],
      title: Text(
        "Account Information",
        style: TextStyle(
          fontFamily: robotoFont,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: ColorUtils.primaryText,
        ),
      ),
      centerTitle: false,
    );
  }

  void handleLogout({required VoidCallback onConfirm}) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.warning,
      showCancelBtn: true,
      text: 'Do you want to logout',
      headerBackgroundColor: ColorUtils.colorPrimary,
      title: "Are you sure?",
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      confirmBtnColor: ColorUtils.colorPrimary,
      onConfirmBtnTap: () {
        context.pop();
        onConfirm.call();
      },
    );
  }
}
