import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/login/login_provider.dart';
import 'package:spenza/utils/constants.dart';
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

  /*late final MultiValidator passwordValidator;
  late final MultiValidator emailValidator;*/

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
  ]);

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: 'Please use valid Email ID'),
  ]);

  @override
  void initState() {
    super.initState();
  }

  getPostalCode() async {
    double latitude = 22.2821;
    double longitude = 73.1646;

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      String postalCode = placemarks.first.postalCode ?? "";
      print('Postal Code: $postalCode');
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    passwordController.dispose();

    ref.invalidate(loginRepositoryProvider);



  }

  @override
  Widget build(BuildContext context) {
    final responseValue = ref.watch(loginRepositoryProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              context.goNamed(RouteManager.splashScreen);
            },
            icon: const Icon(Icons.arrow_back_ios_rounded,
                size: 35, color: Color(0xFF0CA9E6), grade: 50)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Form(
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.loginTitle,
                      style: TextStyle(
                        fontFamily: poppinsFont,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0CA9E6),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      AppLocalizations.of(context)!.loginSubtitle,
                      style: TextStyle(
                        fontFamily: poppinsFont,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              hintText:
                                  AppLocalizations.of(context)!.enterEmailHint,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              filled: true,
                              fillColor: Color(0xFFE5E7E8),
                            ),
                            validator: emailValidator,
                            controller: emailController,
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText:
                                  AppLocalizations.of(context)!.passwordHint,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              filled: true,
                              fillColor: Color(0xFFE5E7E8),
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: _buildTermsAndPrivacyTextSpan(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Consumer(
                      builder: (context, ref, child) {
                        return responseValue.maybeWhen(
                          () => _LoginButton(),
                          loading: () => const CircularProgressIndicator(),
                          success: (data) {
                            debugPrint("$data");
                            ref
                                .read(loginRepositoryProvider.notifier)
                                .redirectUserToDestination(context: context);

                            return Container();
                          },
                          orElse: () => _LoginButton(),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    Consumer(
                      builder: (context, ref, child) {
                        return responseValue.maybeWhen(
                          () => Container(),
                          error: (errorMsg) => Text(
                            errorMsg.toString(),
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                          orElse: () => Container(),
                        );
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              context.goNamed(RouteManager.registerScreen);
                            },
                            child: Text(
                                AppLocalizations.of(context)!.forgetPassword,
                                style: TextStyle(
                                    fontFamily: poppinsFont,
                                    color: Color(0xFF323E48))),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin:
                                const EdgeInsets.only(left: 30.0, right: 5.0),
                            child: const Divider(
                              color: Colors.black,
                              height: 30,
                            ),
                          ),
                        ),
                        Text(AppLocalizations.of(context)!.orLoginWith),
                        Expanded(
                          child: Container(
                            margin:
                                const EdgeInsets.only(left: 5.0, right: 30.0),
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
                                /*context.showSnackBar(
                                  message: 'clicked on google',
                                );*/
                                ref
                                    .read(loginRepositoryProvider.notifier)
                                    .signInWithGoogle();
                              },
                              child: Image.asset(
                                "google.png".assetImageUrl,
                                height: 40,
                              ),
                            ),
                          ),
                        ),
                        /*Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: InkWell(
                            onTap: () {
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
                        )*/
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                context.goNamed(RouteManager.registerScreen);
                              },
                              child: Text('Create an account',
                                  style: TextStyle(
                                      fontFamily: poppinsFont,
                                      color: Color(0xFF323E48))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text _buildTermsAndPrivacyTextSpan(BuildContext context) {
    final termsOfService = AppLocalizations.of(context)!.terms_of_service;
    final privacyPolicy = AppLocalizations.of(context)!.privacy_policy;

    return Text.rich(
      TextSpan(
        text: AppLocalizations.of(context)!.terms_of_service_intro,
        style: TextStyle(
          color: Colors.black,
          fontFamily: poppinsFont,
        ),
        children: [
          TextSpan(
            text: " $termsOfService & $privacyPolicy",
            style: TextStyle(
                fontFamily: poppinsFont,
                color: Color(0xFF323e48),
                fontWeight: FontWeight.bold),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Handle the Terms of Service click action
                // You can navigate to the terms page or perform any other action here
                context.pushNamed(
                  RouteManager.webViewScreen,
                  queryParameters: {"url": Constants.privacyPolicyLink},
                );
              },
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _LoginButton() => Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Handle login button press
                if (!_formKey.currentState!.validate()) {
                  context.showSnackBar(
                    message: AppLocalizations.of(context)!.loginFormErrors,
                  );
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
                foregroundColor: Colors.white,
                surfaceTintColor: Colors.white,
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
              child: Text(AppLocalizations.of(context)!.loginButton),
            ),
          ),
        ],
      );
}
