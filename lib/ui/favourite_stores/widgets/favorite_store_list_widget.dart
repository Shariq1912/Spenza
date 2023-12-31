import 'package:flutter/material.dart';
import 'package:spenza/ui/favourite_stores/data/favourite_stores.dart';
import 'package:spenza/utils/spenza_extensions.dart';

class FavoriteStoreListWidget extends StatelessWidget {
  const FavoriteStoreListWidget(
      {super.key, required this.stores, required this.onButtonClicked});

  final List<Stores> stores;
  final Function(Stores store) onButtonClicked;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stores.length,
      itemBuilder: (context, index) {
        Stores store = stores[index];

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
                    // Replace with the path to your static image asset
                    fit: BoxFit.cover,
                  ),
            title: Text(store.name),
            subtitle: Text(store.address),
            trailing: IconButton(
              onPressed: () => onButtonClicked(store),
              icon: store.isFavorite
                  ? Icon(Icons.favorite_outlined, color: Colors.red)
                  : Icon(Icons.favorite_border_outlined),
            ),
          ),
        );
      },
    );
  }
}
