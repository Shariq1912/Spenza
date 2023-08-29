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

import '../home/provider/home_preloaded_list.dart';

class PreLoadedListDetailsScreen extends ConsumerStatefulWidget {
  const PreLoadedListDetailsScreen({super.key, required this.listId, required  this.name, required this.photo});

  final String listId;
  final String name;
  final String photo;

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
        trailing: const Icon(Icons.copy),
        title: Text(PopupMenuAction.copy.value),
      ),
      value: PopupMenuAction.copy,
    ),
    PopupMenuItem(
      child: ListTile(
        trailing: const Icon(Icons.upload),
        title: Text(PopupMenuAction.upload.value),
      ),
      value: PopupMenuAction.upload,
    ),
    PopupMenuItem(
      child: ListTile(
        trailing: const Icon(Icons.receipt),
        title: Text(PopupMenuAction.receipt.value),
      ),
      value: PopupMenuAction.receipt,
    ),
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(userProductListProvider.notifier).fetchProductFromListId(
            isPreloadedList: true,
          );

      await ref.read(listDetailsProvider.notifier).getSelectedListDetails(
            isPreloadedList: true,
          );
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
          debugPrint("hasvalue $hasValueChanged");
          return false;
        },
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Consumer(
              builder: (context, ref, child) {
                return ref.watch(listDetailsProvider).maybeWhen(
                      data: (data) => CustomAppBar(
                        displayActionIcon: true,
                        title: widget.name,
                        logo: widget.photo ?? "",
                        textStyle: TextStyle(
                          fontFamily: poppinsFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: ColorUtils.colorPrimary,
                        ),
                        onBackIconPressed: () {
                          ///context.pushNamed(RouteManager.addProductScreen);
                          context.pop(hasValueChanged);
                        },
                        onActionIconPressed: () {
                         _onActionIconPressed("preloaded_default/${widget.listId}");
                          // _onActionIconPressed("postloaded_default/${widget.listId}");
                        }
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
                        onActionIconPressed:() {
                          _onActionIconPressed("preloaded_default/${widget.listId}");
                          // _onActionIconPressed("postloaded_default/${widget.listId}");
                        },
                      ),
                    );
              },
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    final result = ref.watch(userProductListProvider);

                    return result.when(
                      loading: () => Center(child: CircularProgressIndicator()),

                      data: (data) {
                        if (data == null) {
                          return Center(
                              child: CircularProgressIndicator()
                          );
                        }else if(data.isEmpty){
                          return Center(
                            child: Text(
                                "No Product found"
                            ),
                          );
                        }
                          return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final UserProduct product = data[index];
                              return PreloadedProductCard(
                                measure: product.measure,
                                listId: widget.listId,
                                department: product.department,
                                imageUrl: product.pImage,
                                title: product.name,
                                priceRange: "\$${product.minPrice} - \$${product.maxPrice}",
                                product: product,
                              );
                            },
                          );
                        },


                      error: (error, stackTrace) =>
                          Center(child: Text("$error")),
                    );
                  },
                ),

              ),
              Consumer(
                builder: (context, ref, child) =>
                    ref.watch(userProductListProvider).maybeWhen(
                      orElse: () => buildMaterialButton(context),
                      data: (data) =>data== null?Container():  data.isEmpty
                          ? Container()
                          : buildMaterialButton(context),
                      loading: () => Container(),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onActionIconPressed(String itemPath) {

    print("clickedItemPath : $itemPath");
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
        if (value == PopupMenuAction.upload) {

          context.pushNamed(RouteManager.uploadReceiptScreen,queryParameters: {'list_id': itemPath});

        } else if (value == PopupMenuAction.receipt) {
          context.pushNamed(RouteManager.displayReceiptScreen,queryParameters: {'list_ref': itemPath});
        } else if (value == PopupMenuAction.copy) {
          debugPrint("copy action");
          final bool result = await ref
              .read(homePreloadedListProvider.notifier)
              .copyDocument(itemPath);

          if (result) {
            hasValueChanged = true;
            context.showSnackBar(message: "List copied successfully!");
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
