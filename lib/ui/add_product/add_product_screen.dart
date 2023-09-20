import 'dart:async';

import "package:collection/collection.dart";
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/ui/add_product/components/product_card_widget.dart';
import 'package:spenza/ui/add_product/components/selectable_chip.dart';
import 'package:spenza/ui/add_product/data/product.dart';
import 'package:spenza/ui/add_product/provider/add_product_provider.dart';
import 'package:spenza/ui/common/spenza_circular_progress.dart';
import 'package:spenza/ui/my_list_details/components/custom_app_bar.dart';
import 'package:spenza/ui/my_list_details/components/searchbox_widget.dart';
import 'package:spenza/ui/my_store_products/data/list_item.dart';
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
  late CancelToken _cancelToken;
  final poppinsFont = GoogleFonts.poppins().fontFamily;
  late StreamSubscription<bool> keyboardSubscription;
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    debugPrint("Init Called on Add Product Screen");
    debugPrint("Query is ${widget.query}");

    /*WidgetsBinding.instance.addPostFrameCallback((_) async{
      ref.read(addProductProvider.notifier).searchProducts(query: widget.query);
    });*/

    _cancelToken = CancelToken();

    Future.microtask(
      () => ref
          .read(addProductProvider.notifier)
          .searchProductsNew(query: widget.query, cancelToken: _cancelToken),
    );

    final keyboardVisibilityController = KeyboardVisibilityController();

    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      if (!visible) {
        debugPrint('Soft keyboard closed');
        _focusNode.unfocus();
      }
    });
  }

  @override
  void dispose() {
    debugPrint("Dispose Called on Add Product Screen");

    super.dispose();
    ref.invalidate(selectedDepartmentsProvider);
    ref.invalidate(searchQueryProvider);
    ref.invalidate(
        addProductProvider); // todo dispose the background fetching data when screen dispose.
    _searchController.dispose();

    _cancelToken.cancel("Screen Disposed! :) ");

    keyboardSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
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
          title: 'Add Product to List',
          textStyle: TextStyle(
            fontFamily: poppinsFont,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: ColorUtils.colorPrimary,
          ),
          onBackIconPressed: () {
            // context.pop();
            ref
                .read(addProductProvider.notifier)
                .saveUserSelectedProductsToDB();
          },
        ),
        body: Column(
          children: [
            SearchBox(
              colors: Colors.white,
              controller: _searchController,
              hint: "Search Product",
              focusNode: _focusNode,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: SizedBox(
                height: 40,
                child: Consumer(builder: (context, ref, child) {
                  final selectedDepartments =
                      ref.watch(selectedDepartmentsProvider);
                  final result = ref.watch(addProductProvider);

                  final List<Product> data = result.maybeWhen(
                    data: (data) => data == null ? [] : data,
                    orElse: () => [],
                  );
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
                              /*if (department == "All") {
                                // Unselect all other filters
                                updatedDepartments.clear();
                              } else {
                                // Unselect "All" if another filter is selected
                                updatedDepartments.remove("All");
                              }*/

                              updatedDepartments.clear();
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
                    if (data == null) {
                      return Center(child: SpenzaCircularProgress());
                    }
                    if (data.isEmpty) {
                      return Center(
                        child: Text("No Product found"),
                      );
                    }

                    final isAllSelected = selectedDepartments.contains("All");

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

                    if (isAllSelected) {
                      final Map<String, List<Product>> productByDepartment =
                          groupBy(
                        filteredProducts,
                        (product) => product.department,
                      );
                      return buildListViewWithLabel(
                        productByDepartment: productByDepartment,
                        onClick: (product) {
                          /*ref
                            .read(addProductProvider.notifier)
                            .addProductToUserList(
                          context,
                          product: product,
                        );*/
                          ref
                              .read(addProductProvider.notifier)
                              .increaseQuantity(product: product);
                        },
                        quantityChanged: (Product product, bool hasIncreased) {
                          debugPrint("QUANTITY INCREASED == $hasIncreased");

                          if (hasIncreased) {
                            ref
                                .read(addProductProvider.notifier)
                                .increaseQuantity(product: product);
                            return;
                          }
                          ref
                              .read(addProductProvider.notifier)
                              .decreaseQuantity(product: product);
                        },
                      );
                    }

                    return buildListViewWithoutLabel(
                      products: filteredProducts,
                      onClick: (product) {
                        /*ref
                            .read(addProductProvider.notifier)
                            .addProductToUserList(
                          context,
                          product: product,
                        );*/
                        ref
                            .read(addProductProvider.notifier)
                            .increaseQuantity(product: product);
                      },
                      quantityChanged: (Product product, bool hasIncreased) {
                        print("QUANTITY INCREASED == $hasIncreased");
                        if (hasIncreased) {
                          ref
                              .read(addProductProvider.notifier)
                              .increaseQuantity(product: product);
                          return;
                        }
                        ref
                            .read(addProductProvider.notifier)
                            .decreaseQuantity(product: product);
                      },
                    );
                  },
                  error: (error, stackTrace) => Center(child: Text("$error")),
                  loading: () => Center(child: SpenzaCircularProgress()),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListViewWithLabel({
    required Map<String, List<Product>> productByDepartment,
    required Function(Product product) onClick,
    required Function(Product product, bool hasIncreased) quantityChanged,
  }) {
    final List<String> departments = productByDepartment.keys.toList();
    List<ListItem> listItems = [];

    // Create a list of items with department labels and products
    for (String department in departments) {
      listItems.add(ListItem(department: department));
      final List<Product> departmentProducts =
          productByDepartment[department] ?? [];
      listItems.addAll(
          departmentProducts.map((product) => ListItem(product: product)));
    }

    return ListView.builder(
      itemCount: listItems.length,
      itemBuilder: (context, index) {
        final ListItem item = listItems[index];

        if (item.department != null) {
          // Render department label
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0)
                .copyWith(top: 10, bottom: 10),
            child: Text(
              item.department!,
              style: TextStyle(
                color: ColorUtils.colorPrimary,
                fontFamily: poppinsFont,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        } else if (item.product != null && item.product is Product) {
          // Render product card
          final Product product = item.product!;
          return ProductCard(
            onClick: () => onClick.call(product),
            quantityChanged: (hasIncreased) => quantityChanged.call(
              product,
              hasIncreased,
            ),
            quantity: product.quantity,
            measure: product.measure,
            imageUrl: product.pImage,
            title: product.name,
            priceRange:
                "\$${double.parse(product.minPrice).toStringAsFixed(2)} - \$${double.parse(product.maxPrice).toStringAsFixed(2)}",
          );
        } else {
          // Handle other cases if needed
          return SizedBox();
        }
      },
    );
  }

  Widget buildListViewWithoutLabel({
    required List<Product> products,
    required Function(Product product) onClick,
    required Function(Product product, bool hasIncreased) quantityChanged,
  }) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final Product product = products[index];
        return ProductCard(
          onClick: () => onClick.call(product),
          quantityChanged: (hasIncreased) => quantityChanged.call(
            product,
            hasIncreased,
          ),
          measure: product.measure,
          imageUrl: product.pImage,
          quantity: product.quantity,
          title: product.name,
          priceRange:
              "\$${double.parse(product.minPrice).toStringAsFixed(2)} - \$${double.parse(product.maxPrice).toStringAsFixed(2)}",
        );
      },
    );
  }
}
