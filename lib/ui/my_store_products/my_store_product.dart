import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import "package:collection/collection.dart";
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/ui/add_product/components/product_card_widget.dart';
import 'package:spenza/ui/add_product/components/selectable_chip.dart';
import 'package:spenza/ui/add_product/provider/selected_department_provider.dart';
import 'package:spenza/ui/common/spenza_circular_progress.dart';
import 'package:spenza/ui/home/components/custom_dialog.dart';
import 'package:spenza/ui/my_list_details/components/custom_app_bar.dart';
import 'package:spenza/ui/my_list_details/components/searchbox_widget.dart';
import 'package:spenza/ui/my_list_details/provider/user_product_list_provider.dart';
import 'package:spenza/ui/my_store_products/data/products.dart';
import 'package:spenza/ui/my_store_products/provider/product_for_store_provider.dart';
import 'package:spenza/ui/my_store_products/repo/department_repository.dart';
import 'package:spenza/ui/selected_store/provider/store_details_provider.dart';
import 'package:spenza/utils/color_utils.dart';
import 'package:spenza/utils/fireStore_constants.dart';
import 'package:spenza/utils/spenza_extensions.dart';

import '../../router/app_router.dart';
import '../profile/profile_repository.dart';
import 'component/dialog_list.dart';
import 'component/my_product_list_widget.dart';
import 'data/list_item.dart';
import 'provider/add_product_to_my_list_provider.dart';

class MyStoreProduct extends ConsumerStatefulWidget {
  final String storeId;
  final String logo;
  final String? listId;

  const MyStoreProduct({
    Key? key,
    required this.storeId,
    required this.logo,
    this.listId,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyStoreProductState();
}

class _MyStoreProductState extends ConsumerState<MyStoreProduct> {
  final poppinsFont = GoogleFonts.poppins().fontFamily;
  bool hasValueChanged = false;
  final TextEditingController _searchController = TextEditingController();
  final _focusNode = FocusNode();
  KeyboardVisibilityController _keyboardVisibilityController =
      KeyboardVisibilityController();

  late StreamSubscription<bool> keyboardSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProducts();
    });

