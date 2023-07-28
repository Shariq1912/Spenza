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
import 'package:spenza/utils/color_utils.dart';

class MyListDetailsScreen extends ConsumerStatefulWidget {
  const MyListDetailsScreen({super.key});

  final String listId = "4NlYnhmchdlu528Gw2yK";

  @override
  ConsumerState createState() => _MyListDetailsScreenState();
}

class _MyListDetailsScreenState extends ConsumerState<MyListDetailsScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => ref.read(userProductListProvider.notifier).fetchProductFromListId(),
    );
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
          title: 'Cool List',
          textStyle: TextStyle(
            fontFamily: poppinsFont,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: ColorUtils.colorPrimary,
          ),
          onBackIconPressed: () {
            context.pushNamed(RouteManager.addProductScreen);
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
                          return UserSelectedProductCard(
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
            MaterialButton(
              onPressed: () {
                ref
                    .read(userProductListProvider.notifier)
                    .saveUserProductListToServer(context: context);
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
            ),
          ],
        ),
      ),
    );
  }
}
