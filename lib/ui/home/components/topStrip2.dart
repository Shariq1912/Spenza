import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spenza/di/app_providers.dart';
import 'package:spenza/ui/home/components/my_list_item.dart';
import 'package:spenza/ui/home/data/my_list_model.dart';
import 'package:spenza/utils/spenza_extensions.dart';

class TopStrip extends ConsumerWidget {
  final List<MyListModel> data;
  final VoidCallback onCreateList;
  final VoidCallback onAllList;
  final Function(String listId, String name, String photo, String path) onListClick;

  TopStrip({
    Key? key,
    required this.data,
    required this.onCreateList,
    required this.onAllList,
    required this.onListClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final poppinsFont = ref.watch(poppinsFontProvider).fontFamily;

    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  AppLocalizations.of(context)!.myListsTitle, // Updated
                  style: TextStyle(
                    fontFamily: poppinsFont,
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: onAllList,
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          if (data.isEmpty)
            _noItemInTheList(context)
          else
            Container(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  MyListModel list = data[index];
                  return MyListItem(
                    imageUrl: list.myListPhoto ?? "",
                    name: list.name ?? "",
                    description: list.description ?? "",
                    onTap: () => onListClick.call(list.documentId!, list.name, list.myListPhoto!, list.path!),
                  );
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Align(
              alignment: Alignment.centerRight,
              child: CircleAvatar(
                backgroundColor: Colors.greenAccent,
                radius: 20,
                child: ClipOval(
                  child: IconButton(
                    onPressed: onCreateList,
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _noItemInTheList(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 120,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Image.asset(
              'mylist.gif'.assetImageUrl,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Expanded(
          child: Text(
            AppLocalizations.of(context)!.noListsMessage,
            textAlign: TextAlign.justify,
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
