import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/helpers/popup_menu_mixin.dart';
import 'package:spenza/ui/home/data/preloaded_list_model.dart';
import 'package:spenza/utils/color_utils.dart';
import 'package:spenza/utils/spenza_extensions.dart';

class PreloadedListWidget extends ConsumerWidget {
  final List<PreloadedListModel> data;
  final Function(String, PopupMenuAction action) onButtonClicked;
  final Function(String , String, String) onCardClicked;
  PreloadedListWidget( {required this.data, required this.onButtonClicked, required this.onCardClicked});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final robotoFont = GoogleFonts.roboto().fontFamily;
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        PreloadedListModel item = data[index];
        return GestureDetector(
          onTap: (){
            onCardClicked(item.id, item.name, item.preloadedPhoto);
          },
          child: Column(
            children: [
              Divider(
                height: 1,
                color: ColorUtils.colorSurface,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        item.preloadedPhoto,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,fontFamily: robotoFont),
                          ),
                          SizedBox(height: 3),
                          Text(item.description.length > 50 ? '${item.description.substring(0, 50)}...' : item.description,
                            style: TextStyle(fontSize: 13,
                            fontFamily: robotoFont),),
                          SizedBox(height: 14),
                          //Text("Recibos ${item.count!}",style: TextStyle(fontSize: 13, )),
                          Row(
                            children: [
                              Icon(Icons.upload_file, color: int.parse(item.count!) > 0 ? ColorUtils.colorPrimary : Colors.red,size: 20,),
                              SizedBox(width: 4), // Add some space between the icon and text
                              Text(
                                int.parse(item.count!) > 0 ? "${item.count!} Receipt": "Upload receipt",
                                style: TextStyle(
                                  color: int.parse(item.count!) > 0 ? ColorUtils.primaryText : Colors.red,
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
                    /*IconButton(
                      onPressed: () {
                        print("three ${item.path}");
                        // Do something when three dots are clicked
                        onButtonClicked(item.path);
                      },
                      icon: Icon(Icons.more_vert),
                    ),*/
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
                      overlayOpacity: 0.5,
                      elevation: 0.0,
                      shape: CircleBorder(),
                      childMargin: EdgeInsets.symmetric(horizontal: 5),
                      children: [

                        SpeedDialChild(
                          child:Image.asset("cloud_upload.png".assetImageUrl,
                            fit: BoxFit.contain,
                            width: 23,
                            height: 23,
                            color: Colors.white,),
                          backgroundColor: ColorUtils.colorPrimary,
                          foregroundColor: Colors.white,
                          shape: CircleBorder(),
                          labelStyle: TextStyle(fontSize: 18.0),
                          onTap: () {
                            onButtonClicked(item.path!, PopupMenuAction.upload);
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
                            onButtonClicked(item.path!,PopupMenuAction.receipt);
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
                            onButtonClicked(item.path!, PopupMenuAction.copy);
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
