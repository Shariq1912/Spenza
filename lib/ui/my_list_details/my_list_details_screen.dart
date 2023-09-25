
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/di/app_providers.dart';
import 'package:spenza/helpers/popup_menu_mixin.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/add_product/data/user_product.dart';
import 'package:spenza/ui/common/spenza_circular_progress.dart';
import 'package:spenza/ui/my_list_details/components/custom_app_bar.dart';
import 'package:spenza/ui/my_list_details/components/searchbox_widget.dart';
import 'package:spenza/ui/my_list_details/components/user_selected_product_widget.dart';
import 'package:spenza/ui/my_list_details/provider/list_details_provider.dart';
import 'package:spenza/ui/my_list_details/provider/user_product_list_provider.dart';
import 'package:spenza/utils/color_utils.dart';
import 'package:spenza/utils/spenza_extensions.dart';

import 'provider/display_spenza_button_provider.dart';

class MyListDetailsScreen extends ConsumerStatefulWidget {
  const MyListDetailsScreen(
      {super.key,
        required this.listId,
        required this.name,
        required this.photo,
        required this.path});

  final String listId;
  final String name;
  final String photo;
  final String path;

  @override
  ConsumerState createState() => _MyListDetailsScreenState();
}

class _MyListDetailsScreenState extends ConsumerState<MyListDetailsScreen>
    with PopupMenuMixin, WidgetsBindingObserver {
  final TextEditingController _searchController = TextEditingController();
  bool hasValueChanged = false;
  final _focusNode = FocusNode();
  KeyboardVisibilityController _keyboardVisibilityController = KeyboardVisibilityController();

  final List<PopupMenuItem<PopupMenuAction>> items = [
    PopupMenuItem(
      child: ListTile(
        leading: const Icon(Icons.edit),
        title: Text(PopupMenuAction.edit.value),
      ),
      value: PopupMenuAction.edit,
    ),
    PopupMenuItem(
      child: ListTile(
        leading: const Icon(Icons.upload),
        title: Text(PopupMenuAction.upload.value),
      ),
      value: PopupMenuAction.upload,
    ),
    PopupMenuItem(
      child: ListTile(
        leading: const Icon(Icons.receipt),
        title: Text(PopupMenuAction.receipt.value),
      ),
      value: PopupMenuAction.receipt,
    ),
    PopupMenuItem(
      child: ListTile(
        leading: const Icon(Icons.copy),
        title: Text(PopupMenuAction.copy.value),
      ),
      value: PopupMenuAction.copy,
    ),
    PopupMenuItem(
      child: ListTile(
        leading: const Icon(Icons.delete),
        title: Text(PopupMenuAction.delete.value),
      ),
      value: PopupMenuAction.delete,
    ),
  ];

  @override
  void dispose() {
    print("Dispose Called on My List Details Screen");
    _searchController.dispose();
    _focusNode.dispose();

    ref.read(displaySpenzaButtonProvider.notifier).dispose();
    ref.invalidate(userProductListProvider);

    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }


  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    // todo change with package since deprecated.
    /*final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
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
  void initState() {
    super.initState();

    print("Init Called on My List Details Screen");

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(userProductListProvider.notifier).fetchProductFromListId();
      //  await ref.read(listDetailsProvider.notifier).getSelectedListDetails();
    });

    WidgetsBinding.instance.addObserver(this);

    _focusNode.addListener(() {
      print("Has focus: ${_focusNode.hasFocus}");

      ref.read(displaySpenzaButtonProvider.notifier).state =
      !_focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final poppinsFont = ref.watch(poppinsFontProvider).fontFamily;

    ref.listen(userProductListProvider, (previous, next) {
      next.maybeWhen(
        orElse: () {},
        data: (data) {
          ref.read(displaySpenzaButtonProvider.notifier).state =
              data != null && data.isNotEmpty;
        },
      );
    });

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          context.pop(hasValueChanged);
          return true;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child:
            CustomAppBar(
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
                  // context.pushNamed(RouteManager.addProductScreen);
                  context.pop(hasValueChanged);
                },
                onActionIconPressed: _onActionIconPressed
    ),

          ),
          body: Stack(
            children: [
              Column(
                children: [
                  SearchBox(
                    colors: Colors.white,
                    focusNode: _focusNode,
                    hint: "Add products",
                    controller: _searchController,
                    onSearch: (value) async {
                      Future.microtask(
                            () => ref
                            .read(userProductListProvider.notifier)
                            .saveUserProductListToServer(context: context),
                      );

                      _searchController.clear();

                      final bool? result = await context.pushNamed(
                        RouteManager.addProductScreen,
                        queryParameters: {'query': value},
                      );

                      if (result ?? false) {
                        ref
                            .read(userProductListProvider.notifier)
                            .fetchProductFromListId();
                      }
                    },
                  ),
                  const SizedBox(height: 1),
                  Expanded(
                    child: Consumer(
                      builder: (context, ref, child) {
                        final result = ref.watch(userProductListProvider);

                        return result.when(
                          data: (data) {
                            if (data == null) {
                              return Center(child: SpenzaCircularProgress());
                            } else if (data.isEmpty) {
                              return Center(
                                child: Text("No Product found"),
                              );
                            }

                            return ListView.builder(
                              itemCount: data.length+1,
                              itemBuilder: (context, index) {
                                if (index < data.length){
                                  final UserProduct product = data[index];
                                  return UserSelectedProductCard(
                                    measure: product.measure,
                                    listId: widget.listId,
                                    department: product.department,
                                    imageUrl: product.pImage,
                                    title: product.name,
                                    priceRange:
                                    "\$${product.minPrice} - \$${product.maxPrice}",
                                    product: product,
                                    isLastCard: index == data.length - 1,
                                  );
                                }else{
                                  return Container(
                                    color: Colors.transparent,
                                  );
                                }

                              },
                            );
                          },
                          error: (error, stackTrace) =>
                              Center(child: Text("$error")),
                          loading: () => Center(child: SpenzaCircularProgress()),
                        );
                      },
                    ),
                  ),

                ],
              ),
              Positioned(
                bottom: 20,
                right: 0,
                left: 0,
                child: Consumer(builder: (context, ref, child) {
                  final bool displayButton =
                  ref.watch(displaySpenzaButtonProvider);
                  return displayButton
                      ? buildMaterialButton(context)
                      : Container();
                }),)
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
        if (value == PopupMenuAction.upload) {
          debugPrint("upload");
          context.pushNamed(RouteManager.uploadReceiptScreen,
              queryParameters: {'list_id': widget.path});
        } else if (value == PopupMenuAction.receipt) {
          debugPrint("receipt action, ${widget.path}");
          context.pushNamed(RouteManager.displayReceiptScreen,
              queryParameters: {'list_ref': widget.path});
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
        } else if (value == PopupMenuAction.copy) {
          debugPrint("copy action");
          final bool result = await ref
              .read(userProductListProvider.notifier)
              .copyTheList(context: context);

          if (result) {
            hasValueChanged = true;
            context.showSnackBar(message: "List deleted successfully!");
          }
        }
      },
    );
  }

  Widget buildMaterialButton(BuildContext context) {
    return
      GestureDetector(
        onTap: () async {
          final bool? isSuccess = await ref
              .read(userProductListProvider.notifier)
              .saveUserProductListToServer(context: context);

          if (isSuccess ?? false)
            context.pushNamed(RouteManager.storeRankingScreen);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'spenza_compare.png'.assetImageUrl,
              fit: BoxFit.contain,
            ),
          ),
        ),
      );
  }
}
