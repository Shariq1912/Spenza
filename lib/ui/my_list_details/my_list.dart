import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/ui/my_list_details/provider/list_details_provider.dart';
import 'package:spenza/ui/my_list_details/provider/user_product_list_provider.dart';
import 'package:spenza/utils/spenza_extensions.dart';

import '../../helpers/popup_menu_mixin.dart';
import '../../router/app_router.dart';
import '../home/provider/fetch_mylist_provider.dart';
import '../profile/profile_repository.dart';
import 'components/my_list_widget.dart';

class MyList extends ConsumerStatefulWidget {
  const MyList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyListState();
}

class _MyListState extends ConsumerState<MyList> with PopupMenuMixin {
  final poppinsFont = GoogleFonts.poppins().fontFamily;
  bool hasValueChanged = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAllMyList();
    });
  }

  Future<void> _loadAllMyList() async {
     ref.read(profileRepositoryProvider.notifier).getUserProfileData();
    await ref.read(fetchMyListProvider.notifier).fetchMyListFun();
  }

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
          debugPrint("upload");
          context.pushNamed(RouteManager.uploadReceiptScreen,queryParameters: {'list_id': itemPath});

        } else if (value == PopupMenuAction.receipt) {
          debugPrint("receipt action, $itemPath");
          context.pushNamed(RouteManager.displayReceiptScreen,queryParameters: {'list_ref': itemPath});

        }
        else if (value == PopupMenuAction.delete) {
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
        else if (value == PopupMenuAction.copy) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Text(
          "My Lists",
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
              child: Consumer(
                builder: (context, ref, child) {
                  final profilePro = ref.watch(profileRepositoryProvider);
                  return profilePro.when(
                        () => Container(),
                    loading: () => Center(child: CircularProgressIndicator()),
                    error: (message) => ClipOval(
                      child: Image.asset('assets/images/user.png'),
                    ),
                    success: (data) {
                      if (data.profilePhoto != null && data.profilePhoto!.isNotEmpty) {
                        return CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.08,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: data.profilePhoto!,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );

                      } else {
                        return CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.08, // Adjust the multiplier as needed
                          backgroundColor: Colors.white,
                          child: ClipOval(
                              child: Image.asset('assets/images/user.png')
                          ),
                        );
                      }
                    },
                  );
                },
              )
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Consumer(
          builder: (context, ref, child) {
            final storeProvider = ref.watch(fetchMyListProvider);
            return storeProvider.when(

              loading: () => Center(child: CircularProgressIndicator()),
              error: (error,stackTrace) {
                print("errorMrss $error");
                return Center(child: Text(error.toString()));
              },
              data: (data) {
                print("allStoredata $data");
                return MyListWidget(
                  stores: data,
                  onButtonClicked: (listId, name, photo, path) {
                    ref.read(fetchMyListProvider.notifier).redirectUserToListDetailsScreen(context: context, listId: listId,name: name, photo: photo, path:path!);
                  }, onPopUpClicked: (String path) {
                    _onActionIconPressed(path);
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