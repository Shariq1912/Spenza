import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/utils/spenza_extensions.dart';
import '../../router/app_router.dart';
import '../profile/profile_repository.dart';
import 'components/card_item.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingScreenState();
}


class _SettingScreenState extends ConsumerState<SettingScreen> {
  final poppinsFont = GoogleFonts
      .poppins()
      .fontFamily;


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
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
        padding: EdgeInsets.only(top: 40.0, left: 10, right: 10),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /*Consumer(
                builder: (context, ref, child) {
                  final userProvider = ref.watch(profileRepositoryProvider);
                  return userProvider.when(
                          () => Container(),
                      loading: () => Center(child: CircularProgressIndicator()),
                      error: (message) {
                        print("errorMrss $message");
                        return Center(child: Text(message));
                      },
                      success: (data){
                            UserProfileData userData = data;
                       return Row(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              child: _buildImageWidget(userData.profilePhoto),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userData.name ?? "User",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFF0CA9E6),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: poppinsFont,
                                    ),
                                  ),
                                  Text(
                                    "Account Information",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: poppinsFont,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                context.push(RouteManager.profileScreen);
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xFF0CA9E6),
                                size: 32,
                              ),
                            ),
                          ],
                        );
                      });
                },
              ),*/
              SizedBox(height: 30),
              CardItem(icon: Icons.list, title: "My Lists", onTap: () {context.push(RouteManager.myListScreen);}),
              CardItem(icon: Icons.receipt, title: "My Receipts", onTap: () {context.pushNamed(RouteManager.displayReceiptScreen,queryParameters: {'list_ref': ''});}),
              CardItem(icon: Icons.store, title: "My Stores", onTap: () {
                context.pushNamed(RouteManager.storesScreen);
              }),
              SizedBox(height: 10),
              Card(
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.notification_important,
                          color: Colors.pinkAccent),
                      title: Text(
                        "Notifications",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: poppinsFont,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                          Icons.privacy_tip, color: Color(0xFF0CA9E6)),
                      title: Text(
                        "Privacy",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: poppinsFont,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Card(
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.share, color: Colors.greenAccent),
                      title: Text(
                        "Share and earn",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: poppinsFont,
                        ),
                      ),
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
      child: ClipOval(
          child: Image.asset('assets/images/user.png')
      ),
    );


  }

  AppBar topAppBar() {
    return AppBar(
      elevation: 5.0,
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () {
          context.pushReplacement(RouteManager.homeScreen);
        },
        icon: Icon(Icons.arrow_back_ios, color: Color(0xFF0CA9E6)),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            top: 5,
          ),
          child: InkWell(
              onTap: () {
                context.pushNamed(RouteManager.profileScreen);
              },
              child:  Consumer(
                builder: (context, ref, child) {
                  final profilePro = ref.watch(profileRepositoryProvider);
                  return profilePro.when(
                        () => Container(),
                    loading: () => Center(child: CircularProgressIndicator()),
                    error: (message) => CircleAvatar(
                      child: Image.asset('assets/images/user.png'),
                    ),
                    success: (data) {
                      if (data.profilePhoto != null && data.profilePhoto!.isNotEmpty) {
                        return CircleAvatar(
                          radius: 40,
                          child: ClipOval(
                            child: AspectRatio(
                              aspectRatio: 1.0,
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: data.profilePhoto!,
                                placeholder: (context, url) =>  Image.asset('app_icon_spenza.png'.assetImageUrl),
                                errorWidget: (context, url, error) => Image.asset('user_placeholder.png'.assetImageUrl),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return ClipOval(
                            child: AspectRatio(
                              aspectRatio: 1.0,
                              child:  Image.asset('user_placeholder.png'.assetImageUrl,fit: BoxFit.cover,),
                            )
                        );
                      }
                    },
                  );
                },
              )
            //),
          ),
        )
      ],
      title:Text(
        "Setting",
        style: TextStyle(
          fontFamily: poppinsFont,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Color(0xFF0CA9E6),
        ),
      ),
      centerTitle: true,
    );
  }

}
