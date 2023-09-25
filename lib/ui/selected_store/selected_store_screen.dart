import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spenza/di/app_providers.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/common/elevated_button_with_centered_text.dart';
import 'package:spenza/ui/common/spenza_circular_progress.dart';
import 'package:spenza/ui/favourite_stores/data/favourite_stores.dart';
import 'package:spenza/ui/my_list_details/components/custom_app_bar.dart';
import 'package:spenza/ui/my_list_details/components/searchbox_widget.dart';
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
        _focusNode.unfocus();

        final Stores store = ref.read(storeDetailsProvider).requireValue;
        if (store.id.isEmpty) {
          debugPrint("Store ID is Empty");
          return;
        }

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
    final size = MediaQuery.of(context).size;
    /*ref.listen(selectedStoreProvider, (previous, next) {
      next.maybeWhen(
        orElse: () {},
        data: (data) => ref
            .read(storeDetailsProvider.notifier)
            .getSelectedStore(storeRef: data!.storeRef!),
      );
    });*/

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
                      title: data.groupName,
                      subtitle: data.name,
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
              colors: Colors.white,
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
                        if (data == null) {
                          return Center(child: SpenzaCircularProgress());
                        }

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
                                          .copyWith(top: 6, bottom: 10),
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
                                            'Total Price : \$ ${data.total.toStringAsFixed(2)}',
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
                                index: index,
                                size: data.products.length,
                                product: product,
                                onClick: () {},
                              ),
                              missingProduct: (product) =>
                                  buildSelectedStoreProductCard(
                                index: index,
                                size: data.products.length,
                                product: product,
                                isMissing: true,
                                onClick: () {},
                              ),
                              exactProduct: (product) =>
                                  buildSelectedStoreProductCard(
                                index: index,
                                size: data.products.length,
                                product: product,
                                onClick: () {},
                              ),
                            );
                          },
                        );
                      },
                      error: (error, stackTrace) =>
                          Center(child: Text("$error")),
                      loading: () => Center(child: SpenzaCircularProgress()),
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16),
              child: ElevatedButtonWithCenteredText(
                size: Size(size.width, 40),
                onClick: () {
                  context.pushNamed(RouteManager.uploadReceiptScreen,
                    queryParameters: {'source': "finished"},);
                },
                text: "I finished Shopping", // todo localize the text
                fontFamily: poppinsFont!,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSelectedStoreProductCard({
    required SelectedProductElement product,
    required int index,
    required int size,
    required VoidCallback onClick,
    bool isMissing = false,
  }) {
    return Column(
      children: [
        SelectedStoreProductCard(
          isMissing: isMissing,
          imageUrl: product.productImage,
          price: product.price,
          measure: product.measure,
          quantity: product.quantity,
          title: product.name,
          onClick: () => onClick,
        ),
        if (index > 0)
          Divider(
            color: ColorUtils.colorSurface, // Specify the divider color.
            thickness: 1.0, // Specify the divider thickness.
            height: 0, // Set the height to 0 to avoid extra space.
          ),
      ],
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
