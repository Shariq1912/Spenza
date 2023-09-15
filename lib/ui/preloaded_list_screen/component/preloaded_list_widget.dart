import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:spenza/helpers/popup_menu_mixin.dart';
import 'package:spenza/ui/home/data/preloaded_list_model.dart';
import 'package:spenza/utils/color_utils.dart';

class PreloadedListWidget extends ConsumerWidget {
  final List<PreloadedListModel> data;
  final Function(String, PopupMenuAction action) onButtonClicked;
  final Function(String , String, String) onCardClicked;
  PreloadedListWidget( {required this.data, required this.onButtonClicked, required this.onCardClicked});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        PreloadedListModel item = data[index];
        return GestureDetector(
          onTap: (){
            onCardClicked(item.id, item.name, item.preloadedPhoto);
          },
          child: Card(
            surfaceTintColor: Color(0xFFE5E7E8),
            color: Color(0xFFE5E7E8),
            child: Padding(
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
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                        ),
                        SizedBox(height: 3),
                        Text(item.description.length > 50 ? '${item.description.substring(0, 50)}...' : item.description,
                          style: TextStyle(fontSize: 13, ),),
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
                        child:/* SvgPicture.asset("cloud_upload.svg".assetSvgIconUrl,
                              colorFilter: ColorFilter.mode(Colors.white, BlendMode.clear)),*/
                        Icon(Icons.upload_file_outlined, size: 20,),
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
                        child: Icon(Icons.receipt_long_rounded, size: 20,),
                        foregroundColor: Colors.white,
                        backgroundColor: ColorUtils.colorPrimary,
                        labelStyle: TextStyle(fontSize: 18.0),
                        onTap: ()  {
                          onButtonClicked(item.path!,PopupMenuAction.receipt);
                        },
                      ),
                      SpeedDialChild(
                        shape: CircleBorder(),
                        child: Icon(Icons.copy_all, size: 20,),
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
          ),
        );
      },
    );
  }
}
