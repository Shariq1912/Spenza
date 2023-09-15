import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:spenza/utils/color_utils.dart';
import 'package:spenza/utils/spenza_extensions.dart';

import '../profile/profile_repository.dart';
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
    print("Init called From Home");
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
    super.dispose();
    print("Dispose called From Home");

    ref.invalidate(fetchMyListProvider);
    ref.invalidate(fetchFavouriteStoreRepositoryProvider);
    ref.invalidate(homePreloadedListProvider);
  }

  @override
  Widget build(BuildContext context) {
    print("pppp $postalCode");
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
                                          path: path!);
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
                        padding: EdgeInsets.only(left: 10, right: 10, top: 5),
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
                        padding: EdgeInsets.only(left: 10, right: 10),
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

  AppBar topAppBar() {
    String? zipcode;

    return AppBar(
      toolbarHeight: 90,
      elevation: 5.0,
      surfaceTintColor: Colors.white,
      backgroundColor: ColorUtils.colorPrimary,
      automaticallyImplyLeading: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: ColorUtils.colorPrimary,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            top: 5,
          ),
          child: InkWell(onTap: () {
            context.pushNamed(RouteManager.settingScreen);
          }, child: Consumer(
            builder: (context, ref, child) {
              final profilePro = ref.watch(profileRepositoryProvider);
              return profilePro.when(
                () => Container(),
                loading: () => Center(child: CircularProgressIndicator()),
                error: (message) => CircleAvatar(
                  child: Image.asset('assets/images/user.png'),
                ),
                success: (data) {
                  zipcode = data.zipCode;
                  print("zzz $zipcode");
                  if (data.profilePhoto != null &&
                      data.profilePhoto!.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 10, bottom: 18, top: 18, right: 10),
                      child: ClipOval(
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: data.profilePhoto!,
                            placeholder: (context, url) => Image.asset(
                                'app_icon_spenza.png'.assetImageUrl),
                            errorWidget: (context, url, error) => Image.asset(
                                'user_placeholder.png'.assetImageUrl),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 10, bottom: 18, top: 18, right: 10),
                      child: ClipOval(
                          child: AspectRatio(
                        aspectRatio: 1.0,
                        child: Image.asset(
                          'user_placeholder.png'.assetImageUrl,
                          fit: BoxFit.cover,
                        ),
                      )),
                    );
                  }
                },
              );
            },
          )

              //),
              ),
        )
      ],
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            maxLines: 2,
            //AppLocalizations.of(context)!.,
            "Start saving time and money!",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: poppinsFont.fontFamily,
              decoration: TextDecoration.none,
              color: ColorUtils.colorWhite,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Consumer(
            builder: (context, ref, child) {
              final profilePro = ref.watch(profileRepositoryProvider);
              return profilePro.when(
                () => Container(),
                loading: () => Container(),
                error: (error) => Container(),
                success: (data) {
                  return _buildNearbyText(data.zipCode, 12);
                },
              );
            },
          ),
        ],
      ),
      centerTitle: false,
    );
  }

  Text _buildNearbyText(String zipCode, double fontSize) {
    return Text.rich(
      TextSpan(
        text: "Nearby",
        style: TextStyle(
          fontFamily: poppinsFont.fontFamily,
          decoration: TextDecoration.none,
          color: ColorUtils.colorWhite,
          fontWeight: FontWeight.normal,
          fontSize: fontSize,
        ),
        children: [
          TextSpan(
            text: " $zipCode",
            style: TextStyle(
              fontFamily: poppinsFont.fontFamily,
              decoration: TextDecoration.none,
              color: ColorUtils.colorWhite,
              fontWeight: FontWeight.w700,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
