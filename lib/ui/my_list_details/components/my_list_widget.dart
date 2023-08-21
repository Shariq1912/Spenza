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




 /* @override
  Widget build(BuildContext context) {
    final poppinsFont = GoogleFonts.poppins().fontFamily;
    return ListView.builder(
      itemCount: stores.length,
      itemBuilder: (context, index) {
        MyListModel store = stores[index];

        return Card(
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
                    )
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          store.name,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                        ),
                        SizedBox(height: 3),
                        Text(store.description.length > 50 ? '${store.description.substring(0, 50)}...' : store.description,
                          style: TextStyle(fontSize: 13, ),),
                        SizedBox(height: 14),
                        Text("8 receipt",style: TextStyle(fontSize: 13, )),

                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                    },
                    icon: Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
          );
      },
    );
  }*/

  @override
  Widget build(BuildContext context) {
    final poppinsFont = GoogleFonts.poppins().fontFamily;
    return ListView.builder(
      itemCount: stores.length,
      itemBuilder: (context, index) {
        MyListModel store = stores[index];

        return Card(
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
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 3),
                      Text(
                        store.description.length > 50 ? '${store.description.substring(0, 50)}...' : store.description,
                        style: TextStyle(fontSize: 13),
                      ),
                      SizedBox(height: 14),
                      Text("8 receipt", style: TextStyle(fontSize: 13)),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _showPopupMenu(context);
                  },
                  icon: Icon(Icons.more_vert),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPopupMenu(BuildContext context) async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(1000, 0, 0, 0), // Adjust position as needed
      items: [
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.copy),
            title: Text('Copy'),
            onTap: () {
              // Handle copy action
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.edit),
            title: Text('Edit'),
            onTap: () {
              // Handle edit action
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.upload),
            title: Text('Upload'),
            onTap: () {
              // Handle upload action
            },
          ),
        ),
      ],
    );
  }

}