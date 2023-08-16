import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spenza/di/app_providers.dart';
import 'package:spenza/helpers/popup_menu_mixin.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/add_product/data/user_product.dart';
import 'package:spenza/ui/my_list_details/components/custom_app_bar.dart';
import 'package:spenza/ui/my_list_details/components/searchbox_widget.dart';
import 'package:spenza/ui/my_list_details/components/user_selected_product_widget.dart';
import 'package:spenza/ui/my_list_details/provider/list_details_provider.dart';
import 'package:spenza/ui/my_list_details/provider/user_product_list_provider.dart';
import 'package:spenza/ui/pre_loaded_list_details/components/pre_loaded_product_widget.dart';
import 'package:spenza/utils/color_utils.dart';
import 'package:spenza/utils/spenza_extensions.dart';

class PreLoadedListDetailsScreen extends ConsumerStatefulWidget {
  const PreLoadedListDetailsScreen({super.key, required this.listId});

  final String listId;

  @override
  ConsumerState createState() => _PreLoadedListDetailsScreenState();
}

class _PreLoadedListDetailsScreenState
    extends ConsumerState<PreLoadedListDetailsScreen> with PopupMenuMixin {
  final TextEditingController _searchController = TextEditingController();
  bool hasValueChanged = false;

  final List<PopupMenuItem<PopupMenuAction>> items = [
    PopupMenuItem(
      child: ListTile(
        trailing: const Icon(Icons.edit),
        title: Text(PopupMenuAction.edit.value),
      ),
      value: PopupMenuAction.edit,
    ),
    PopupMenuItem(
      child: ListTile(
        trailing: const Icon(Icons.copy),
        title: Text(PopupMenuAction.copy.value),
      ),
      value: PopupMenuAction.copy,
    ),
    PopupMenuItem(
      child: ListTile(
        trailing: const Icon(Icons.delete),
        title: Text(PopupMenuAction.delete.value),
      ),
      value: PopupMenuAction.delete,
    ),
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userProductListProvider.notifier).fetchProductFromListId(
            isPreloadedList: true,
          );
      ref.read(listDetailsProvider.notifier).getSelectedListDetails();
    });
  }

  @override
  void dispose() {
    super.dispose();

    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final poppinsFont = ref.watch(poppinsFontProvider).fontFamily;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: () async {
          context.pop(hasValueChanged);
          return true;
        },
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Consumer(
              builder: (context, ref, child) {
                return ref.watch(listDetailsProvider).maybeWhen(
                      data: (data) => CustomAppBar(
                        displayActionIcon: true,
                        title: data.name,
                        logo: data.myListPhoto ?? "",
                        textStyle: TextStyle(
                          fontFamily: poppinsFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: ColorUtils.colorPrimary,
                        ),
                        onBackIconPressed: () {
                          context.pushNamed(RouteManager.addProductScreen);
                        },
                        onActionIconPressed: _onActionIconPressed,
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
                          context.pushNamed(RouteManager.addProductScreen);
                        },
                        onActionIconPressed: _onActionIconPressed,
                      ),
                    );
              },
            ),
          ),
          body: Column(
            children: [
              /*SearchBox(
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
              const SizedBox(height: 10),*/
              Expanded(
                // Use a single Expanded widget to wrap the ListView
                child: Consumer(
                  builder: (context, ref, child) =>
                      ref.watch(userProductListProvider).when(
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
                            loading: () =>
                                Center(child: CircularProgressIndicator()),
                          ),
                ),
              ),
              Consumer(
                builder: (context, ref, child) =>
                    ref.watch(userProductListProvider).maybeWhen(
                          orElse: () => buildMaterialButton(context),
                          loading: () => Container(),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onActionIconPressed() {
    final RenderBox customAppBarRenderBox =
        context.findRenderObject() as RenderBox;
    final customAppBarPosition =
        customAppBarRenderBox.localToGlobal(Offset.zero);

    showPopupMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        customAppBarPosition.dx + customAppBarRenderBox.size.width - 40,
        customAppBarPosition.dy + kToolbarHeight + 30,
        0.0,
        0.0,
      ),
      items: items,
      onSelected: (PopupMenuAction value) async {
        if (value == PopupMenuAction.copy) {
          debugPrint("copy action");
          final bool result = await ref
              .read(userProductListProvider.notifier)
              .copyTheList(context: context);

          if (result) {
            hasValueChanged = true;
            context.showSnackBar(message: "List copied successfully!");
          }
        } else if (value == PopupMenuAction.delete) {
          debugPrint("delete action");
          final bool result = await ref
              .read(userProductListProvider.notifier)
              .deleteTheList(context: context);

          if (result) {
            hasValueChanged = true;
            context.showSnackBar(message: "List deleted successfully!");
          }
        } else if (value == PopupMenuAction.edit) {
          debugPrint("edit action");
          final bool? result =
              await context.pushNamed(RouteManager.editListScreen);
          if (result ?? false) {
            context.showSnackBar(message: "List Edited Successfully!");
            ref.read(listDetailsProvider.notifier).getSelectedListDetails();
            hasValueChanged = true;
          }
        }
      },
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
            color: Colors.white, // Change the icon color to your desired color
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
