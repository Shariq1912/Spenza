import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/ui/my_store_products/component/product_card_widgets.dart';
import 'package:spenza/ui/my_store_products/data/products.dart';
import 'package:spenza/ui/my_store_products/repo/my_store_product_repository.dart';

import 'component/my_product_list_widget.dart';

class MyStoreProduct extends ConsumerStatefulWidget{
  const MyStoreProduct({Key ? key,required this.documentId, }) : super(key: key);
  final String documentId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyStoreProductState();
}

class _MyStoreProductState extends ConsumerState<MyStoreProduct>{

  final poppinsFont = GoogleFonts.poppins().fontFamily;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProducts();
    });
  }

  _loadProducts() async{
    await ref.read(myStoreProductRepositoryProvider.notifier).getProductsForStore(widget.documentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Text(
          "Stores",
          style: TextStyle(
            fontFamily: poppinsFont,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xFF0CA9E6),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back_ios, color: Color(0xFF0CA9E6))),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              top: 5,
            ),
            child: InkWell(
              onTap: () {
                //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SettingScreen()));
              },
              child: CircleAvatar(
                radius: 40,
                child: ClipOval(
                  child: Image.network('https://picsum.photos/250?image=9'),
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Consumer(
          builder: (context, ref, child) {
            final productProvider = ref.watch(myStoreProductRepositoryProvider);
            return productProvider.when(
                  () => Container(),
              loading: () => Center(child: CircularProgressIndicator()),
              error: (message) {
                print("errorMrss $message");
                return Center(child: Text(message));
              },
              success: (data) {

                print("productData $data");
                return MyProductListWidget(stores: data, onButtonClicked: (Product product) {});
              },
            );
          },
        ),
        /*Expanded(
          child: Consumer(
            builder: (context, ref, child) => ref
                .watch(myStoreProductRepositoryProvider)
                .when(
                    () => Container(),
                loading: () => Center(child: CircularProgressIndicator()),
                error: (message) {
                  print("errorMrss $message");
                  return Center(child: Text(message));
                },
                success: (data) =>ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final Product product = data[index];
                    return ProductCardWidget(
                      *//*onClick: () => ref
                          .read(addProductProvider.notifier)
                          .addProductToUserList(
                        context,
                        product: product,
                        userListId: widget.userListId,
                      ),*//*
                      measure: product.measure,
                      imageUrl: product.pImage ??
                          'https://picsum.photos/250?image=9',
                      title: product.name,
                      *//*priceRange:
                      "\$${product.minPrice} - \$${product.maxPrice}",*//*
                    );
                  },
                ),)

          ),
        ),*/
      ),
    );
  }
}