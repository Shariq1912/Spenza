import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spenza/di/app_providers.dart';
import 'package:spenza/ui/matching_store/components/matching_store_card.dart';
import 'package:spenza/ui/matching_store/provider/store_ranking_provider.dart';
import 'package:spenza/ui/my_list_details/components/custom_app_bar.dart';
import 'package:spenza/ui/my_list_details/data/matching_store.dart';
import 'package:spenza/utils/color_utils.dart';
import 'package:spenza/utils/spenza_extensions.dart';

import '../profile/profile_repository.dart';

class MatchingStoreScreen extends ConsumerStatefulWidget {
  const MatchingStoreScreen({super.key});

  @override
  ConsumerState createState() => _MatchingStoreScreenState();
}

class _MatchingStoreScreenState extends ConsumerState<MatchingStoreScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileRepositoryProvider.notifier).getUserProfileData();
      ref.read(storeRankingProvider.notifier).rankStoresByPriceTotal();
    });
  }

  @override
  Widget build(BuildContext context) {
    final poppinsFont = ref.watch(poppinsFontProvider).fontFamily;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar:
        AppBar(
          surfaceTintColor: Colors.white,
          title: Text(
            "Matching Stores",
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
                  child: Consumer(
                    builder: (context, ref, child) {
                      final profilePro = ref.watch(profileRepositoryProvider);
                      return profilePro.when(
                            () => Container(),
                        loading: () => Center(child: CircularProgressIndicator()),
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
        body: Consumer(builder: (context, ref, child) {
          final result = ref.watch(storeRankingProvider);

          return result.when(
            data: (data) {
              if (data == null) {
                return Center(child: CircularProgressIndicator());
              }
              if (data.isEmpty) {
                return Center(
                  child: Text("No stores found!"),
                );
              }

              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final MatchingStores store = data[index];
                  return MatchingStoreCard(
                    matchingPercentage: store.matchingPercentage,
                    address: store.address,
                    imageUrl: store.logo,
                    title: store.name,
                    totalPrice: store.totalPrice.toString(),
                    distance: store.distance,
                    onClick: () {
                      ref
                          .read(storeRankingProvider.notifier)
                          .redirectUserToStoreDetails(
                            storeRef: store.storeRef!,
                            context: context,
                            total: store.totalPrice,
                          );
                    },
                  );
                },
              );
            },
            error: (error, stackTrace) => Center(child: Text("$error")),
            loading: () => Center(child: CircularProgressIndicator()),
          );
        }),
      ),
    );
  }
}

/*ListView(
          children: [
            MatchingStoreCard(
              address: "A brand new address!",
              imageUrl: 'https://picsum.photos/250?image=9',
              title: 'Cool Store',
              totalPrice: '720',
              distance: '620m',
              onClick: () {
                print('Card clicked!');
              },
            )
          ]*/
