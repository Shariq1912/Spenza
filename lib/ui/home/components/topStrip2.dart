import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/di/app_providers.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/home/components/my_list_item.dart';
import 'package:spenza/ui/home/components/new_list_dialog.dart';
import 'package:spenza/ui/home/data/my_list_model.dart';
import 'package:spenza/utils/spenza_extensions.dart';

import '../../../utils/color_utils.dart';


class TopStrip extends ConsumerWidget {
  final List<MyListModel> data;
  final VoidCallback onCreateList;
  final VoidCallback onAllList;
  final Function(String listId, String name, String photo, String path)
      onListClick;

  TopStrip({
    Key? key,
    required this.data,
    required this.onCreateList,
    required this.onAllList,
    required this.onListClick,
  }) : super(key: key);

  final arialFont = GoogleFonts.openSans().fontFamily;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final poppinsFont = ref.watch(poppinsFontProvider).fontFamily;

    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              onAllList();
            },
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: Text(
                      AppLocalizations.of(context)!.myListsTitle, // Updated
                      style: TextStyle(
                        fontFamily: poppinsFont,
                        decoration: TextDecoration.none,
                        color: ColorUtils.primaryText,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: ColorUtils.primaryText,
                      size: 18,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          if (data.isEmpty)
            _noItemInTheList(context)
          else
            Container(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.length + 1,
                itemBuilder: (context, index) {
                  if (index < data.length) {
                    MyListModel list = data[index];
                    return MyListItem(
                      imageUrl: list.myListPhoto ?? "",
                      name: list.name ?? "",
                      description: list.description ?? "",
                      onTap: () => onListClick.call(list.documentId!, list.name,
                          list.myListPhoto!, list.path!),
                    );
                  } else {
                    return MyListItem(
                      //imageUrl: "https://firebasestorage.googleapis.com/v0/b/spenzabeta-74e04.appspot.com/o/preloaded_list%2Fshopping_list_single_person.png?alt=media&token=1eae7be8-5443-4ac0-b1fe-a38698d14041",
                      imageUrl: "add_new_list_button.png".assetImageUrl  ,
                      name: "New List",
                      description: "",
                      onTap: () => showDialog(context: context, builder: (BuildContext context){
                       return NewMyList();
                      }, barrierDismissible: false),
                    );
                  }
                },
              ),
            ),
        ],
      ),
    );
  }

  Row _noItemInTheList(BuildContext context) {
    return Row(
      children: [
        MyListItem(
            //imageUrl: "https://firebasestorage.googleapis.com/v0/b/spenzabeta-74e04.appspot.com/o/preloaded_list%2Fshopping_list_single_person.png?alt=media&token=1eae7be8-5443-4ac0-b1fe-a38698d14041",
            imageUrl: "add_new_list_button.png".assetImageUrl,
            name: "New List",
            description: "",
            onTap: () => showDialog(context: context, builder: (BuildContext context){
              return NewMyList();
            },barrierDismissible: false),
        )
      ],
    );
  }
}
