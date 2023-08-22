import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/helpers/popup_menu_mixin.dart';
import 'package:spenza/ui/preloaded_list_screen/component/preloaded_list_widget.dart';
import 'package:spenza/utils/spenza_extensions.dart';
import '../../router/app_router.dart';
import '../home/provider/home_preloaded_list.dart';
import '../my_list_details/provider/user_product_list_provider.dart';

class PreloadedListScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PreloadedListScreenState();
}

class _PreloadedListScreenState extends ConsumerState<PreloadedListScreen> with PopupMenuMixin {
  final poppinsFont = GoogleFonts.poppins().fontFamily;
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAllStore();
    });
  }

  Future<void> _loadAllStore() async {
    await ref.read(homePreloadedListProvider.notifier).fetchPreloadedList();
  }

  @override
  void dispose() {
    ref.invalidate(homePreloadedListProvider);
    super.dispose();
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
              .read(userProductListProvider.notifier)
              .copyTheList(context: context);

          if (result) {
            hasValueChanged = true;
            context.showSnackBar(message: "List copied successfully!");
          }

        }
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Text(
          "Preloaded Lists",
          style: TextStyle(
            fontFamily: poppinsFont,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xFF0CA9E6),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.pushReplacement(RouteManager.homeScreen);
          },
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF0CA9E6)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: InkWell(
              onTap: () {
                //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SettingScreen()));
              },
              child: CircleAvatar(
                radius: 40,
                child: ClipOval(
                  child: Image.network('https://picsum.photos/250?image=9'),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Consumer(
          builder: (context, ref, child) {
            final preloadedListProvider = ref.watch(homePreloadedListProvider);
            return preloadedListProvider.when(
              loading: () => Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) {
                print("errorMrss $error");
                return Center(child: Text(error.toString()));
              },
              data: (data) {
                print("preloadedList $data");
                return PreloadedListWidget(
                  data: data,
                   onButtonClicked: (itemPath) {
                    _onActionIconPressed(itemPath);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
