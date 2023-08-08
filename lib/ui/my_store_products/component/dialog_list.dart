import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spenza/ui/home/components/add_list.dart';
import 'package:spenza/ui/home/data/my_list_model.dart';
import 'package:spenza/ui/my_store_products/component/add_product_to_new_list.dart';
import 'package:spenza/ui/my_store_products/data/user_product_list_data.dart';
import 'package:spenza/ui/my_store_products/repo/my_store_product_repository.dart';

import '../../home/repo/my_list_repository.dart';

class MyListDialog extends ConsumerStatefulWidget {
  final String productId;
  final String productRef;
  MyListDialog({Key? key, required this.productId, required this.productRef}) : super(key: key);

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
    await ref.read(myListRepositoryProvider.notifier).fetchMyList();
  }


    UserProductData myListData = UserProductData(
       productId: "");

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
      title: Text("My List",style: TextStyle(fontSize: 16),),
      content: Container(
        width: double.maxFinite,
        child: Consumer(builder: (context, ref, child) {
          final mylist = ref.watch(myListRepositoryProvider);
          return mylist.when(() => Container(),
              loading: () => Center(child: CircularProgressIndicator()),
              error: (error) {
                print("errorMrss $error");
                return Center(child: Text(error));
              },
              success: (data) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    MyListModel item = data[index];
                    var fileName = item.myListPhoto ?? "" ;
                    return Card(
                      color: Colors.white,
                      child: ListTile(
                        leading: leadingWidget(fileName),
                        title: Text(item.name),
                        trailing: IconButton(onPressed: ()async{
                          await ref.read(myStoreProductRepositoryProvider.notifier).addProductToMyList(item.documentId!,  widget.productId, widget.productRef);
                          Navigator.pop(context);
                          _showSnackbar(context, "Product added successfully");
                        }, icon: Icon(Icons.playlist_add_sharp)),
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
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddProductToNewList(productId: widget.productId, productRef: widget.productRef)));
          },
          child: Text("Create new list"),
        ),
        SizedBox(width: 50,),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Close"),
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
