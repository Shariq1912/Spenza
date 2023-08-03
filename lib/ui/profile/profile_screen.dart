import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/ui/profile/component/edit_profile_info.dart';
import 'package:spenza/ui/profile/profile_repository.dart';

import '../login/login_provider.dart';
import '../login/login_screen.dart';
import 'component/profile_info.dart';
import 'data/user_profile_data.dart';

const poppinsFont = 'Poppins';

class ProfileScreen extends ConsumerStatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final poppinsFont = GoogleFonts.poppins().fontFamily;
  bool isEditing = false;


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
    super.initState();
  }

  _loadData() async {
     ref.read(profileRepositoryProvider.notifier).getUserProfileData();
    // ref.read(profileRepositoryProvider.notifier).rankStoresByPriceTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer(
            builder: (context, ref, child){
              final userProvider = ref.watch(profileRepositoryProvider);
              return userProvider.when(
                      () => Container(),
                  loading: () => Center(child: CircularProgressIndicator()),
                  error: (message) {
                    print("errorMrss $message");
                    return Center(child: Text(message));
                  },
                  success: (data){

                    FirebaseAuth auth = FirebaseAuth.instance;
                        UserProfileData userData= data;
                       return Column(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           CircleAvatar(
                             radius: 40,
                             child: ClipOval(
                               child: Image.asset("assets/images/avatar.gif"),
                             ),
                           ),
                           SizedBox(height: 10),
                           Text(
                             auth.currentUser!.email.toString(),
                             style: TextStyle(fontSize: 16, fontFamily: poppinsFont),
                           ),
                           SizedBox(height: 10),
                           Text(
                             "Select language",
                             style: TextStyle(
                               fontSize: 14,
                               fontFamily: poppinsFont,
                               fontWeight: FontWeight.bold,
                               color: Colors.black,
                             ),
                           ),
                           SizedBox(height: 10),
                           Container(
                             width: double.infinity,
                             padding: EdgeInsets.only(left: 10, right: 10),
                             child: ElevatedButton(
                               onPressed: () {
                                 //Add the logic to sign out here.
                                 ref.read(loginRepositoryProvider.notifier).signOut();
                                 Navigator.of(context).push(MaterialPageRoute(
                                   builder: (context) => LoginScreen(),
                                 ));
                               },
                               style: ElevatedButton.styleFrom(
                                 backgroundColor: Color(0xFF0CA9E6),
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
                           SizedBox(height: 10),
                           buildCard(
                             "Profile Information",
                             [
                               ProfileInfo(
                                 name1: "Name",
                                 value: userData.name ?? "",
                               ),
                               ProfileInfo(
                                 name1: "Surname",
                                 value: userData.surName ?? "",

                               ),
                               ProfileInfo(
                                 name1: "Mobile No.",
                                 value: userData.mobileNo ?? "",
                               ),
                               // Add other ProfileInfo widgets with appropriate field names and controllers.
                             ],
                           ),
                           SizedBox(height: 10),
                           buildCard(
                             "Address",
                             [
                               ProfileInfo(
                                 name1: "Street",
                                 value: userData.street ?? "",
                               ),
                               ProfileInfo(
                                 name1: "Number",
                                 value: userData.streetNumber ?? "",

                               ),
                               ProfileInfo(
                                 name1: "Zip code",
                                 value: userData.zipCode ?? "",

                               ),
                               ProfileInfo(
                                 name1: "District",
                                 value: userData.district ?? "",

                               ),

                               ProfileInfo(
                                 name1: "State",
                                 value: userData.state ?? "",

                               ),
                             ],
                           ),
                           SizedBox(height: 20),
                         ],
                       );
                  });
            },
          ),
        ),
      ),
    );
  }

  Widget buildCard(String title, List<ProfileInfo> rows) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: poppinsFont,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0CA9E6),
                ),
              ),
              SizedBox(height: 10),
              ...rows,
            ],
          ),
        ),
      ),
    );
  }

  AppBar topAppBar() {
    return AppBar(
      elevation: 5.0,
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      actions: [
        if (isEditing)
          TextButton(
              onPressed: () {
              },
              child: Text(
                "Save",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: poppinsFont,
                ),
              )),
       /* if (!isEditing)*/
          IconButton(
            onPressed: () {
              // setState(() {
              //   isEditing = !isEditing;
              // });
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditProfileInformation(),
              ));
            },
            icon: Icon(
              Icons.edit,
              color: Color(0xFF0CA9E6),
              size: 25,
            ),
          ),
      ],
      title: Text(
        'Profile',
        style: TextStyle(
          decoration: TextDecoration.none,
          color: Color(0xFF0CA9E6),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}
