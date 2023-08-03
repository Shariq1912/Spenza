import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/ui/my_store_products/component/dialog_list.dart';
import 'package:spenza/ui/my_store_products/data/products.dart';
import 'package:spenza/ui/profile/profile_screen.dart';
import 'package:spenza/utils/spenza_extensions.dart';

class MyProductListWidget extends StatefulWidget {
  MyProductListWidget({
    Key? key,
    required this.stores,
    required this.onButtonClicked,
  }) : super(key: key);

  final List<Product> stores;
  final Function(Product store) onButtonClicked;

  final poppins = GoogleFonts.poppins().fontFamily;

  @override
  _MyProductListWidgetState createState() => _MyProductListWidgetState();
}

class _MyProductListWidgetState extends State<MyProductListWidget> {
  List<Product> filteredStores = [];

  @override
  void initState() {
    super.initState();
    filteredStores.addAll(widget.stores);
  }

  void _filterStores(String keyword) {
    setState(() {
      filteredStores = widget.stores
          .where((store) =>
              store.name.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if(widget.stores.isEmpty){
      return Center(child: Text("No data available", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.black,fontFamily: poppinsFont),),);
    } else{
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterStores,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                contentPadding:
                EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredStores.length,
              itemBuilder: (context, index) {
                Product store = filteredStores[index];




                return Card(
                  color: Colors.white,
                  surfaceTintColor: Colors.white,
                  //margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Stack(
                    children: [
                      ListTile(
                        horizontalTitleGap: 10,
                        leading: store.pImage.isNotEmpty
                            ? CachedNetworkImage(
                          width: 50,
                          height: 55,
                          fit: BoxFit.cover,
                          imageUrl: store.pImage,
                        )
                            : Image.asset(
                          'favicon.png'.assetImageUrl,
                          fit: BoxFit.cover,
                        ),
                        title: Text(store.name, style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold, color: Colors.black,fontFamily: poppinsFont),),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(store.measure, style: TextStyle(fontSize: 12, color: Colors.grey,),),
                            SizedBox(height: 5,),
                            Text("75.1 - 98.6", style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold, color: Colors.black,),),
                          ],
                        ),
                        onTap: () {
                          // Add your onTap logic here
                        },
                      ),
                      Positioned(
                        top: 30,
                        right: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF0CA9E6),
                            border: Border.all(
                              color: const Color(0xFF0CA9E6),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Text.rich(
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return MyListDialog(
                                        productId: store.documentId!,
                                      );
                                    },
                                  );
                                },
                              text: "Add to list ",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: widget.poppins,
                              ),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      );
    }

  }
}





