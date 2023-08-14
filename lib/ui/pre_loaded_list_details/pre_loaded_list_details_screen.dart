import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spenza/di/app_providers.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/add_product/data/user_product.dart';
import 'package:spenza/ui/my_list_details/components/custom_app_bar.dart';
import 'package:spenza/ui/my_list_details/components/searchbox_widget.dart';
import 'package:spenza/ui/my_list_details/components/user_selected_product_widget.dart';
import 'package:spenza/ui/my_list_details/provider/user_product_list_provider.dart';
import 'package:spenza/ui/pre_loaded_list_details/components/pre_loaded_product_widget.dart';
import 'package:spenza/utils/color_utils.dart';

class PreLoadedListDetailsScreen extends ConsumerStatefulWidget {
  const PreLoadedListDetailsScreen({super.key, required this.listId});

  final String listId;

  @override
  ConsumerState createState() => _PreLoadedListDetailsScreenState();
}

class _PreLoadedListDetailsScreenState
    extends ConsumerState<PreLoadedListDetailsScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userProductListProvider.notifier).fetchProductFromListId(widget.listId);
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
          title: 'Preloaded List',
          textStyle: TextStyle(
            fontFamily: poppinsFont,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: ColorUtils.colorPrimary,
          ),
          onBackIconPressed: () async {
            final bool? result =
                await context.pushNamed(RouteManager.addProductScreen);
            if (result ?? false) {
              debugPrint("Return from Add Product with $result");
              ref
                  .read(userProductListProvider.notifier)
                  .fetchProductFromListId(widget.listId);
            }
          },
        ),
        body: Column(
          children: [
            SearchBox(
              hint: "Add products",
              controller: _searchController,
              onSearch: (value) {
                context.pushNamed(
                  RouteManager.addProductScreen,
                  queryParameters: {'query': value},
                );
                _searchController.clear();
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              // Use a single Expanded widget to wrap the ListView
              child: Consumer(
                builder: (context, ref, child) => ref
                    .watch(userProductListProvider)
                    .when(
                      data: (data) => ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final UserProduct product = data[index];
                          return PreloadedProductCard(
                            measure: product.measure,
                            listId: widget.listId,
                            department: product.department,
                            imageUrl: product.pImage,
                            title: product.name,
                            priceRange:
                                "\$${product.minPrice} - \$${product.maxPrice}",
                            product: product,
                          );
                        },
                      ),
                      error: (error, stackTrace) =>
                          Center(child: Text("$error")),
                      loading: () => Center(child: CircularProgressIndicator()),
                    ),
              ),
            ),


            Consumer(
              builder: (context, ref, child) =>
                  ref.watch(userProductListProvider).maybeWhen(
                    orElse: () => buildMaterialButton(context),
                    loading: () =>Container(),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  MaterialButton buildMaterialButton(BuildContext context) {
    return MaterialButton(
            onPressed: () {
              ref
                  .read(userProductListProvider.notifier)
                  .redirectFromPreloadedList(context: context);
            },
            color: Colors.blue,
            // Change the button color to your desired color
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_forward,
                  color: Colors
                      .white, // Change the icon color to your desired color
                ),
                SizedBox(width: 8),
                Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    // Change the text color to your desired color
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
  }
}
