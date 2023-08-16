import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/ui/preloaded_list_screen/component/preloaded_list_widget.dart';

import '../../router/app_router.dart';
import '../home/provider/home_preloaded_list.dart';

class PreloadedListScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PreloadedListScreenState();
}

class _PreloadedListScreenState extends ConsumerState<PreloadedListScreen> {
  final poppinsFont = GoogleFonts.poppins().fontFamily;

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
                print("allStoredata $data");
                return PreloadedListWidget(
                  data: data,
                  /* onButtonClicked: (AllStores allstore) {
                    _toggleFavorite(allstore);
                  },*/
                );
              },
            );
          },
        ),
      ),
    );
  }
}
