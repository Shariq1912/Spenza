import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../router/app_router.dart';
import '../data/preloaded_list_model.dart';

class PreLoadedList extends ConsumerWidget {
  final List<PreloadedListModel> data;

   PreLoadedList({Key? key, required this.data}) : super(key: key);

  final poppinsFont = GoogleFonts.poppins().fontFamily;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'Preloaded list',
                style: TextStyle(
                  fontFamily: poppinsFont,
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
                  onPressed: () {
                    context.push(RouteManager.preLoadedListScreen);

                  },
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
                return GestureDetector(
                  onTap: () {
                    /*  Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MyStoreProduct(
                          documentId: store.documentId!,
                          logo: store.logo,
                        ),
                      ),
                    );*/
                  },
                  child: SizedBox(
                    width: 100,
                    child: Card(
                      color: Colors.white,
                      elevation: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            imageUrl: fileName,
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                          Text(store.name),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}




