import 'package:flutter/material.dart';
import 'package:spenza/ui/favourite_stores/data/favourite_stores.dart';
import 'package:spenza/ui/my_store/data/all_store.dart';
import 'package:spenza/utils/spenza_extensions.dart';

class MyStoreListWidget extends StatelessWidget {
  const MyStoreListWidget(
      {super.key, required this.stores, required this.onButtonClicked});

  final List<AllStores> stores;
  final Function(AllStores store) onButtonClicked;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stores.length,
      itemBuilder: (context, index) {
        AllStores store = stores[index];

        return Card(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: ListTile(
            leading: store.logo.isNotEmpty
                ? Image.network(
              store.logo,
              fit: BoxFit.cover,
            )
                : Image.asset(
              'favicon.png'.assetImageUrl,
              fit: BoxFit.cover,
            ),
            title: Text(store.name),
            subtitle: Text(store.adress),
            trailing: IconButton(
              onPressed: () => onButtonClicked(store),
              icon: Icon(Icons.favorite_outlined, color: Colors.red)
            ),
            onTap: (){
            },
          ),
        );
      },
    );
  }
}