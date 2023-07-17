import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/favourite_stores/favorite_provider.dart';
import 'package:spenza/ui/location/lat_lng_provider.dart';
import 'package:spenza/ui/location/location_provider.dart';

import 'data/favourite_stores.dart';

class FavouriteStoreScreen extends ConsumerStatefulWidget {
  const FavouriteStoreScreen(this.title, {Key? key}) : super(key: key);
  final String? title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FavouriteStoreScreenState();
}

class _FavouriteStoreScreenState extends ConsumerState<FavouriteStoreScreen> {
  final poppinsFont = GoogleFonts.poppins().fontFamily;
  final myProducts = List<String>.generate(1000, (i) => 'Product $i');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(favoriteProvider);
    ref.watch(positionProvider).when(
          data: (data) => ref.read(favoriteProvider.notifier).getStores(data!),
          error: (error, stackTrace) {},
          loading: () {},
        );
    ref.watch(locationProvider(widget.title)).when(
          data: (data) => ref.read(favoriteProvider.notifier).getStores(data!),
          error: (error, stackTrace) {},
          loading: () {},
        );

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
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: provider.when(
              () => Container(),
              success: (stores) {
                return ListView.builder(
                  itemCount: stores.length,
                  itemBuilder: (context, index) {
                    Stores store = stores[index];

                    return Card(
                      color: Colors.white,
                      surfaceTintColor: Colors.white,
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: ListTile(
                        leading: store.logo.isNotEmpty
                            ? Image.network(
                                store.logo,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/favicon.png',
                                // Replace with the path to your static image asset
                                fit: BoxFit.cover,
                              ),
                        title: Text(store.name),
                        subtitle: Text(store.adress),
                        trailing: IconButton(
                          onPressed: () async {
                            ref
                                .read(favoriteProvider.notifier)
                                .toggleFavorite(store);
                          },
                          icon: store.isFavorite
                              ? Icon(Icons.favorite_outlined, color: Colors.red)
                              : Icon(Icons.favorite_border_outlined),
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () {
                return Center(child: CircularProgressIndicator());
              },
              error: (error) {
                return Center(child: Text('Error: $error'));
              },
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: ElevatedButton(
                onPressed: () {
                  context.goNamed(RouteManager.homeScreen);
                },
                child: Text("Skip"),
              )
          )
        ],
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Container();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

// second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }
}
