import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/ui/home/repo/fetch_favourite_store_repository.dart';
import 'package:spenza/ui/my_store/data/all_store.dart';

import '../../../router/app_router.dart';
import '../../my_store/my_store.dart';

class MyStores extends ConsumerStatefulWidget {
  @override
  ConsumerState<MyStores> createState() => _MyStoresState();
}

class _MyStoresState extends ConsumerState<MyStores> {
  final poppinsFont = GoogleFonts.poppins().fontFamily;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAllStore();
    });
  }

  _loadAllStore() async {
    await ref
        .read(fetchFavouriteStoreRepositoryProvider.notifier)
        .fetchAndDisplayFavouriteStores();
  }

  @override
  Widget build(BuildContext context) {
    return _myStoriesWidget();
  }

  Widget _myStoriesWidget() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'My Store',
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Color(0xFF0CA9E6),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: poppinsFont),
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Stores()));
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFF0CA9E6),
                      size: 32,
                    )),
              ),
            )
          ],
        ),
        SizedBox(
          height: 200,
          child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Consumer(
                builder: (context, ref, child) {
                  final favProvider = ref.watch(fetchFavouriteStoreRepositoryProvider);
                  return favProvider.when(
                        () => Container(),
                    loading: () => Center(child: CircularProgressIndicator()),
                    error: (message) => Center(child: Text(message)),
                    success: (data) {
                      if (data.isEmpty) {
                        return Center(child: Text("No stores available"));
                      } else {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            AllStores store = data[index];
                            var fileName = store.logo;
                            return SizedBox(
                              width: 100,
                              child: Card(
                                elevation: 0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: fileName,
                                      fit: BoxFit.fitWidth,
                                      width: 100,
                                      height: 100,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                    redirectUser: () {
                      /*context.goNamed(RouteManager.homeScreen);*/
                      return Container();
                    },
                  );
                },
              )

          ),
        )
      ],
    );
  }

  Widget myStoryListItem() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 100,
          height: 100,
          color: Colors.red,
        ),
      ],
    );
  }
}
