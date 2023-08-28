import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/ui/home/data/my_list_model.dart';
import 'package:spenza/utils/spenza_extensions.dart';

import '../../../router/app_router.dart';

class MyListWidget extends StatelessWidget {
  const MyListWidget(
      {super.key, required this.stores, required this.onButtonClicked,required this.onPopUpClicked});

  final List<MyListModel> stores;
  final Function(String store, String name, String photo, String? path) onButtonClicked;
  final Function(String store) onPopUpClicked;


  @override
  Widget build(BuildContext context) {
    final poppinsFont = GoogleFonts.poppins().fontFamily;
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
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: store.myListPhoto!.isNotEmpty
                        ? CachedNetworkImage(
                      width: 80,
                      height: 80,
                      fit: BoxFit.fill,
                      imageUrl: store.myListPhoto!,
                    )
                        : Image.asset(
                      'favicon.png'.assetImageUrl,
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
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: poppinsFont),
                        ),
                        SizedBox(height: 3),
                        Text(
                          store.description.length > 50 ? '${store.description.substring(0, 50)}...' : store.description,
                          style: TextStyle(fontSize: 13, fontFamily: poppinsFont),
                        ),
                        SizedBox(height: 14),
                        Text("${store.count!} recibos", style: TextStyle(fontSize: 13, fontFamily: poppinsFont)),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                     onPopUpClicked(store.path!);
                    },
                    icon: Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }



}