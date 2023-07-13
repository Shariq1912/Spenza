import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/sign_up/register_provider.dart';
import 'package:spenza/utils/spenza_extensions.dart';

import '../login/data/login_request.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final poppinsFont = GoogleFonts.poppins().fontFamily;
  bool _obscurePassword = true;
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(8,
        errorText: 'Password must be at least 8 characters long'),
  ]);

  @override
  Widget build(BuildContext context) {
    final responseValue = ref.watch(registerRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.goNamed(RouteManager.splashScreen);
            },
            icon: const Icon(Icons.chevron_left_outlined)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Form(
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              children: [
                Text(
                  "Sign up",
                  style: TextStyle(
                      fontFamily: poppinsFont,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0CA9E6)),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3), // Shadow color
                        spreadRadius: 2, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset: const Offset(
                            0, 2), // Offset in the vertical direction
                      ),
                    ],
                    borderRadius: BorderRadius.circular(12), // Border radius
                  ),
                  child: Column(
                    children: [
                      responseValue.when(
                        () => Container(),
                        loading: () => const CircularProgressIndicator(),
                        success: (data) {
                          debugPrint(data.toString());
                          return Container();
                        },
                        error: (message) {
                          debugPrint(message.toString());
                          return Container();
                        },
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter Email',
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none, // No border line
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        controller: emailController,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Password',
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        obscureText: _obscurePassword,
                        validator: passwordValidator,
                        controller: passwordController,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Password',
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        obscureText: _obscurePassword,
                        validator: passwordValidator,
                        controller: confirmPasswordController,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text.rich(
                    TextSpan(
                      text: "By Using this application, you agree to our ",
                      children: <TextSpan>[
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap =
                                  () => /* context.goNamed("register"),*/ {},
                            text: 'Terms of Service',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: poppinsFont)),

                        const TextSpan(text: " and "),
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap =
                                  () => /* context.goNamed("register"),*/ {},
                            text: 'Privacy Policy',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: poppinsFont)),

                        // can add more TextSpans here...
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle login button press
                      if (_formKey.currentState!.validate()) {
                        // Form is valid, perform desired action
                        if (passwordController.text !=
                            confirmPasswordController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Passwords do not match.'),
                            ),
                          );
                          return;
                        }

                        final signUpData = LoginRequest(
                          email: emailController.text.toString(),
                          password: passwordController.text.toString(),
                        );
                        debugPrint("signUPDATA :$signUpData");
                        ref
                            .read(registerRepositoryProvider.notifier)
                            .registerWithEmailAndPassword(
                              credentials: signUpData,
                            );
                      } else {
                        // Form is invalid, display error message
                        context.showSnackBar(
                            message: 'Please fix the errors in the form.');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0CA9E6),
                        // Background color
                        foregroundColor: Colors.white,
                        // Text color
                        textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: poppinsFont),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: const BorderSide(color: Color(0xFF99D6EF))),
                        fixedSize: const Size(310, 40)),
                    child: const Text('Create Account'),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 35.0, right: 5.0),
                        child: const Divider(
                          color: Colors.black,
                          height: 30,
                        )),
                  ),
                  const Text("continue with"),
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 5.0, right: 35.0),
                        child: const Divider(
                          color: Colors.black,
                          height: 30,
                        )),
                  ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: InkWell(
                            onTap: () {
                              //_authenticateWithFacebook(context);
                            },
                            child: Image.asset(
                              "assets/images/google.png",
                              height: 40,
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InkWell(
                        onTap: () {
                          //_authenticateWithGoogle(context);
                        },
                        child: Image.asset(
                          "assets/images/facebook.png",
                          height: 43,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
