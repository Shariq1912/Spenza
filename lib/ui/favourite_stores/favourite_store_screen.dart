import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/common/spenza_circular_progress.dart';
import 'package:spenza/ui/favourite_stores/favorite_repository.dart';
import 'package:spenza/ui/favourite_stores/widgets/custom_searchbar.dart';
import 'package:spenza/ui/favourite_stores/widgets/favorite_store_list_widget.dart';

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
  String searchInput = "";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadStores();
    });

    _searchDelegate = CustomSearchDelegate([]);
    super.initState();
  }

  _loadStores() async {
    await ref.read(favoriteRepositoryProvider.notifier).getStores();
  }

  @override
  void dispose() {
    super.dispose();

    ref.invalidate(favoriteRepositoryProvider);
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
                final storeProvider = ref.watch(favoriteRepositoryProvider);

                return storeProvider.when(
                  () => Container(),
                  loading: () => Center(child: SpenzaCircularProgress()),
                  error: (message) => Center(child: Text(message)),
                  // success: (stores) => Container(),
                  success: (data) {
                    // debugPrint("$data");
                    return FavoriteStoreListWidget(
                      stores: data,
                      onButtonClicked: (Stores store) {
                        ref
                            .read(favoriteRepositoryProvider.notifier)
                            .toggleFavorite(store);
                      },
                    );
                    /*SearchableList<Stores>(
                      displayClearIcon: true,
                      initialList: data,
                      builder: (filteredList) => ListTile(
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
                        subtitle: Text(filteredList.address.substring(0, 40)),
                        trailing: IconButton(
                          onPressed: () {
                            ref
                                .read(favoriteRepositoryProvider.notifier)
                                .toggleFavorite(filteredList);
                          },
                          icon: filteredList.isFavorite
                              ? Icon(Icons.favorite_outlined, color: Colors.red)
                              : Icon(Icons.favorite_border_outlined),
                        ),
                      ),
                      filter: (value) => data
                          .where((element) => element.name
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList(),
                      emptyWidget: const Text("empty"),
                      inputDecoration: InputDecoration(
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            */ /*borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),*/ /*
                            ),
                      ),
                    );*/
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
                ref
                    .read(favoriteRepositoryProvider.notifier)
                    .saveFavouriteStoreIfAny();
                context.goNamed(RouteManager.homeScreen);
              },
              child: Consumer(
                builder: (context, ref, child) {
                  final length =
                      ref.watch(favoriteRepositoryProvider).maybeWhen(
                            () => [].length,
                            success: (stores) {
                              final filteredStores = stores
                                  .where((store) => store.isFavorite)
                                  .toList();
                              return filteredStores.isNotEmpty
                                  ? filteredStores.length
                                  : [].length;
                            },
                            loading: () => -1,
                            orElse: () => [].length,
                          );

                  return Visibility(
                    visible: length != -1,
                    child: length > 0 ? Text("Continue") : Text("Skip"),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
