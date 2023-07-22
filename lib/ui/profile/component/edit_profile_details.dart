import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileDetails extends ConsumerStatefulWidget{
  const EditProfileDetails({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditProfileDetailsState();
}

class _EditProfileDetailsState extends ConsumerState<EditProfileDetails> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final poppinsFont = GoogleFonts.poppins().fontFamily;
  bool _obscurePassword = true;

  /*late final MultiValidator passwordValidator;
  late final MultiValidator emailValidator;*/


  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: 'Please use valid Email ID'),
  ]);

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(8,
        errorText: 'Password must be at least 8 characters long'),
  ]);
  String dropdownValue = 'Male';

  List <String> spinnerItems = [
    'Male',
    'Female',] ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Form(
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    "Personal Information",
                    style: TextStyle(
                      fontFamily: poppinsFont,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0CA9E6),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                            decoration: InputDecoration(
                              hintText:"Name",
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            controller: emailController,
                            validator: emailValidator),
                        const SizedBox(height: 8),
                        TextFormField(
                            decoration: InputDecoration(
                              hintText:"Surname",
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            controller: emailController,
                            validator: emailValidator),
                        const SizedBox(height: 8),
                        TextFormField(
                            decoration: InputDecoration(
                              hintText:"Mobile No.",
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            controller: emailController,
                            validator: emailValidator),
                      ],
                    ),
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,

                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.red, fontSize: 18),
                    underline: Container(
                      height: 20,
                      color: Colors.transparent,
                    ),
                    onChanged: (String? data) {
                      setState(() {
                        dropdownValue = data!;
                      });
                    },
                    items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: ElevatedButton(
                      onPressed: () {
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0CA9E6), foregroundColor: Colors.white,
                        textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: poppinsFont,),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),
                      ),
                      child: Text("Log out"),
                    ),
                  ),




                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}