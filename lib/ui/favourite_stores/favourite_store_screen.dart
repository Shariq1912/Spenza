import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/favourite_stores/favorite_provider.dart';
import 'package:spenza/ui/favourite_stores/widgets/custom_searchbar.dart';
import 'package:spenza/ui/favourite_stores/widgets/favorite_store_list_widget.dart';
import 'package:spenza/utils/spenza_extensions.dart';

import 'data/favourite_stores.dart';

class FavouriteStoreScreen extends ConsumerStatefulWidget {
  const FavouriteStoreScreen(this.title, {Key? key}) : super(key: key);
  final String? title;

  @override
  ConsumerState createState() => _FavouriteStoreScreenState();
}

class _FavouriteStoreScreenState extends ConsumerState<FavouriteStoreScreen> {
  final poppinsFont = GoogleFonts.poppins().fontFamily;
  late CustomSearchDelegate _searchDelegate;
  String searchInput="";
  @override
  void initState() {
    _loadStores();
    _searchDelegate = CustomSearchDelegate([]);
    super.initState();
  }

  _loadStores() async {
    await ref.read(favoriteProvider.notifier).getStores();
  }

  @override
  Widget build(BuildContext buildContext) {


    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Favourite stores",
          style: TextStyle(
            fontFamily: poppinsFont,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xFF0CA9E6),
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 5,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.grey,
        centerTitle: true,
        /*actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: _searchDelegate);
            },
            icon: const Icon(Icons.search),
          )
        ],*/
      ),
      body: Stack(
        children: [

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Consumer(
              builder: (context, ref, child) {
                final storeProvider = ref.watch(favoriteProvider);

                return storeProvider.when(
                  () => Container(),
                  loading: () => Center(child: CircularProgressIndicator()),
                  error: (message) => Center(child: Text(message)),
                  // success: (stores) => Container(),
                  success: (data) {
                    // debugPrint("$data");
                    return /*FavoriteStoreListWidget(
                      stores: data,
                      onButtonClicked: (Stores store) {
                        ref
                            .read(favoriteProvider.notifier)
                            .toggleFavorite(store);
                      },
                    );*/
                       SearchableList<Stores>(
                         displayClearIcon: true,
                          initialList: data,
                          builder: ( filteredList) => ListTile(
                            leading: filteredList.logo.isNotEmpty
                                ? Image.network(
                              filteredList.logo,
                              fit: BoxFit.cover,
                            )
                                : Image.asset(
                              'favicon.png'.assetImageUrl,
                              // Replace with the path to your static image asset
                              fit: BoxFit.cover,
                            ),
                            title: Text(filteredList.name),
                            subtitle: Text(filteredList.adress.substring(0,40)),
                            trailing: IconButton(
                              onPressed: () {
                                ref
                                    .read(favoriteProvider.notifier)
                                    .toggleFavorite(filteredList);
                              },
                              icon: filteredList.isFavorite
                                  ? Icon(Icons.favorite_outlined, color: Colors.red)
                                  : Icon(Icons.favorite_border_outlined),
                            ),
                          ),
                          filter: (value) => data.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList(),
                          emptyWidget: const Text("empty"),
                          inputDecoration: InputDecoration(
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),),
                            focusedBorder: OutlineInputBorder(
                              /*borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),*/
                            ),
                        ),
                      );

                  },
                  redirectUser: () {
                    buildContext.goNamed(RouteManager.homeScreen);
                    return Container();
                  },
                );
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ElevatedButton(
              onPressed: () {
                ref.read(favoriteProvider.notifier).saveFavouriteStoreIfAny();
                // context.goNamed(RouteManager.homeScreen);
              },
              child: Consumer(
                builder: (context, ref, child) {
                  final stores = ref.watch(favoriteProvider).maybeWhen(
                        () => [],
                        success: (stores) {
                          final filteredStores = stores
                              .where((store) => store.isFavorite)
                              .toList();
                          return filteredStores.isNotEmpty
                              ? filteredStores
                              : [];
                        },
                        orElse: () => [],
                      );

                  return stores.length > 0 ? Text("Continue") : Text("Skip");
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