    final keyboardVisibilityController = KeyboardVisibilityController();

    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      if (!visible) {
        debugPrint('Soft keyboard closed');
        _focusNode.unfocus();
      }
    });
  }

  _loadProducts() async {
    Future.wait([
      ref
          .read(productForStoreProvider.notifier)
          .getProductsForStore(widget.storeId),
      ref
          .read(storeDetailsProvider.notifier)
          .getSelectedStoreFromStoreId(storeId: widget.storeId),
    ]);
  }

  @override
  void dispose() {
    super.dispose();

    ref.invalidate(productForStoreProvider);
    ref.invalidate(storeDetailsProvider);
    _searchController.dispose();
    _focusNode.dispose();
    keyboardSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    _searchController.addListener(() {
      ref.read(searchQueryProvider.notifier).state =
          _searchController.text.trim().toLowerCase();
    });

    return WillPopScope(
      onWillPop: () async {
        if (hasValueChanged) {
          print("WIll POP Scope === $hasValueChanged");
          Future.microtask(
            () => ref
                .read(userProductListProvider.notifier)
                .fetchProductFromListId(),
          );
        }
        return true;
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
              colors: Color(0xFFE5E7E8),
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
                  final result = ref.watch(productForStoreProvider);

                  final List<ProductModel> data = result.maybeWhen(
                    data: (data) => data == null ? [] : data,
                    orElse: () => [],
                  );
                  final departments = [
                    "All",
                    ...data.map((e) => e.departmentName).toSet().toList()
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
              child: Container(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: Consumer(builder: (context, ref, child) {
                  final data = ref.watch(productForStoreProvider);
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
                        return selectedDepartments
                            .contains(product.departmentName);
                      }).toList();

                      if (isAllSelected) {
                        final Map<String, List<ProductModel>>
                            productByDepartment = groupBy(
                          filteredProducts,
                          (product) => product.departmentName,
                        );
                        return buildListViewWithLabel(
                          productByDepartment,
                          (product) async {
                            await handleAddProduct(product, context);
                          },
                        );
                      } else {
                        return buildListViewWithoutLabel(
                          filteredProducts,
                          (product) async {
                            await handleAddProduct(product, context);
                          },
                        );
                      }
                    },
                    error: (error, stackTrace) => Center(child: Text("$error")),
                    loading: () => Center(child: SpenzaCircularProgress()),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> handleAddProduct(
    ProductModel product,
    BuildContext context,
  ) async {
    if (widget.listId != null) {
      final bool hasReload = await ref
          .read(addProductToMyListProvider.notifier)
          .addProductToMyList(
            listId: widget.listId!,
            productRef: product.documentId!,
            productId: product.productId,
            context: context,
          );

      print("has Reload == $hasReload");
      if (hasReload) {
        /*  ref
            .read(userProductListProvider.notifier)
            .fetchProductFromListId();*/

        print("Inside has Reload");
        hasValueChanged = true;
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            productRef: product.documentId!,
            productId: product.productId,
          );
        },
      );
    }
  }

  Widget buildListViewWithLabel(
    Map<String, List<ProductModel>> productByDepartment,
    Function(ProductModel product) onClick,
  ) {
    final List<String> departments = productByDepartment.keys.toList();
    List<ListItem> listItems = [];

    // Create a list of items with department labels and products
    for (String department in departments) {
      listItems.add(ListItem(department: department));
      final List<ProductModel> departmentProducts =
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
        } else if (item.product != null) {
          // Render product card
          final ProductModel product = item.product!;
          return ProductCard(
            onClick: () => onClick.call(product),
            measure: product.measure,
            imageUrl: product.pImage,
            title: product.name,
            priceRange: "",
            isPriceRangeVisible: false,
          );
        } else {
          // Handle other cases if needed
          return SizedBox();
        }
      },
    );
  }

  Widget buildListViewWithoutLabel(
    List<ProductModel> products,
    Function(ProductModel product) onClick,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final ProductModel product = products[index];
          return ProductCard(
            onClick: () => onClick.call(product),
            measure: product.measure,
            imageUrl: product.pImage,
            title: product.name,
            priceRange: "",
            isPriceRangeVisible: false,
          );
        },
        /*separatorBuilder: (BuildContext context, int index) => Divider(
          color: ColorUtils.colorSurface,
          thickness: 1.0,
          height: 0, // Set the height to 0 to avoid extra space.
        ),*/
      ),
    );
  }
}

/* body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Consumer(
          builder: (context, ref, child) {
            final productProvider = ref.watch(productForStoreProvider);
            final departmentProvider = ref.watch(departmentRepositoryProvider);
            return productProvider.when(
              loading: () => Center(child: SpenzaCircularProgress()),
              error: (error, stackTrace) {
                print("errorMrsss $error");
                return Center(child: Text(error.toString()));
              },
              data: (data) {
                */ /*print("productData $data");
              return MyProductListWidget(stores: data, onButtonClicked: (Product product) {});
                return departmentProvider.when(
                  () => Container(),
                  loading: () => Center(child: SpenzaCircularProgress()),
                  error: (message) {
                    print("errorMrss $message");
                    return Center(child: Text(message));
                  },
                  success: (departments) {
                    return MyProductListWidget(
                      stores: data,
                      department: departments,
                      onButtonClicked: (ProductModel product) async {
                        if (widget.listId != null) {
                          final bool hasReload = await ref
                              .read(addProductToMyListProvider.notifier)
                              .addProductToMyList(
                                listId: widget.listId!,
                                productRef: product.documentId!,
                                productId: product.productId,
                                context: context,
                              );

                          if (hasReload) {
                            ref
                                .read(userProductListProvider.notifier)
                                .fetchProductFromListId();

                            hasValueChanged = true;
                          }

                          return;
                        }

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return MyListDialog(
                              productRef: product.documentId!,
                              productId: product.productId,
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),*/
