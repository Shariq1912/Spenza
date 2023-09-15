import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/ui/receipts/data/receipt_model.dart';
import 'package:spenza/utils/color_utils.dart';
import 'package:spenza/utils/spenza_extensions.dart';

class MyReceiptWidget extends ConsumerWidget {
  MyReceiptWidget({
    required this.receipt,
    /*required this.onButtonClicked*/
  });

  final List<ReceiptModel> receipt;

  //final Function(String store) onButtonClicked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final poppinsFont = GoogleFonts.poppins().fontFamily;
    final robotoFont = GoogleFonts.roboto().fontFamily;
    if (receipt.isEmpty) {
      return Center(
        child: Text(
          "No receipt available",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: poppinsFont),
        ),
      );
    } else
      return ListView.builder(
        itemCount: receipt.length,
        itemBuilder: (context, index) {
          ReceiptModel store = receipt[index];
          return Container(
            margin: EdgeInsets.only(bottom: 6),
            child: Stack(
              children: [
                Card(
                  shape: RoundedRectangleBorder(),
                  surfaceTintColor: Color(0xFFE5E7E8),
                  color: Color(0xFFE5E7E8),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          // borderRadius: BorderRadius.circular(8),
                          child: store.receipt!.isNotEmpty
                              ? CachedNetworkImage(
                              width: 100,
                              height: 100,
                              fit: BoxFit.fill,
                              imageUrl: store.receipt!,
                              errorWidget: (builder, error, url) =>
                                  Image.asset(
                                      'app_icon_spenza.png'.assetImageUrl))
                              : Image.asset(
                            'app_icon_spenza.png'.assetImageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.5),
                                    child: Icon(
                                      Icons.receipt,
                                      color: Color(0xFF7B868C),
                                      size: 22,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5.0, top: 3.5),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Shop date",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                              fontFamily: robotoFont,
                                              color: Color(0xFF7B868C),
                                              height: 1),
                                        ),
                                        Text(
                                          store.date!,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                              fontFamily: robotoFont,
                                              color: Color(0xFF7B868C),
                                              height: 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 3),
                              SizedBox(height: 35),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.5),
                                    child: Icon(
                                      Icons.circle,
                                      color: ColorUtils.colorSecondary,
                                      size: 22,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Store name",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                              fontFamily: robotoFont,
                                              color: Color(0xFF7B868C),
                                              height: 1),
                                        ),
                                        Text(
                                          "Walmart",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                              fontFamily: robotoFont,
                                              color: Color(0xFF7B868C),
                                              height: 1),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: 2,
                    right: 2,
                    child: SpeedDial(
                      activeBackgroundColor: Color(0xFFE5E7E8),
                      icon: Icons.more_vert,
                      activeIcon: Icons.close,
                      backgroundColor: Color(0xFFE5E7E8),
                      foregroundColor: Color(0xFF7B868C),
                      direction: SpeedDialDirection.left,
                      childrenButtonSize: Size(35.0, 35.0),
                      mini: true,
                      closeManually: false,
                      overlayOpacity: 0.0,
                      elevation: 0.0,
                      shape: CircleBorder(),
                      childMargin: EdgeInsets.symmetric(horizontal: 5),
                      children: [
                        SpeedDialChild(
                          child: Icon(
                            Icons.edit,
                            size: 20,
                          ),
                          backgroundColor: ColorUtils.colorPrimary,
                          foregroundColor: Colors.white,
                          shape: CircleBorder(),
                          labelStyle: TextStyle(fontSize: 18.0),
                          onTap: () {
                            //onPopUpClicked(store.path!, PopupMenuAction.edit);
                          },
                        ),
                        SpeedDialChild(
                          child: /* SvgPicture.asset("cloud_upload.svg".assetSvgIconUrl,
                                    colorFilter: ColorFilter.mode(Colors.white, BlendMode.clear)),*/
                          Icon(
                            Icons.delete,
                            size: 20,
                          ),
                          backgroundColor: ColorUtils.colorPrimary,
                          foregroundColor: Colors.white,
                          shape: CircleBorder(),
                          labelStyle: TextStyle(fontSize: 18.0),
                          onTap: () {
                            //  onPopUpClicked(store.path!, PopupMenuAction.upload);
                          },
                        ),
                      ],
                    )),
                Positioned(
                  bottom: 18,
                  right: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Paid",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            fontFamily: robotoFont,
                            color: Color(0xFF7B868C),
                            height: 1),
                      ),
                      Text(
                        " \$ ${store.amount ?? 'xxx'}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            fontFamily: robotoFont,
                            color: Color(0xFF7B868C),
                            height: 1),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      );
  }
}
