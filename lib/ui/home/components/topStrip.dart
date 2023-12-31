import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/router/app_router.dart';
import 'package:spenza/ui/home/components/add_list.dart';
import 'package:spenza/ui/home/data/my_list_model.dart';

import '../provider/fetch_mylist_provider.dart';
import 'new_list_dialog.dart';

class TopStrip extends ConsumerStatefulWidget {
  const TopStrip({Key? key}) : super(key: key);

  @override
  ConsumerState<TopStrip> createState() => _TopStripState();
}

class _TopStripState extends ConsumerState<TopStrip> {
  final poppinsFont = GoogleFonts.poppins().fontFamily;

  bool result = false;

  @override
  void initState() {
    super.initState();
    print("init");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadMyList();
    });
  }

  _loadMyList() async {
    await ref.read(fetchMyListProvider.notifier).fetchMyListFun();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'My Lists',
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
                    onPressed: () {
                      context.goNamed(RouteManager.myListDetailScreen, queryParameters:{'source': "withoutbottom"} );
                    },
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
          Consumer(builder: (context, ref, child) {
            final mylist = ref.watch(fetchMyListProvider);
            return mylist.when(
              loading: () => Center(child: CircularProgressIndicator()),
              data: (data) {
                if (data.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 120,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Image.asset(
                              'assets/images/mylist.gif',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'You don\'t have any\nlists yet, make one\nnow',
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
                    ),
                  );
                } else {
                  return Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        MyListModel list = data[index];
                        var fileName = list.myListPhoto ?? "";
                        return GestureDetector(
                          onTap: () {
                            context.pushNamed(RouteManager.myListDetailScreen,
                                queryParameters: {'list_id': list.documentId});
                            print("${list.documentId}");
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              leadingWidget(fileName),
                              Text(
                                list.name ?? '',
                                style: const TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                list.description ?? '',
                                style: const TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              },
              error: (Object error, StackTrace stackTrace) =>
                  Center(child: Text(error.toString())),
            );
          }),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Align(
              alignment: Alignment.centerRight,
              child: CircleAvatar(
                backgroundColor: Colors.greenAccent,
                radius: 20,
                child: ClipOval(
                  child: IconButton(
                      onPressed: () async {
                        /*Navigator.of(context)
                            .push(
                              MaterialPageRoute(
                                  builder: (context) => AddItemToList()),
                            )
                            .then((value) => _loadMyList());*/

                      },
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 25,
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget leadingWidget(String fileName) {
    if (fileName.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.asset(
          "assets/images/logo.png",
          fit: BoxFit.fill,
          width: 100,
          height: 130,
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: CachedNetworkImage(
          imageUrl: fileName,
          fit: BoxFit.fill,
          width: 100,
          height: 130,
        ),
      );
    }
  }
}
