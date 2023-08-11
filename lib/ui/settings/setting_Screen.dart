import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/ui/profile/profile_screen.dart';

import '../../router/app_router.dart';
import 'components/card_item.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  final poppinsFont = GoogleFonts.poppins().fontFamily;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.only(top: 40.0, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  child: ClipOval(
                    child: Image.asset("assets/images/avatar.gif"),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mary",
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
                    context.push(RouteManager.uploadReceiptScreen);
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFF0CA9E6),
                    size: 32,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            CardItem(icon: Icons.list, title: "My Lists"),
            CardItem(icon: Icons.receipt, title: "My Receipts"),
            CardItem(icon: Icons.store, title: "My Stores", onTap: () {}),
            SizedBox(height: 10),
            Card(
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.notification_important, color: Colors.pinkAccent),
                    title: Text(
                      "Notifications",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: poppinsFont,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.privacy_tip, color: Color(0xFF0CA9E6)),
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
    );
  }


}
