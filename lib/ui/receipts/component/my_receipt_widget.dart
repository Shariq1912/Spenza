import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/ui/receipts/data/receipt_model.dart';
import 'package:spenza/utils/spenza_extensions.dart';

class MyReceiptWidget extends ConsumerWidget {
   MyReceiptWidget({ required this.receipt, /*required this.onButtonClicked*/});

  final List<ReceiptModel> receipt;
  //final Function(String store) onButtonClicked;




  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final poppinsFont = GoogleFonts.poppins().fontFamily;
    return ListView.builder(
      itemCount: receipt.length,
      itemBuilder: (context, index) {
        ReceiptModel store = receipt[index];
        return
          Card(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: store.receipt!.isNotEmpty
                          ? CachedNetworkImage(
                        width: 90,
                        height: 90,
                        fit: BoxFit.fill,
                        imageUrl: store.receipt!,
                      )
                          : Image.asset(
                        'favicon.png'.assetImageUrl,
                        fit: BoxFit.cover,
                      )
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          store.name!,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                        ),
                        SizedBox(height: 3),
                        Text(store.description!.length > 50 ? '${store.description!.substring(0, 60)}...' : store.description!,
                          style: TextStyle(fontSize: 13, ),),
                        SizedBox(height: 14),
                        Text("Completed : ${store.date!}",style: TextStyle(fontSize: 13,color: Colors.lightGreen )),

                      ],
                    ),
                  ),

                ],
              ),
            ),
          );
      },
    );
  }

}