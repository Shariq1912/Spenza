import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/ui/my_store/data/all_store.dart';
import 'package:spenza/utils/spenza_extensions.dart';

import '../../my_store/my_store_provider.dart';

class StorePickDialog extends ConsumerStatefulWidget {
  StorePickDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<StorePickDialog> createState() => _StorePickDialogState();
}

class _StorePickDialogState extends ConsumerState<StorePickDialog> {
  final poppinsFont = GoogleFonts.poppins().fontFamily;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadStore();
    });
    super.initState();
  }

  _loadStore() async {
    await ref.read(allStoreProvider.notifier).fetchAllStores();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17),
      ),
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
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 20,
                  width: 20,
                  child: Image.asset(
                    "x_close.png".assetImageUrl,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5,),
            Text(
              "Select the store for which you'd like to upload a receipt",
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
                final mylist = ref.watch(allStoreProvider);
                return mylist.when(
                  () => Container(),
                  success: (data) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        AllStores item = data[index];
                        var fileName = item.logo ?? "";
                        return Container(
                          color: Colors.white,
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
                              SizedBox(width: 1),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name.length > 12
                                        ? '${item.name.substring(0, 12)}...'
                                        : item.name,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () async {},
                                icon: Icon(Icons.playlist_add_rounded),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  error: (error) {
                    print("errorMrss $error");
                    return Center(child: Text(error.toString()));
                  },
                  loading: () => Center(child: CircularProgressIndicator()),
                );
              }),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {},
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
              child: Text("Pick Store"),
            ),
          ],
        ),
      ),
    );
  }
}
