import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/helpers/popup_menu_mixin.dart';
import 'package:spenza/ui/common/spenza_circular_progress.dart';
import 'package:spenza/ui/preloaded_list_screen/component/preloaded_list_widget.dart';
import 'package:spenza/utils/spenza_extensions.dart';
import '../../router/app_router.dart';
import '../home/provider/home_preloaded_list.dart';
import '../profile/profile_repository.dart';

class PreloadedListScreen extends ConsumerStatefulWidget {

  const PreloadedListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PreloadedListScreenState();
}

class _PreloadedListScreenState extends ConsumerState<PreloadedListScreen>
    with PopupMenuMixin {
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
      _loadAllList();
    });
  }

  Future<void> _loadAllList() async {
    ref.read(profileRepositoryProvider.notifier).getUserProfileData();
    ref.read(homePreloadedListProvider.notifier).fetchPreloadedList();
  }

  @override
  void dispose() {
    ref.invalidate(homePreloadedListProvider);
    super.dispose();
  }

  /* void _onActionIconPressed(String itemPath) {
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
  }*/

  void _onActionIconPressed(String itemPath, PopupMenuAction action) async {
    if (action == PopupMenuAction.upload) {
      debugPrint("upload");
      context.pushNamed(RouteManager.uploadReceiptScreen,
          queryParameters: {'list_id': itemPath});
    } else if (action == PopupMenuAction.receipt) {
      debugPrint("receipt action, $itemPath");
      context.pushNamed(RouteManager.displayReceiptScreen,
          queryParameters: {'list_ref': itemPath});
    }   else if (action == PopupMenuAction.copy) {
      debugPrint("copy action");
      final bool result = await ref
          .read(homePreloadedListProvider.notifier)
          .copyDocument(itemPath);

      if (result) {
        hasValueChanged = true;
        context.showSnackBar(message: "List copied successfully!");
      }

    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        debugPrint("Will Pop Scope == $hasValueChanged");
        context.pop(hasValueChanged);
        return true;
      },
      child: Scaffold(
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
              context.pop();
            },
            icon: Icon(Icons.arrow_back_ios, color: Color(0xFF0CA9E6)),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: InkWell(onTap: () {
                //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SettingScreen()));
              }, child: Consumer(
                builder: (context, ref, child) {
                  final profilePro = ref.watch(profileRepositoryProvider);
                  return profilePro.when(
                        () => Container(),
                    loading: () => Container(),
                    error: (message) => ClipOval(
                      child: Image.asset('assets/images/user.png'),
                    ),
                    success: (data) {
                      if (data.profilePhoto != null &&
                          data.profilePhoto!.isNotEmpty) {
                        return CircleAvatar(
                          radius: 40,
                          child: ClipOval(
                            child: AspectRatio(
                              aspectRatio: 1.0,
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: data.profilePhoto,
                                placeholder: (context, url) =>  Image.asset('placeholder_myList.png'.assetImageUrl),
                                errorWidget: (context, url, error) => Image.asset('placeholder_myList.png'.assetImageUrl),
                              ),
                            ),
                          ),
                        );

                      } else {
                        return ClipOval(
                            child: AspectRatio(
                              aspectRatio: 1.0,
                              child:  Image.asset('user_placeholder.png'.assetImageUrl,fit: BoxFit.cover,),
                            )
                        );
                      }
                    },
                  );
                },
              )),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Consumer(
            builder: (context, ref, child) {
              final preloadedListProvider =
              ref.watch(homePreloadedListProvider);
              return preloadedListProvider.when(
                loading: () => Center(child: SpenzaCircularProgress()),
                error: (error, stackTrace) {
                  print("errorMrss $error");
                  return Center(child: Text(error.toString()));
                },
                data: (data) {
                  print("preloadedList $data");
                  return PreloadedListWidget(
                    data: data,
                    onButtonClicked: (itemPath,PopupMenuAction action) {
                      _onActionIconPressed(itemPath,action);
                    },
                    onCardClicked: (listId, name, photo) {
                      ref
                          .read(homePreloadedListProvider.notifier)
                          .redirectUserToListDetailsScreen(
                        context: context,
                        listId: listId,
                        name: name,
                        photo: photo,
                        ref: ref,
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
