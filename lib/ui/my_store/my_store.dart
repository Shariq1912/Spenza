import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/common/spenza_circular_progress.dart';
import 'package:spenza/ui/home/repo/fetch_favourite_store_repository.dart';
import 'package:spenza/ui/my_store/data/all_store.dart';
import 'package:spenza/ui/my_store/my_store_provider.dart';
import 'package:spenza/ui/my_store/widget/my_store_list_widget.dart';
import 'package:spenza/utils/spenza_extensions.dart';

import '../profile/profile_repository.dart';

class AllStoresScreen extends ConsumerStatefulWidget {
  const AllStoresScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StoresState();
}

class _StoresState extends ConsumerState<AllStoresScreen> {
  final poppinsFont = GoogleFonts.poppins().fontFamily;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAllStore();
    });
  }

  Future<void> _loadAllStore() async {
     ref.read(profileRepositoryProvider.notifier).getUserProfileData();
    await ref.read(allStoreProvider.notifier).fetchAllStores();
  }

  Future<void> _toggleFavorite(AllStores store) async {
    await ref.read(allStoreProvider.notifier).toggleFavoriteStore(store);

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
          onPressed: () async{
            await ref
                .read(fetchFavouriteStoreRepositoryProvider
                .notifier)
                .fetchFavStores();
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
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Consumer(
          builder: (context, ref, child) {
            final storeProvider = ref.watch(allStoreProvider);
            return storeProvider.when(
              () => Container(),
              loading: () => Center(child: SpenzaCircularProgress()),
              error: (message) {
                print("errorMrss $message");
                return Center(child: Text(message));
              },
              success: (data) {
                print("allStoredata $data");
                return MyStoreListWidget(
                  stores: data,
                  onButtonClicked: (AllStores allstore) {
                    _toggleFavorite(allstore);

                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
