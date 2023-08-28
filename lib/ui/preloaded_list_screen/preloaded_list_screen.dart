import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/helpers/popup_menu_mixin.dart';
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

class _PreloadedListScreenState extends ConsumerState<PreloadedListScreen> with PopupMenuMixin,AutomaticKeepAliveClientMixin  {
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
  
  @override
  bool get wantKeepAlive => true;

  Future<void> _loadAllStore() async {
     ref.read(profileRepositoryProvider.notifier).getUserProfileData();
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
  @override
  Widget build(BuildContext context) {

    super.build(context);

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
                  }, onCardClicked: (listId, name, photo ) {
                  ref
                      .read(homePreloadedListProvider.notifier)
                      .redirectUserToListDetailsScreen(
                      context: context,
                      listId: listId,
                      name : name,
                      photo: photo,
                      ref: ref
                  );
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
