import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/ui/home/components/image_text_card.dart';
import 'package:spenza/utils/spenza_extensions.dart';

import '../../../utils/color_utils.dart';
import '../data/preloaded_list_model.dart';

class PreLoadedList extends ConsumerWidget {
  final List<PreloadedListModel> data;
  final String title;
  final TextStyle poppinsFont;
  final VoidCallback onAllClicked;

  final Function(String listId, String name, String photo) onListTap;

  PreLoadedList({
    required this.data,
    required this.title,
    required this.poppinsFont,
    required this.onAllClicked,
    required this.onListTap,
  });
  final arialFont = GoogleFonts.openSans().fontFamily;
  final robotoFont = GoogleFonts.roboto().fontFamily;
  final poppinFont = GoogleFonts.poppins().fontFamily;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            onAllClicked();
          },
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: poppinFont,
                      decoration: TextDecoration.none,
                      color: ColorUtils.primaryText,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: 13,
                    width: 13,
                    child: Image.asset(
                      "forward_Icon_1a1a1a.png".assetImageUrl,
                      color: ColorUtils.primaryText,

                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        Container(
          color: ColorUtils.colorWhite,
          height: 180,
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: data.isNotEmpty
                ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (context, index) {
                PreloadedListModel store = data[index];
                return ImageTextCard(
                  imageUrl: store.preloadedPhoto,
                  title: store.name,
                  onTap: () => onListTap.call(store.id, store.name, store.preloadedPhoto),
                );
              },
            ):Center(
              child: Text(
                "No data available.",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: poppinsFont.fontFamily,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
