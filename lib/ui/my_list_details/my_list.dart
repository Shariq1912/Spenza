import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../router/app_router.dart';
import '../home/provider/fetch_mylist_provider.dart';
import '../my_store/widget/my_store_list_widget.dart';
import 'components/my_list_widget.dart';

class MyList extends ConsumerStatefulWidget {
  const MyList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyListState();
}

class _MyListState extends ConsumerState<MyList> {
  final poppinsFont = GoogleFonts.poppins().fontFamily;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAllMyList();
    });
  }

  Future<void> _loadAllMyList() async {
    await ref.read(fetchMyListProvider.notifier).fetchMyListFun();
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
                  onButtonClicked: (listId) {
                    ref
                        .read(fetchMyListProvider.notifier)
                        .redirectUserToListDetailsScreen(
                      context: context,
                      listId: listId,
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