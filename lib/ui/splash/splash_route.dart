import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/router/app_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        child: SingleChildScrollView(
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
                              AppLocalizations.of(context)!.welcome,
                              style: TextStyle(
                                fontFamily: poppinsFont,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF7B868C),
                              ),
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
                        const SizedBox(height: 22),
                        _buildText(
                          AppLocalizations.of(context)!.find_stores,
                          fontSize: 21,
                          color: const Color(0xFF0CA9E6),
                        ),
                        _buildText(
                          AppLocalizations.of(context)!.find_stores_description,
                          fontSize: 12,
                          color: const Color(0xFF7B868C),
                        ),
                        const SizedBox(height: 12),
                        _buildText(
                          AppLocalizations.of(context)!.make_shopping_list,
                          fontSize: 21,
                          color: const Color(0xFF0CA9E6),
                        ),
                        _buildText(
                          AppLocalizations.of(context)!
                              .make_shopping_list_description,
                          fontSize: 12,
                          color: const Color(0xFF7B868C),
                        ),
                        const SizedBox(height: 12),
                        _buildText(
                          AppLocalizations.of(context)!.compare_prices,
                          fontSize: 21,
                          color: const Color(0xFF0CA9E6),
                        ),
                        _buildText(
                          AppLocalizations.of(context)!
                              .compare_prices_description,
                          fontSize: 12,
                          color: const Color(0xFF7B868C),
                        ),
                        const SizedBox(height: 12),
                        _buildText(
                          AppLocalizations.of(context)!.shop_in_store_or_online,
                          fontSize: 21,
                          color: const Color(0xFF0CA9E6),
                        ),
                        _buildText(
                          AppLocalizations.of(context)!
                              .shop_in_store_or_online_description,
                          fontSize: 12,
                          color: const Color(0xFF7B868C),
                        ),
                        const SizedBox(height: 65),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              context.pushNamed(RouteManager.registerScreen);
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
                              ),
                              fixedSize: const Size(310, 40),
                            ),
                            child: Text(AppLocalizations.of(context)!.sign_up),
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
                              foregroundColor: const Color(0xFF0CA9E6),
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: poppinsFont,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side:
                                    const BorderSide(color: Color(0xFF99D6EF)),
                              ),
                              fixedSize: const Size(310, 40),
                            ),
                            child: Text(AppLocalizations.of(context)!.login),
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
