import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/ui/my_store_products/data/products.dart';
import 'package:spenza/ui/my_store_products/provider/product_for_store_provider.dart';
import 'package:spenza/ui/my_store_products/repo/department_repository.dart';

import '../../router/app_router.dart';
import 'component/my_product_list_widget.dart';

class MyStoreProduct extends ConsumerStatefulWidget{
  const MyStoreProduct({Key ? key,required this.documentId, required this.logo }) : super(key: key);
  final String documentId;
  final String logo;

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
    await ref.read(productForStoreProvider.notifier).getProductsForStore(widget.documentId);
    await ref.read(departmentRepositoryProvider.notifier).getDepartments();
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.pushReplacement(RouteManager.stores);
        return true;
      },
      child: Scaffold(
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
            icon: Icon(Icons.arrow_back_ios, color: Color(0xFF0CA9E6)),
          ),
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
                    child: CachedNetworkImage(imageUrl: widget.logo),
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
              final productProvider = ref.watch(productForStoreProvider);
              final departmentProvider = ref.watch(departmentRepositoryProvider);
              return productProvider.when(

                loading: () => Center(child: CircularProgressIndicator()),
                error: (error,stackTrace) {print("errorMrss $error");
                return Center(child: Text(error.toString()));},
                data: (data) {

                  /*print("productData $data");
                return MyProductListWidget(stores: data, onButtonClicked: (Product product) {});*/
                  return departmentProvider.when(
                        () => Container(),
                    loading: () => Center(child: CircularProgressIndicator()),
                    error: (message) {print("errorMrss $message");
                    return Center(child: Text(message));},
                    success: (departments) {
                      return MyProductListWidget(
                        stores: data,
                        department: departments,
                        onButtonClicked: (ProductModel product) {},
                      );
                    },);

                },
              );
            },
          ),
        ),
      ),
    );
  }

}