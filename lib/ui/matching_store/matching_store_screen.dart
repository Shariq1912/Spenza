import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spenza/di/app_providers.dart';
import 'package:spenza/ui/matching_store/components/matching_store_card.dart';
import 'package:spenza/ui/matching_store/provider/store_ranking_provider.dart';
import 'package:spenza/ui/my_list_details/components/custom_app_bar.dart';
import 'package:spenza/ui/my_list_details/data/matching_store.dart';
import 'package:spenza/utils/color_utils.dart';

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
        appBar: CustomAppBar(
          displayActionIcon: true,
          title: 'Matching Stores',
          textStyle: TextStyle(
            fontFamily: poppinsFont,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: ColorUtils.colorPrimary,
          ),
          onBackIconPressed: () {
            context.pop();
          },
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
