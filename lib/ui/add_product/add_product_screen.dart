import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spenza/di/app_providers.dart';
import 'package:spenza/ui/add_product/components/product_card_widget.dart';
import 'package:spenza/ui/add_product/components/product_card_widget.dart';
import 'package:spenza/ui/add_product/components/selectable_chip.dart';
import 'package:spenza/ui/add_product/components/selectable_chip.dart';
import 'package:spenza/ui/add_product/components/selectable_chip.dart';
import 'package:spenza/ui/add_product/data/product.dart';
import 'package:spenza/ui/add_product/provider/add_product_provider.dart';
import 'package:spenza/ui/my_list_details/components/custom_app_bar.dart';
import 'package:spenza/ui/my_list_details/components/searchbox_widget.dart';
import 'package:spenza/utils/color_utils.dart';

class AddProductScreen extends ConsumerStatefulWidget {
  const AddProductScreen({super.key, required this.query});

  final String query;

  @override
  ConsumerState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddProductScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print("Query is ${widget.query}");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(addProductProvider.notifier).searchProducts(query: widget.query);
    });

    /*Future.microtask(
      () => ref.read(addProductProvider.notifier).findNearbyLocations(),
    );*/
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
          displayActionIcon: false,
          title: 'Add Product',
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
        body: Column(
          children: [
            SearchBox(controller: _searchController, hint: "Search Product"),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: SizedBox(
                height: 40,
                child: Consumer(
                  builder: (context, ref, child) => ref
                      .watch(addProductProvider)
                      .when(
                        data: (data) {
                          final List<String> departments = [
                            "All",
                            ...data
                                .expand((e) => e.departments)
                                .toSet()
                                .toList()
                          ];

                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: departments.length,
                            itemBuilder: (context, index) {
                              return SelectableChip(label: departments[index]);
                            },
                          );
                        },
                        error: (error, stackTrace) => Container(),
                        loading: () => Container(),
                      ),
                ),
              ),
            ),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) => ref
                    .watch(addProductProvider)
                    .when(
                      data: (data) => ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final Product product = data[index];
                          return ProductCard(
                            onClick: () => ref
                                .read(addProductProvider.notifier)
                                .addProductToUserList(
                                  context,
                                  product: product,
                                ),
                            measure: product.measure,
                            imageUrl: product.pImage ??
                                'https://picsum.photos/250?image=9',
                            title: product.name,
                            priceRange:
                                "\$${product.minPrice} - \$${product.maxPrice}",
                          );
                        },
                      ),
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
}
