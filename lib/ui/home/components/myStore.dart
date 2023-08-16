import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/my_store/data/all_store.dart';
import '../../my_store_products/my_store_product.dart';

class MyStores extends ConsumerWidget {
  final List<AllStores> data;
  final poppinsFont = GoogleFonts.poppins().fontFamily;

  MyStores({required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'My Store',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Color(0xFF0CA9E6),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: poppinsFont,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    context.push(RouteManager.stores);
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
          height: 200,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (context, index) {
                AllStores store = data[index];
                var fileName = store.logo;
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MyStoreProduct(
                          documentId: store.documentId!,
                          logo: store.logo,
                        ),
                      ),
                    );
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
                            fit: BoxFit.fitWidth,
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

