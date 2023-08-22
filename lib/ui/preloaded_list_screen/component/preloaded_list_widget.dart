import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spenza/ui/home/data/preloaded_list_model.dart';

class PreloadedListWidget extends ConsumerWidget {
  final List<PreloadedListModel> data;
  final Function(String) onButtonClicked;
  PreloadedListWidget( {required this.data, required this.onButtonClicked,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        PreloadedListModel item = data[index];
        return Card(
          color: Colors.white,
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
                      Text("Recibos ${item.count!}",style: TextStyle(fontSize: 13, )),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Do something when three dots are clicked
                    onButtonClicked(item.path);
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
}