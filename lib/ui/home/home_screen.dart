import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/helpers/bottom_nav_helper.dart';
import 'package:spenza/helpers/fireStore_pref_mixin.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/common/home_top_app_bar.dart';
import 'package:spenza/ui/home/provider/fetch_mylist_provider.dart';
import 'package:spenza/ui/home/provider/home_preloaded_list.dart';
import 'package:spenza/ui/home/repo/fetch_favourite_store_repository.dart';
import 'package:spenza/ui/profile/profile_repository.dart';
import 'package:spenza/utils/color_utils.dart';
import 'package:spenza/utils/spenza_extensions.dart';
import 'components/myStore.dart';
import 'components/preLoadedList.dart';
import 'components/shimmer_items/home_shimmer_list_view.dart';
import 'components/topStrip2.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with FirestoreAndPrefsMixin {
  final arialFont = GoogleFonts.openSans();
  final poppinsFont = GoogleFonts.poppins();
  String? postalCode;

  @override
  void initState() {
    super.initState();
    debugPrint("Init called From Home");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadStores();
    });
  }

  _loadStores() async {
    postalCode = await prefs.then((prefs) => prefs.getPostalCode());

    Future.wait([
      ref.read(profileRepositoryProvider.notifier).getUserProfileData(),
      ref.read(fetchMyListProvider.notifier).fetchMyListFun(),
      ref.read(homePreloadedListProvider.notifier).fetchPreloadedList(),
      ref.read(fetchFavouriteStoreRepositoryProvider.notifier).fetchFavStores()
    ]);
  }

  @override
  void dispose() {

    debugPrint("Dispose called From Home");

    ref.invalidate(fetchMyListProvider);
    ref.invalidate(fetchFavouriteStoreRepositoryProvider);
    ref.invalidate(homePreloadedListProvider);
    ref.invalidate(profileRepositoryProvider);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("pppp $postalCode");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeTopAppBar(
        poppinsFont: poppinsFont,
        title: "Start saving time and money!",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// My List
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  //constraints: BoxConstraints(minHeight: 100),
                  color: ColorUtils.colorWhite,
                  child: Consumer(
                    builder: (context, ref, child) =>
                        ref.watch(fetchMyListProvider).when(
                              data: (data) => TopStrip(
                                onListClick: (listId, name, photo, path) {
                                  ref
                                      .read(fetchMyListProvider.notifier)
                                      .redirectUserToListDetailsScreen(
                                          context: context,
                                          listId: listId,
                                          name: name,
                                          photo: photo,
                                          path: path);
                                },
                                data: data,
                                onCreateList: () async {
                                  final bool? result = await context
                                      .pushNamed(RouteManager.addNewList);
                                  if (result ?? false) {
                                    ref
                                        .read(fetchMyListProvider.notifier)
                                        .fetchMyListFun();
                                  }
                                },
                                onAllList: () {
                                  // context.pushNamed(RouteManager.myListScreen);
                                  StatefulNavigationShell.of(context).goBranch(screenNameToIndex[ScreenName.myList]!);

                                },
                              ),
                              error: (error, stackTrace) => Text('$error'),
                              loading: () => HomeShimmerListView(),
                            ),
                  ),
                ),
              ),
              /*Divider(
                color: Color(0xFFE5E7E8),
                thickness: 7,
              ),*/

              /// Pre Loaded List
              Consumer(
                builder: (context, ref, child) {
                  final preloadedProvider =
                      ref.watch(homePreloadedListProvider);
                  return preloadedProvider.when(
                    data: (data) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10).copyWith(top: 10),
                        child: PreLoadedList(
                          onListTap: (listId, name, photo) {
                            ref
                                .read(homePreloadedListProvider.notifier)
                                .redirectUserToListDetailsScreen(
                                    context: context,
                                    listId: listId,
                                    name: name,
                                    photo: photo,
                                    ref: ref);
                          },
                          data: data,
                          title:
                              AppLocalizations.of(context)!.preloadedListTitle,
                          poppinsFont: poppinsFont,
                          onAllClicked: () async {
                            final bool? result = await context
                                .pushNamed(RouteManager.preLoadedListScreen);

                            if (result ?? false) {
                              ref
                                  .read(fetchMyListProvider.notifier)
                                  .fetchMyListFun();
                            }
                          },
                        ),
                      );
                    },
                    loading: () => HomeShimmerListView(),
                    error: (error, stackTrace) =>
                        Center(child: Text(error.toString())),
                  );
                },
              ),
              /*Divider(
                color: Color(0xFFE5E7E8),
                thickness: 7,
              ),*/

              /// Store List
              Consumer(
                builder: (context, ref, child) {
                  final storeProvider =
                      ref.watch(fetchFavouriteStoreRepositoryProvider);
                  return storeProvider.when(
                    () => Container(),
                    loading: () => HomeShimmerListView(),
                    error: (message) => Center(child: Text(message)),
                    success: (data) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: MyStores(
                          data: data,
                          title: AppLocalizations.of(context)!.myStoreTitle,
                          poppinsFont: poppinsFont,
                          onAllStoreClicked: () async {
                            final bool? result = await context
                                .pushNamed(RouteManager.storesScreen);
                            if (result ?? false) {
                              ref
                                  .read(fetchFavouriteStoreRepositoryProvider
                                      .notifier)
                                  .fetchFavStores();
                            }
                          },
                        ),
                      );
                    },
                    empty: (message) =>
                        Text(AppLocalizations.of(context)!.noStoresAvailable),
                    redirectUser: () {
                      return Container();
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

}
