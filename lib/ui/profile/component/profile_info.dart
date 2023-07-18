import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileInformation extends ConsumerStatefulWidget {
  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends ConsumerState<ProfileInformation> {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  final poppinsFont = GoogleFonts.poppins().fontFamily;
  String sex = "Male";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTextField("Name", nameController,
                //(value) => profileProvider.read(context).updateProfile(name: value)),
                (value) => ""), buildTextField("Surname", surnameController,
                //(value) => profileProvider.read(context).updateProfile(surname: value)),
                (value) => ""),
            Row(
              children: [
                Text("Sex:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                SizedBox(width: 60),
                TextButton(onPressed: () {setState(() {sex = "Male";});},
                  child: Text("Male"),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      sex = "Female";
                    });
                  },
                  child: Text("Female"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      ValueChanged<String> onChanged) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            label,
            style: TextStyle(fontSize: 14, fontFamily: poppinsFont),
          ),
        ),
        Expanded(
          flex: 3,
          child: TextFormField(
            style: TextStyle(fontFamily: poppinsFont),
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    mobileNumberController.dispose();
    dobController.dispose();
    super.dispose();
  }
}
