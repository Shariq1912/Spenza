import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/sign_up/register_provider.dart';
import 'package:spenza/utils/spenza_extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  @override
  void initState() {
    super.initState();

    /*passwordValidator = MultiValidator([
      RequiredValidator(
        errorText: AppLocalizations.of(context)!.passwordRequiredError,
      ),
      MinLengthValidator(8,
          errorText: AppLocalizations.of(context)!.passwordLengthError),
    ]);

    emailValidator = MultiValidator([
      RequiredValidator(
        errorText: AppLocalizations.of(context)!.emailRequiredError,
      ),
      EmailValidator(
        errorText: AppLocalizations.of(context)!.emailInvalidError,
      ),
    ]);*/
  }

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
                  AppLocalizations.of(context)!.sign_up,
                  style: TextStyle(
                    fontFamily: poppinsFont,
                    fontSize: 40,
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
                      TextFormField(
                          decoration: InputDecoration(
                            hintText:
                                AppLocalizations.of(context)!.enterEmailHint,
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
                          hintText: AppLocalizations.of(context)!.passwordHint,
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
                          hintText: AppLocalizations.of(context)!.passwordHint,
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
                      text:
                          AppLocalizations.of(context)!.terms_of_service_intro,
                      children: <TextSpan>[
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap =
                                () => /* context.goNamed("register"),*/ {},
                          text: AppLocalizations.of(context)!.terms_of_service,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: poppinsFont,
                          ),
                        ),
                        const TextSpan(text: " and "),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap =
                                () => /* context.goNamed("register"),*/ {},
                          text: AppLocalizations.of(context)!.privacy_policy,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: poppinsFont,
                          ),
                        ),
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
                            message:
                                AppLocalizations.of(context)!.loginFormErrors);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0CA9E6),
                      foregroundColor: Colors.white,
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: poppinsFont,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: const BorderSide(color: Color(0xFF99D6EF)),
                      ),
                      fixedSize: const Size(310, 40),
                    ),
                    child: Text(AppLocalizations.of(context)!.create_account),
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 35.0, right: 5.0),
                        child: const Divider(
                          color: Colors.black,
                          height: 30,
                        ),
                      ),
                    ),
                    Text(AppLocalizations.of(context)!.orLoginWith),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 5.0, right: 35.0),
                        child: const Divider(
                          color: Colors.black,
                          height: 30,
                        ),
                      ),
                    ),
                  ],
                ),
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
                        ),
                      ),
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
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
