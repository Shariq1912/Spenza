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
      shape: RoundedRectangleBorder(),
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
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.close,
                      color: Color(0xFF7B868C),
                      size: 35,
                    ))),
            Center(
              child: Text(
                "Application Language",
                style: TextStyle(
                  color: ColorUtils.colorPrimary,
                  fontFamily: poppinsFont,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
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
                fontFamily: poppinsFont,
                fontWeight: FontWeight.w300,
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
                    fontFamily: poppinsFont,
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
                    fontFamily: poppinsFont,
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
