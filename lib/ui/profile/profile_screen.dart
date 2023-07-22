import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../login/login_provider.dart';
import '../login/login_screen.dart';
import 'component/profile_fields_row.dart';

const poppinsFont = 'Poppins';

class ProfileScreen extends ConsumerStatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final poppinsFont = GoogleFonts.poppins().fontFamily;
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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
                "email",
                style: TextStyle(fontSize: 16, fontFamily: poppinsFont),
              ),
              SizedBox(height: 10),
              Text(
                "Select language",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: poppinsFont,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: ElevatedButton(
                  onPressed: () {
                      ref.read(loginRepositoryProvider.notifier).signOut();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()));

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
                "Household Information",
                [
                  ProfileFieldRow(
                      name1: "No. of family members",
                      name2: "Mar Mediterraneo",
                      isEditing: isEditing),
                  ProfileFieldRow(
                      name1: "No. of children",
                      name2: "1164     Int.   9A",
                      isEditing: isEditing),
                  ProfileFieldRow(
                      name1: "Relationship to head of household",
                      name2: "44610",
                      isEditing: isEditing),
                  ProfileFieldRow(
                      name1: "Data of birth",
                      name2: "Gaudalajara",
                      isEditing: isEditing),
                  ProfileFieldRow(
                      name1: "Marital status",
                      name2: "Jalisco",
                      isEditing: isEditing),
                ],
              ),
              SizedBox(height: 10),
              buildCard(
                "Profile Information",
                [
                  ProfileFieldRow(
                      name1: "Name", name2: "Arthur", isEditing: isEditing),
                  ProfileFieldRow(
                      name1: "Surname", name2: "Medina", isEditing: isEditing),
                  ProfileFieldRow(
                      name1: "Mobile No.",
                      name2: "+52 33 2650 9117",
                      isEditing: isEditing),
                  ProfileFieldRow(
                      name1: "Gender", name2: "Male", isEditing: isEditing),
                ],
              ),
              SizedBox(height: 10),
              buildCard(
                "Address",
                [
                  ProfileFieldRow(
                      name1: "Street",
                      name2: "Mar Mediterraneo",
                      isEditing: isEditing),
                  ProfileFieldRow(
                      name1: "Number",
                      name2: "1164     Int.   9A",
                      isEditing: isEditing),
                  ProfileFieldRow(
                      name1: "Zip code", name2: "44610", isEditing: isEditing),
                  ProfileFieldRow(
                      name1: "District",
                      name2: "Gaudalajara",
                      isEditing: isEditing),
                  ProfileFieldRow(
                      name1: "State", name2: "Jalisco", isEditing: isEditing),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(String title, List<ProfileFieldRow> rows) {
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
          IconButton(
              onPressed: () {
                setState(() {
                  isEditing = !isEditing;
                });
              },
              icon: Icon(
                Icons.edit,
                color: Color(0xFF0CA9E6),
                size: 25,
              )),
        ],
        title: Text('Profile',
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Color(0xFF0CA9E6),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )));
  }
}
