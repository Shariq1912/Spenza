import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/sign_up/register_provider.dart';

import '../login/data/login_request.dart';
import '../login/login_provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SignUpRoute();
  }
}

class SignUpRoute extends ConsumerStatefulWidget {
  const SignUpRoute({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUpRoute> createState() => _SignUpRouteState();
}

class _SignUpRouteState extends ConsumerState<SignUpRoute> {
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
                      responseValue.maybeWhen(
                        () => Container(),
                        loading: () => const CircularProgressIndicator(),
                        success: (data) => Text(data.toString()),
                        error: (message) => Text(message.toString()),
                        orElse: () => Container(),
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
                        // For example, you can show a success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Form is valid!')),
                        );
                        final signUpData = LoginRequest(
                          email: emailController.text.toString(),
                          password: passwordController.text.toString(),
                        );
                        print("signUPDATA :$signUpData");
                        ref
                            .read(registerRepositoryProvider.notifier)
                            .registerWithEmailAndPassword(
                                credentials: signUpData);
                      } else {
                        // Form is invalid, display error message

                        // For example, you can show an error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Please fix the errors in the form.')),
                        );
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
