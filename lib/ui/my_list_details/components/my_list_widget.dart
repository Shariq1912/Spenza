import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/ui/home/data/my_list_model.dart';
import 'package:spenza/utils/spenza_extensions.dart';

class MyListWidget extends StatelessWidget {
  const MyListWidget(
      {super.key, required this.stores, required this.onButtonClicked});

  final List<MyListModel> stores;
  final Function(String store) onButtonClicked;




  @override
  Widget build(BuildContext context) {
    final poppinsFont = GoogleFonts.poppins().fontFamily;
    return ListView.builder(
      itemCount: stores.length,
      itemBuilder: (context, index) {
        MyListModel store = stores[index];

        return Card(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: ListTile(
            leading: store.myListPhoto!.isNotEmpty
                ? CachedNetworkImage(
              width: 60,
              height: 80,
              fit: BoxFit.fill,
              imageUrl: store.myListPhoto!,
            )
                : Image.asset(
              'favicon.png'.assetImageUrl,
              fit: BoxFit.cover,
            ),
            title: Text(
              store.name,
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, fontFamily: poppinsFont),
            ),
            subtitle: Text(store.description, style: TextStyle(fontFamily: poppinsFont),),

            onTap: (){
              print(store.documentId);
              onButtonClicked.call(store.documentId!);

            },
          ),
        );
         /* Card(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: item.myListPhoto!.isNotEmpty
                        ? CachedNetworkImage(
                      width: 50,
                      height: 50,
                      fit: BoxFit.fill,
                      imageUrl: item.myListPhoto!,
                    )
                        : Image.asset(
                      'favicon.png'.assetImageUrl,
                      fit: BoxFit.cover,
                    )
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


                      ],
                    ),
                  ),
                  *//*IconButton(
                    onPressed: () {
                      // Do something when three dots are clicked
                    },
                    icon: Icon(Icons.more_vert),
                  ),*//*
                ],
              ),
            ),
          );*/
      },
    );
  }
}