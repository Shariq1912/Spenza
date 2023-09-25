import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spenza/di/app_providers.dart';
import 'package:spenza/ui/common/home_top_app_bar.dart';
import 'package:spenza/ui/common/spenza_circular_progress.dart';
import 'package:spenza/ui/matching_store/components/matching_store_app_bar.dart';
import 'package:spenza/ui/matching_store/components/matching_store_card.dart';
import 'package:spenza/ui/matching_store/provider/store_ranking_provider.dart';
import 'package:spenza/ui/my_list_details/data/matching_store.dart';
import 'package:spenza/utils/color_utils.dart';

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
      Future.wait([
        ref.read(profileRepositoryProvider.notifier).getUserProfileData(),
        ref.read(storeRankingProvider.notifier).rankStoresByPriceTotal()
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    final poppinsFont = ref.watch(poppinsFontProvider);

    return Scaffold(
      appBar: MatchingTopAppBar(
        title: "Choose your best option!",
        poppinsFont: poppinsFont,
        isUserIconVisible: false,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final result = ref.watch(storeRankingProvider);

          return result.when(
            data: (data) {
              if (data == null) {
                return Center(child: SpenzaCircularProgress());
              }
              if (data.isEmpty) {
                return Center(
                  child: Text("No stores found!"),
                );
              }

              return ListView.separated(
                itemCount: data.length,
                separatorBuilder: (BuildContext context, int index) => Divider(
                  color: ColorUtils.colorSurface,
                  thickness: 1.0,
                  height: 1, // Set the height to 0 to avoid extra space.
                ),
                itemBuilder: (context, index) {
                  final MatchingStores store = data[index];
                  return MatchingStoreCard(
                    isFavouriteStore : store.isFavourite,
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
            loading: () => Center(child: SpenzaCircularProgress()),
          );
        },
      ),
    );
  }
}

