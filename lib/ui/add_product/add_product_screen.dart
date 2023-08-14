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

import 'provider/selected_department_provider.dart';

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
  void dispose() {
    super.dispose();
    ref.invalidate(selectedDepartmentsProvider);
    ref.invalidate(searchQueryProvider);
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final poppinsFont = ref.watch(poppinsFontProvider).fontFamily;

    _searchController.addListener(() {
      ref.read(searchQueryProvider.notifier).state =
          _searchController.text.trim().toLowerCase();
    });

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
                child: Consumer(builder: (context, ref, child) {
                  final selectedDepartments =
                      ref.watch(selectedDepartmentsProvider);
                  final List<Product> data =
                      ref.watch(addProductProvider).requireValue;

                  final departments = [
                    "All",
                    ...data.expand((e) => e.departments).toSet().toList()
                  ];

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: departments.length,
                    itemBuilder: (context, index) {
                      final department = departments[index];
                      final isSelected =
                          selectedDepartments.contains(department);

                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SelectableChip(
                          label: departments[index],
                          isSelected: isSelected,
                          onSelected: (selected) {
                            final updatedDepartments =
                                Set<String>.from(selectedDepartments);

                            if (selected) {
                              if (department == "All") {
                                // Unselect all other filters
                                updatedDepartments.clear();
                              } else {
                                // Unselect "All" if another filter is selected
                                updatedDepartments.remove("All");
                              }
                              updatedDepartments.add(department);
                            } else {
                              updatedDepartments.remove(department);
                              if (updatedDepartments.isEmpty)
                                updatedDepartments.add("All");
                            }

                            ref
                                .read(selectedDepartmentsProvider.notifier)
                                .state = updatedDepartments;
                          },
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
            Expanded(
              child: Consumer(builder: (context, ref, child) {
                final data = ref.watch(addProductProvider);
                final selectedDepartments =
                    ref.watch(selectedDepartmentsProvider);
                final searchQuery = ref.watch(searchQueryProvider);

                return data.when(
                  data: (data) {
                    final filteredProducts = data.where((product) {
                      if (searchQuery.isNotEmpty &&
                          !product.name.toLowerCase().contains(searchQuery)) {
                        return false; // Skip products that don't match the search query
                      }

                      if (selectedDepartments.contains("All")) {
                        return true;
                      }
                      return product.departments.any((department) =>
                          selectedDepartments.contains(department));
                    }).toList();

                    return ListView.builder(
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final Product product = filteredProducts[index];
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
                    );
                  },
                  error: (error, stackTrace) => Center(child: Text("$error")),
                  loading: () => Center(child: CircularProgressIndicator()),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
