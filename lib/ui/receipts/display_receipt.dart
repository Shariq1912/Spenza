import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/ui/receipts/component/my_receipt_widget.dart';
import 'package:spenza/ui/receipts/provider/fetch_receipt_provider.dart';


class DisplayReceiptScreen extends ConsumerStatefulWidget{
  const DisplayReceiptScreen({super.key, required this.path});

  final String path;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DisplayReceiptScreen();

}

class _DisplayReceiptScreen extends ConsumerState<DisplayReceiptScreen>{
  final poppinsFont = GoogleFonts.poppins().fontFamily;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAllMyList();
    });
  }

  Future<void> _loadAllMyList() async {
    await ref.read(fetchReciptProviderProvider.notifier).fetchReceipt(widget.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Text(
          "Receipts",
          style: TextStyle(
            fontFamily: poppinsFont,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xFF0CA9E6),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF0CA9E6)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
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
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Consumer(
          builder: (context, ref, child) {
            final storeProvider = ref.watch(fetchReciptProviderProvider);
            return storeProvider.when(

              loading: () => Center(child: CircularProgressIndicator()),
              error: (error,stackTrace) {
                print("errorMrss $error");
                return Center(child: Text(error.toString()));
              },
              data: (data) {
                print("receiptData $data");
                return MyReceiptWidget(receipt: data,);
              },
            );
          },
        ),
      ),
    );
  }
}