import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spenza/ui/home/components/add_list.dart';
import 'package:spenza/ui/home/data/my_list_model.dart';
import 'package:spenza/ui/home/provider/fetch_mylist_provider.dart';
import 'package:spenza/ui/my_store_products/component/add_product_to_new_list.dart';
import 'package:spenza/ui/my_store_products/data/user_product_list_data.dart';
import 'package:spenza/ui/my_store_products/provider/add_product_to_my_list_provider.dart';
import 'package:spenza/ui/my_store_products/repo/my_store_product_repository.dart';

import '../../home/provider/add_product_to_new_list_provider.dart';

class MyListDialog extends ConsumerStatefulWidget {
  final String productId;
  final String productRef;

  MyListDialog({Key? key, required this.productId, required this.productRef})
      : super(key: key);

  @override
  ConsumerState<MyListDialog> createState() => _MyListDialogState();
}

class _MyListDialogState extends ConsumerState<MyListDialog> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadMyList();
    });
    super.initState();
  }

  _loadMyList() async {
    await ref.read(fetchMyListProvider.notifier).fetchMyListFun();
  }

  UserProductData myListData = UserProductData(productId: "");

  //ref.read(myStoreProductRepositoryProvider.notifier).addProductToMyList(documentId, myListData);

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.white,
      title: Text(
        "My List",
        style: TextStyle(fontSize: 16),
      ),
      content: Container(
        width: double.maxFinite,
        child: Consumer(builder: (context, ref, child) {
          final mylist = ref.watch(fetchMyListProvider);
          return mylist.when(
              loading: () => Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) {
                print("errorMrss $error");
                return Center(child: Text(error.toString()));
              },
              data: (data) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    MyListModel item = data[index];
                    var fileName = item.myListPhoto ?? "";
                    return Card(
                      color: Colors.white,
                      child: ListTile(
                        leading: leadingWidget(fileName),
                        title: Text(item.name),
                        trailing: IconButton(
                            onPressed: () async {
                              await ref
                                  .read(addProductToMyListProvider.notifier)
                                  .addProductToMyList(
                                    item.documentId!,
                                    widget.productId,
                                    context,
                                  );
                            },
                            icon: Icon(Icons.playlist_add_sharp)),
                      ),
                    );
                  },
                );
              });
        }),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // todo change to go router
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => AddProductToNewList(
                        productId: widget.productId,
                        productRef: widget.productRef)));
          },
          child: Text(
            "Create new list",
            style: TextStyle(color: Color(0xFF0CA9E6)),
          ),
        ),
        SizedBox(
          width: 50,
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "Close",
            style: TextStyle(color: Color(0xFF0CA9E6)),
          ),
        ),
      ],
    );
  }

  Widget leadingWidget(String fileName) {
    if (fileName.isEmpty) {
      return Image.asset(
        "assets/images/logo.png",
        fit: BoxFit.fill,
        width: 50,
        height: 80,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: fileName,
        fit: BoxFit.fill,
        width: 50,
        height: 80,
      );
    }
  }
}
