import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/ui/profile/profile_repository.dart';
import 'package:spenza/ui/receipts/component/my_receipt_widget.dart';
import 'package:spenza/ui/receipts/provider/fetch_receipt_provider.dart';
import 'package:spenza/utils/spenza_extensions.dart';


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

    print("PATH OF RECEIPT === ${widget.path}");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAllMyList();
    });
  }

  Future<void> _loadAllMyList() async {
    ref.read(profileRepositoryProvider.notifier).getUserProfileData();
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
        /*leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF0CA9E6)),
        ),*/
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: InkWell(
                onTap: () {
                  //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SettingScreen()));
                },
                child: Consumer(
                  builder: (context, ref, child) {
                    final profilePro = ref.watch(profileRepositoryProvider);
                    return profilePro.when(
                          () => Container(),
                      loading: () => Container(),
                      error: (message) => CircleAvatar(
                        radius: 40,
                        child: ClipOval(
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Image.asset(
                              'user_placeholder.png'.assetImageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      success: (data) {
                        if (data.profilePhoto != null && data.profilePhoto!.isNotEmpty) {
                          return CircleAvatar(
                            radius: 40,
                            child: ClipOval(
                              child: AspectRatio(
                                aspectRatio: 1.0,
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: data.profilePhoto!,
                                  placeholder: (context, url) =>  Image.asset('app_icon_spenza.png'.assetImageUrl),
                                  errorWidget: (context, url, error) => Image.asset('user_placeholder.png'.assetImageUrl),
                                ),
                              ),
                            ),
                          );

                        } else {
                          return CircleAvatar(
                            radius: 40,
                            child: ClipOval(
                              child: AspectRatio(
                                aspectRatio: 1.0,
                                child: Image.asset(
                                  'user_placeholder.png'.assetImageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    );
                  },
                )
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