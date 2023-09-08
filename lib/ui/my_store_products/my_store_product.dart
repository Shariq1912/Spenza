import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/ui/add_product/components/product_card_widget.dart';
import 'package:spenza/ui/add_product/components/selectable_chip.dart';
import 'package:spenza/ui/add_product/provider/selected_department_provider.dart';
import 'package:spenza/ui/common/spenza_circular_progress.dart';
import 'package:spenza/ui/my_list_details/components/searchbox_widget.dart';
import 'package:spenza/ui/my_list_details/provider/user_product_list_provider.dart';
import 'package:spenza/ui/my_store_products/data/products.dart';
import 'package:spenza/ui/my_store_products/provider/product_for_store_provider.dart';
import 'package:spenza/ui/my_store_products/repo/department_repository.dart';
import 'package:spenza/utils/color_utils.dart';

import '../../router/app_router.dart';
import '../profile/profile_repository.dart';
import 'component/dialog_list.dart';
import 'component/my_product_list_widget.dart';
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

class _MyStoreProductState extends ConsumerState<MyStoreProduct>
    with WidgetsBindingObserver {
  final poppinsFont = GoogleFonts.poppins().fontFamily;
  bool hasValueChanged = false;
  final TextEditingController _searchController = TextEditingController();
  final _focusNode = FocusNode();
  KeyboardVisibilityController _keyboardVisibilityController = KeyboardVisibilityController();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProducts();
    });

    WidgetsBinding.instance.addObserver(this);
  }

  _loadProducts() async {
    await ref
        .read(productForStoreProvider.notifier)
        .getProductsForStore(widget.storeId);
    // await ref.read(departmentRepositoryProvider.notifier).getDepartments();
  }

  @override
  void dispose() {
    super.dispose();

    ref.invalidate(productForStoreProvider);
    _searchController.dispose();
    _focusNode.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    // todo change with package since deprecated.
   /* final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    if (bottomInset == 0) {
      // Soft keyboard closed
      debugPrint('Soft keyboard closed');
      _focusNode.unfocus();
    }*/
    _keyboardVisibilityController.onChange.listen((bool visible) {
      if (!visible) {
        debugPrint('Soft keyboard closed');
        _focusNode.unfocus();
      }
    });
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
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          title: Text(
            "Stores", // todo change it to localized string
            style: TextStyle(
              fontFamily: poppinsFont,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: ColorUtils.colorPrimary,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(Icons.arrow_back_ios, color: ColorUtils.colorPrimary),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                top: 5,
              ),
              child: InkWell(
                onTap: () {
                  //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SettingScreen()));
                },
                child: CircleAvatar(
                  radius: 40,
                  child: ClipOval(
                    child: CachedNetworkImage(imageUrl: widget.logo),
                  ),
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            SearchBox(
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

                    return ListView.builder(
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final ProductModel product = filteredProducts[index];
                        return ProductCard(
                          onClick: () async {
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
                          measure: product.measure,
                          imageUrl: product.pImage,
                          title: product.name,
                          priceRange: "",
                          isPriceRangeVisible: false,
                        );
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
