import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/router/app_router.dart';

class SplashRoute extends StatelessWidget {
  const SplashRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final poppinsFont = GoogleFonts.poppins().fontFamily;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                        child: Center(
                          child: Text(
                            "Welcome to",
                            style: TextStyle(
                                fontFamily: poppinsFont,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF7B868C)),
                          ),
                        ),
                      ),
                      Center(
                        child: Image.asset(
                          'assets/images/logo.gif',
                          width: 300,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      _buildText("Find stores",
                          fontSize: 21, color: const Color(0xFF0CA9E6)),
                      _buildText(
                          "Find your favorite stores and supermarkets, and discover new ones near you",
                          fontSize: 12,
                          color: const Color(0xFF7B868C)),
                      const SizedBox(
                        height: 12,
                      ),
                      _buildText("Make your shopping list",
                          fontSize: 21, color: const Color(0xFF0CA9E6)),
                      _buildText(
                          "Make your own shopping list or select a pre-charged list that spenza has for you",
                          fontSize: 12,
                          color: const Color(0xFF7B868C)),
                      const SizedBox(
                        height: 12,
                      ),
                      _buildText("Compare prices",
                          fontSize: 21, color: const Color(0xFF0CA9E6)),
                      _buildText(
                          "Compare the price of your entire shopping list and find the best bargain",
                          fontSize: 12,
                          color: const Color(0xFF7B868C)),
                      const SizedBox(
                        height: 12,
                      ),
                      _buildText("Shop in store or online",
                          fontSize: 21, color: const Color(0xFF0CA9E6)),
                      _buildText(
                          "Select the best option for you and cut your grocery bill up to 30% every week",
                          fontSize: 12,
                          color: const Color(0xFF7B868C)),
                      const SizedBox(
                        height: 65,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            context.pushNamed(RouteManager.favouriteScreen);
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
                              ),
                              fixedSize: const Size(310, 40)),
                          child: const Text('Sign Up'),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            context.pushNamed(RouteManager.loginScreen);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              // Background color
                              foregroundColor: const Color(0xFF0CA9E6),
                              // Text color
                              textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: poppinsFont),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: const BorderSide(
                                      color: Color(0xFF99D6EF))),
                              fixedSize: const Size(310, 40)),
                          child: const Text('Login'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildText(String text, {double fontSize = 12, Color? color}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: poppinsFont,
          fontSize: fontSize,
          fontWeight: fontSize == 12 ? FontWeight.normal : FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
