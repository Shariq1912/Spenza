import 'package:flutter/material.dart';
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
import 'package:spenza/ui/pre_loaded_list_details/components/pre_loaded_product_widget.dart';
import 'package:spenza/utils/color_utils.dart';
import 'package:spenza/utils/spenza_extensions.dart';

import '../home/provider/home_preloaded_list.dart';

class PreLoadedListDetailsScreen extends ConsumerStatefulWidget {
  const PreLoadedListDetailsScreen(
      {super.key,
      required this.listId,
      required this.name,
      required this.photo});

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
      Future.wait([
        ref.read(userProductListProvider.notifier).fetchProductFromListId(
              isPreloadedList: true,
            ),
        ref.read(listDetailsProvider.notifier).getSelectedListDetails(
              isPreloadedList: true,
            ),
      ]);
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
          return true;
        },
        child: Scaffold(
          backgroundColor: Colors.white,

          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Consumer(
              builder: (context, ref, child) {
                return ref.watch(listDetailsProvider).maybeWhen(
                      data: (data) => CustomAppBar(
                        displayActionIcon: true,
                        title: widget.name,
                        logo: "app_icon_spenza.png" ?? "",
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
                        /* onActionIconPressed: () {
                         // _onActionIconPressed("preloaded_default/${widget.listId}");
                          _onActionIconPressed("preloaded_default/${widget.listId}");
                        }*/
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
                        /*onActionIconPressed:() {
                          _onActionIconPressed("preloaded_default/${widget.listId}");
                        },*/
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
                      loading: () => Center(child: SpenzaCircularProgress()),
                      data: (data) {
                        if (data == null) {
                          return Center(child: SpenzaCircularProgress());
                        } else if (data.isEmpty) {
                          return Center(
                            child: Text("No Product found"),
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
                              priceRange:
                                  "\$${product.minPrice} - \$${product.maxPrice}",
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
                          data: (data) => data == null
                              ? Container()
                              : data.isEmpty
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
          context.pushNamed(RouteManager.uploadReceiptScreen,
              queryParameters: {'list_id': itemPath});
        } else if (value == PopupMenuAction.receipt) {
          context.pushNamed(RouteManager.displayReceiptScreen,
              queryParameters: {'list_ref': itemPath});
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

  Widget buildMaterialButton(BuildContext context) {
    return InkWell(
      splashColor: ColorUtils.colorSurface,
      onTap: () async {
        context.pushNamed(RouteManager.storeRankingScreen);
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: ColorUtils.colorPrimary,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(color: ColorUtils.colorPrimary),
        ),
        margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 8,
                child: /*Image.asset(
                    'spenza_no_bg.png'.assetImageUrl,
                    fit: BoxFit.contain,
                  ),*/
                    Text(
                  "Spenza",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontFamily: GoogleFonts.calistoga().fontFamily,
                      color: Colors.white,
                      fontSize: 25),
                  textAlign: TextAlign.center,
                )),
            /* Expanded(
                  flex: 1,
                  child: Image.asset(
                    'app_icon_spenza.png'.assetImageUrl,
                    fit: BoxFit.contain,
                  ),
                ),*/
            Expanded(
              flex: 1,
              child: Image.asset(
                'app_icon_spenza.png'.assetImageUrl,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
