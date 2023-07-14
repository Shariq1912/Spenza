import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/login/login_provider.dart';
import 'package:spenza/utils/spenza_extensions.dart';

import 'data/login_request.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final poppinsFont = GoogleFonts.poppins().fontFamily;

  bool _obscurePassword = true;

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
  ]);

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: 'Please use valid Email ID'),
  ]);

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responseValue = ref.watch(loginRepositoryProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                context.goNamed(RouteManager.splashScreen);
              },
              icon: const Icon(Icons.chevron_left_outlined)),
        ),
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
                      "Login",
                      style: TextStyle(
                          fontFamily: poppinsFont,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0CA9E6)),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Access your account by logging in below.",
                      style: TextStyle(
                        fontFamily: poppinsFont,
                      ),
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
                              debugPrint("$data");
                              context.goNamed(RouteManager.locationScreen);
                              return Container();
                            },
                            //error: (message) => Text(message.toString()),
                            error: (message) {
                              debugPrint("$message");
                              return Container();

                            },
                          ),
                          TextFormField(
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
                            validator: emailValidator,
                            controller: emailController,
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Password',
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
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
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle login button press
                          if (!_formKey.currentState!.validate()) {
                            context.showSnackBar(
                                message: 'Please fix the errors in the form.');
                          }

                          final loginData = LoginRequest(
                            email: emailController.text.toString(),
                            password: passwordController.text.toString(),
                          );

                          ref
                              .read(loginRepositoryProvider.notifier)
                              .loginWithEmailAndPassword(credentials: loginData);
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
                        child: const Text('Login'),
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
                      const Text("or login with"),
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
                                  // _authenticateWithGoogle(context);

                                  context.showSnackBar(
                                      message: 'clicked on google');
                                  ref
                                      .read(loginRepositoryProvider.notifier)
                                      .signInWithGoogle();
                                },
                                child: Image.asset(
                                  "google.png".assetImageUrl,
                                  height: 40,
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: InkWell(
                            onTap: () {
                              //_authenticateWithGoogle(context);
                              context.goNamed(RouteManager.favouriteScreen);
                              context.showSnackBar(
                                message: "clicked on facebook",
                              );
                            },
                            child: Image.asset(
                              "facebook.png".assetImageUrl,
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
        ),
      ),
    );
  }
}
