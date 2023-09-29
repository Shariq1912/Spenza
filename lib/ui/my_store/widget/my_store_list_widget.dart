import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/ui/my_store/data/all_store.dart';
import 'package:spenza/ui/my_store_products/my_store_product.dart';
import 'package:spenza/utils/color_utils.dart';
import 'package:spenza/utils/spenza_extensions.dart';

class MyStoreListWidget extends StatelessWidget {
  const MyStoreListWidget(
      {super.key, required this.stores, required this.onButtonClicked});

  final List<AllStores> stores;
  final Function(AllStores store) onButtonClicked;

  @override
  Widget build(BuildContext context) {
    final poppinsFont = GoogleFonts.poppins().fontFamily;
    final robotoFont = GoogleFonts.roboto().fontFamily;
    return ListView.builder(
      itemCount: stores.length,
      itemBuilder: (context, index) {
        AllStores store = stores[index];

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 0.0),
          child: GestureDetector(
            onTap: (){
              print(store.documentId);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MyStoreProduct(storeId: store.documentId!, logo: store.logo,),
                ),
              );
            },
            child: Column(
              children: [
                /*Divider(
                  height: 1,
                  color: ColorUtils.colorSurface,
                ),*/
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                          errorWidget: (context, url, error) => Image.asset(
                            "app_icon_spenza.png".assetImageUrl,
                            fit: BoxFit.fill,
                            width: 110,
                            height: 110,
                          ),
                          imageUrl: store.logo,
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              store.groupName,
                              style: TextStyle(
                                fontFamily: robotoFont,
                                fontSize: 12,
                                color: Color(0xFF7B868C),
                              ),
                            ),
                            Text(
                              store.name,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF323E48),
                              ),
                            ),
                            Text(
                              store.address.length > 30
                                  ? '${store.address.substring(0, 30)}...'
                                  : store.address,
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF323E48),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12),
                      Column(
                        children: [
                          SizedBox(
                            height: 1,
                          ),
                          ClipOval(
                            child: Material(
                              color: Colors.white,
                              child: InkWell(
                                splashColor:Color(0xFF7B868C),
                                onTap: () => onButtonClicked(store),
                                child: SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: store.isFavorite
                                        ? Icon(
                                            Icons.favorite_outlined,
                                            color: ColorUtils.colorPrimary,
                                            size: 25,
                                          )
                                        : Icon(
                                            Icons.favorite_border_outlined,
                                            color: ColorUtils.colorPrimary,
                                            size: 25,
                                          )),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  color: ColorUtils.colorSurface,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
