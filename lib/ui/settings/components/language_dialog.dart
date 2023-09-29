import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/l10n/provider/language_provider.dart';
import 'package:spenza/utils/color_utils.dart';
import 'package:spenza/utils/spenza_extensions.dart';

class LanguageDialog extends ConsumerStatefulWidget {


  LanguageDialog({Key? key})
      : super(key: key);

  @override
  ConsumerState<LanguageDialog> createState() => _LanguageDialogState();
}

class _LanguageDialogState extends ConsumerState<LanguageDialog> {
  final poppinsFont = GoogleFonts.poppins().fontFamily;
  final robotoFont = GoogleFonts.roboto().fontFamily;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadMyList();
    });
    super.initState();
  }

  _loadMyList() async {
    //await ref.read(fetchMyListProvider.notifier).fetchMyListFun();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17),
      ),
      child: contentBox(context),
      elevation: 0,
    );
  }

  contentBox(context) {
    return Container(
      height: 300,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
        child: Column(
          children: [
            Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: Image.asset(
                        "x_close.png".assetImageUrl,
                      ),
                    ),
                  ),
                )),
            Center(
              child: Text(
                "Application Language",
                style: TextStyle(
                  color: ColorUtils.colorPrimary,
                  fontFamily: robotoFont,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "The selected language will be applied to the entire application.",
              style: TextStyle(
                color: ColorUtils.primaryText,
                fontFamily: robotoFont,
                fontWeight: FontWeight.w300,
                fontSize: 16
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(

              title: Text(
                "English",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: robotoFont,
                    color: ColorUtils.primaryText),
              ),
              onTap: () async {
                ref.read(localeProvider.notifier)
                    .changeLanguage(SupportedLocale.en);
                Navigator.of(context).pop();
              },
            ),
            ListTile(

              title: Text(
                "Spanish",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: robotoFont,
                    color: ColorUtils.primaryText),
              ),
              onTap: () async {
                ref.read(localeProvider.notifier)
                    .changeLanguage(SupportedLocale.es);
                Navigator.of(context).pop();
              },
            ),

          ],
        ),
      ),
    );
  }
}
