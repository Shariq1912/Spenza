import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/helpers/popup_menu_mixin.dart';
import 'package:spenza/ui/home/data/my_list_model.dart';
import 'package:spenza/utils/spenza_extensions.dart';

import '../../../router/app_router.dart';
import '../../../utils/color_utils.dart';

class MyListWidget extends StatelessWidget {
  const MyListWidget(
      {super.key, required this.stores, required this.onButtonClicked,required this.onPopUpClicked});

  final List<MyListModel> stores;
  final Function(String store, String name, String photo, String? path) onButtonClicked;
  final Function(String store, PopupMenuAction action) onPopUpClicked;


  @override
  Widget build(BuildContext context) {
    final poppinsFont = GoogleFonts.poppins().fontFamily;
    final robotoFont = GoogleFonts.roboto().fontFamily;
    if(stores.isEmpty){
      return Center(
        child: Text(
          "No data available",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: poppinsFont),
        ),
      );
    }else
      return ListView.builder(
        itemCount: stores.length,
        itemBuilder: (context, index) {
          MyListModel store = stores[index];

          return GestureDetector(
            onTap: (){
              onButtonClicked(store.documentId!, store.name, store.myListPhoto!, store.path!);
            },
            child: Column(
              children: [
                /*Divider(
                  height: 1,
                  color: ColorUtils.colorSurface,
                ),*/
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: store.myListPhoto!.isNotEmpty
                            ? CachedNetworkImage(
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                            imageUrl: store.myListPhoto!,
                            errorWidget: (builder, error, url)=> Image.asset(
                                'app_icon_spenza.png'.assetImageUrl)
                        )
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
                            Text(
                              store.name,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: robotoFont ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              maxLines:1,
                               store.description,
                              style: TextStyle(fontSize: 13, fontFamily: robotoFont),
                            ),
                            SizedBox(height: 33),
                            Row(
                              children: [
                                Icon(Icons.upload_file, color: int.parse(store.count!) > 0 ? ColorUtils.colorPrimary : Colors.red,size: 20,),
                                SizedBox(width: 4),
                                Text(
                                  int.parse(store.count!) > 0 ? "${store.count!} Receipt": "Upload receipt",
                                  style: TextStyle(
                                    color: int.parse(store.count!) > 0 ? ColorUtils.primaryText : Colors.red,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: robotoFont
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SpeedDial(
                        activeBackgroundColor: Color(0xFFE5E7E8),
                        icon: Icons.more_vert,
                        activeIcon: Icons.close,
                        backgroundColor: Colors.white,
                        foregroundColor: Color(0xFF7B868C),
                        direction: SpeedDialDirection.left,
                        childrenButtonSize: Size(45.0, 45.0),
                        mini: true,
                        closeManually: false,
                        overlayOpacity: 0.7,
                        elevation: 0.0,
                        shape: CircleBorder(),
                        childMargin: EdgeInsets.symmetric(horizontal: 5),
                        children: [
                          SpeedDialChild(
                            child: Image.asset("edit_pen.png".assetImageUrl,
                              fit: BoxFit.contain,
                              width: 18,
                              height: 18,
                              color: Colors.white,),
                            backgroundColor: ColorUtils.colorPrimary,
                            foregroundColor: Colors.white,
                            shape: CircleBorder(),
                            labelStyle: TextStyle(fontSize: 18.0),
                            onTap: () {
                              onPopUpClicked(store.path!, PopupMenuAction.edit);
                            },
                          ),
                          SpeedDialChild(
                            child:  Image.asset("cloud_upload.png".assetImageUrl,
                                   fit: BoxFit.contain,
                                width: 23,
                                height: 23,
                            color: Colors.white,),

                            backgroundColor: ColorUtils.colorPrimary,
                            foregroundColor: Colors.white,
                            shape: CircleBorder(),
                            labelStyle: TextStyle(fontSize: 18.0),
                            onTap: () {
                              onPopUpClicked(store.path!, PopupMenuAction.upload);
                            },
                          ),
                          SpeedDialChild(
                            shape: CircleBorder(),
                            child: Image.asset("receipts.png".assetImageUrl,
                              fit: BoxFit.contain,
                              width: 18,
                              height: 18,
                              color: Colors.white,),
                            foregroundColor: Colors.white,
                            backgroundColor: ColorUtils.colorPrimary,
                            labelStyle: TextStyle(fontSize: 18.0),
                            onTap: ()  {
                              onPopUpClicked(store.path!,PopupMenuAction.receipt);
                            },
                          ),
                          SpeedDialChild(
                            shape: CircleBorder(),
                            child: Image.asset("Copy.png".assetImageUrl,
                              fit: BoxFit.contain,
                              width: 18,
                              height: 18,
                              color: Colors.white,),
                            foregroundColor: Colors.white,
                            backgroundColor: ColorUtils.colorPrimary,
                            labelStyle: TextStyle(fontSize: 18.0),
                            onTap: () {
                              onPopUpClicked(store.path!, PopupMenuAction.copy);
                            },
                          ),
                          SpeedDialChild(
                            shape: CircleBorder(),
                            child: Image.asset("delete.png".assetImageUrl,
                              fit: BoxFit.contain,
                              width: 18,
                              height: 18,
                              color: Colors.white,),
                            foregroundColor: Colors.white,
                            backgroundColor: ColorUtils.colorPrimary,
                            labelStyle: TextStyle(fontSize: 18.0),
                            onTap: () {
                              onPopUpClicked(store.path!,PopupMenuAction.delete);
                            },
                          ),


                        ],
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  color: ColorUtils.colorSurface,
                ),
              ],
            ),
          );
        },
      );
  }



}
