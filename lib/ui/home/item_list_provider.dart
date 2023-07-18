import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final itemListProvider = StateNotifierProvider<ItemListNotifier, List<Item>>((ref) {
  return ItemListNotifier();
});

class Item {
  final String name;
  final String description;
  final File image;

  Item( {required this.name, required this.description,required this.image,});
}

class ItemListNotifier extends StateNotifier<List<Item>> {
  ItemListNotifier() : super([]);

  void addItem(String name, String description, File image) {
    state = [...state, Item(name: name, description: description, image: image)];
  }
}
