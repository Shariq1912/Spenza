import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:spenza/ui/home/components/image_text_card.dart';

import '../../../router/app_router.dart';
import '../data/preloaded_list_model.dart';

class PreLoadedList extends ConsumerWidget {
  final List<PreloadedListModel> data;
  final String title;
  final TextStyle poppinsFont;
  final VoidCallback onAllClicked;

  PreLoadedList({
    required this.data,
    required this.title,
    required this.poppinsFont,
    required this.onAllClicked,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: poppinsFont.fontFamily,
                  decoration: TextDecoration.none,
                  color: Color(0xFF0CA9E6),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: onAllClicked,
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFF0CA9E6),
                    size: 32,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 180,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (context, index) {
                PreloadedListModel store = data[index];
                var fileName = store.preloaded_photo;
                return ImageTextCard(
                  imageUrl: fileName,
                  title: store.name,
                  onTap: () {},
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
