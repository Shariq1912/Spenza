import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/ui/home/provider/fetch_mylist_provider.dart';
import 'package:spenza/utils/spenza_extensions.dart';

import '../../my_store_products/component/add_product_to_new_list.dart';
import '../../my_store_products/data/user_product_list_data.dart';
import '../../my_store_products/provider/add_product_to_my_list_provider.dart';
import '../data/my_list_model.dart';

class CustomDialog extends ConsumerStatefulWidget {
  final String productId;
  final String productRef;

  CustomDialog({Key? key, required this.productId, required this.productRef})
      : super(key: key);

  @override
  ConsumerState<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends ConsumerState<CustomDialog> {
  final poppinsFont = GoogleFonts.poppins().fontFamily;

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

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(),
      child: contentBox(context),
      elevation: 0,
    );
  }

  contentBox(context) {
    return Container(
      height: 500,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
        child: Column(
          children: [
            Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.close,
                      color: Color(0xFF7B868C),
                      size: 35,
                    ))),
            Text(
              "Choose your list where you want to add product",
              style: TextStyle(
                  color: Color(0xFF0da9ea),
                  fontFamily: poppinsFont,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Consumer(builder: (context, ref, child) {
                final mylist = ref.watch(fetchMyListProvider);
                return mylist.when(
                  data: (data) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        MyListModel item = data[index];
                        var fileName = item.myListPhoto ?? "";
                        return Container(
                          color: Color(0xFFE5E7E8),
                          margin: EdgeInsets.only(top: 8, bottom: 8),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                width: 110,
                                height: 110,
                                child: CachedNetworkImage(
                                  width: 110,
                                  height: 110,
                                  fit: BoxFit.cover,
                                  imageUrl: fileName,
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                          'app_icon_spenza.png'.assetImageUrl),
                                ),
                              ),
                              SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () async {
                                  await ref
                                      .read(addProductToMyListProvider.notifier)
                                      .addProductToMyList(
                                    listId: item.documentId!,
                                    productRef: widget.productRef,
                                    productId: widget.productId,
                                    context: context,
                                  );
                                },
                                icon: Icon(Icons.playlist_add_rounded),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  error: (error, stackTrace) {
                    debugPrint("errorMrss $error");
                    return Center(child: Text(error.toString()));
                  },
                  loading: () => Center(child: CircularProgressIndicator()),
                );
              }),
            ),
            SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text("Add the product to a new list",
                  style: TextStyle(
                      color: Color(0xFF0da9ea),
                      fontFamily: poppinsFont,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddProductToNewList(
                        productId: widget.productId, productRef: widget.productRef),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0CA9E6),
                foregroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: poppinsFont,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                fixedSize: const Size(310, 40),
              ),
              child: Text("Create my list"),
            ),
          ],
        ),
      ),
    );
  }
}
