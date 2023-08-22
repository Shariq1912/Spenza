import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spenza/di/app_providers.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/favourite_stores/data/favourite_stores.dart';
import 'package:spenza/ui/matching_store/components/matching_store_card.dart';
import 'package:spenza/ui/matching_store/provider/store_ranking_provider.dart';
import 'package:spenza/ui/my_list_details/components/custom_app_bar.dart';
import 'package:spenza/ui/my_list_details/components/searchbox_widget.dart';
import 'package:spenza/ui/my_list_details/data/matching_store.dart';
import 'package:spenza/ui/selected_store/components/selected_store_product_card_widget.dart';
import 'package:spenza/ui/selected_store/data/selected_product_elements.dart';
import 'package:spenza/ui/selected_store/data/selected_product_list.dart';
import 'package:spenza/ui/selected_store/provider/selected_store_provider.dart';
import 'package:spenza/ui/selected_store/provider/store_details_provider.dart';
import 'package:spenza/utils/color_utils.dart';

class SelectedStoreScreen extends ConsumerStatefulWidget {
  const SelectedStoreScreen({super.key});

  @override
  ConsumerState createState() => _SelectedStoreScreenState();
}

class _SelectedStoreScreenState extends ConsumerState<SelectedStoreScreen> {
  final TextEditingController _searchController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(selectedStoreProvider.notifier).getSelectedStoreProducts();
    });

    _focusNode.addListener(() {
      print("Has focus: ${_focusNode.hasFocus}");

      if (_focusNode.hasFocus) {
        final Stores store = ref.read(storeDetailsProvider).requireValue;
        if (store.id.isEmpty) {
          debugPrint("Store ID is Empty");
          return;
        }

        _focusNode.unfocus();

        ref
            .read(selectedStoreProvider.notifier)
            .redirectUserToStoreProductsScreen(
              context: context,
              storeId: store.id,
              storeLogo: store.logo,
            );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final poppinsFont = ref.watch(poppinsFontProvider).fontFamily;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Consumer(
            builder: (context, ref, child) {
              return ref.watch(storeDetailsProvider).maybeWhen(
                    data: (data) => CustomAppBar(
                      displayActionIcon: true,
                      title: data.name,
                      logo: data.logo,
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
                    orElse: () => CustomAppBar(
                      displayActionIcon: true,
                      title: "",
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
                  );
            },
          ),
        ),
        body: Column(
          children: [
            SearchBox(
              focusNode: _focusNode,
              controller: _searchController,
              hint: "Add Product",
            ),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) => ref
                    .watch(selectedStoreProvider)
                    .when(
                      data: (data) {
                        if (data.storeRef != null) {
                          ref
                              .read(storeDetailsProvider.notifier)
                              .getSelectedStore(storeRef: data.storeRef!);
                        }

                        return ListView.builder(
                          itemCount: data.products.length,
                          itemBuilder: (context, index) {
                            final SelectedProductList product =
                                data.products[index];
                            return product.when(
                              label: (label) => index == 0
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0)
                                          .copyWith(top: 16, bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            label,
                                            style: TextStyle(
                                              color: ColorUtils.colorPrimary,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            'Total Price: ${data.total.toStringAsFixed(2)}',
                                            style: TextStyle(
                                              color: ColorUtils.colorPrimary,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0)
                                          .copyWith(top: 16, bottom: 10),
                                      child: Text(
                                        label,
                                        style: TextStyle(
                                          color: ColorUtils.colorPrimary,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                              similarProduct: (product) =>
                                  buildSelectedStoreProductCard(
                                product: product,
                                onClick: () {},
                              ),
                              missingProduct: (product) =>
                                  buildSelectedStoreProductCard(
                                product: product,
                                isMissing: true,
                                onClick: () {},
                              ),
                              exactProduct: (product) =>
                                  buildSelectedStoreProductCard(
                                product: product,
                                onClick: () {},
                              ),
                            );
                          },
                        );
                      },
                      error: (error, stackTrace) =>
                          Center(child: Text("$error")),
                      loading: () => Center(child: CircularProgressIndicator()),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SelectedStoreProductCard buildSelectedStoreProductCard({
    required SelectedProductElement product,
    required VoidCallback onClick,
    bool isMissing = false,
  }) {
    return SelectedStoreProductCard(
      isMissing: isMissing,
      imageUrl: product.productImage,
      price: product.price,
      measure: product.measure,
      quantity: product.quantity,
      title: product.name,
      onClick: () => onClick,
    );
  }
}

/* SelectedStoreProductCard(
              imageUrl: 'https://media.istockphoto.com/id/466175630/photo/tomato-isolated-on-white-background.jpg?s=612x612&w=0&k=20&c=ELzCVzaiRMgiO7A5zQLkuws0N_lvPxrgJWPn7C7BXz0=',
              price: 50,
              measure: "kg",
              quantity: 2,
              title: 'Cool Product',
              onClick: () {
                print('Card clicked!');
              },
            )*/

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