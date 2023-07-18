import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/ui/profile/component/profile_info.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final poppinsFont = GoogleFonts.poppins().fontFamily;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      child: ClipOval(
                        child: Image.asset("assets/images/avatar.gif"),
                      ),
                    ),
                    Text(
                      "mary_2233@gmail.com",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: poppinsFont,
                      ),
                    ),
                    Text(
                      "Select language",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: poppinsFont,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent,
                          foregroundColor: Colors.white,
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: poppinsFont,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text("Log out"),
                      ),
                    ),

                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "   Profile Information",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: poppinsFont,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0CA9E6)),
                            ),

                            Row(
                              children: [
                                Expanded(
                                  flex :1,
                                  child: Text(
                                    "Name",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: poppinsFont,
                                        fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                                SizedBox(width: 30,),
                                Expanded(
                                  flex : 3,
                                   child: TextFormField(
                                      style: TextStyle(fontFamily: poppinsFont),

                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          //borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                ),
                              ],
                            ),


                          ],

                        ),
                      ),
                    ),
                    ProfileInformation()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
