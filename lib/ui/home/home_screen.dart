import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spenza/ui/home/provider/fetch_mylist_provider.dart';
import 'package:spenza/ui/home/repo/fetch_favourite_store_repository.dart';
import '../../router/app_router.dart';
import 'components/myStore.dart';
import 'components/preLoadedList.dart';
import 'components/topStrip.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadStores();
    });
  }

  _loadStores() async {
    await ref.read(fetchMyListProvider.notifier).fetchMyListFun();
    await ref
        .read(fetchFavouriteStoreRepositoryProvider.notifier)
        .fetchFavStores();
  }
  @override
  void dispose() {
    // Dispose Riverpod providers or any resources here
    ref.invalidate(fetchMyListProvider);
    ref.invalidate(fetchFavouriteStoreRepositoryProvider);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: topAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  constraints: BoxConstraints(minHeight: 190),
                  color: Colors.blue,
                  child: const TopStrip(),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 25, left: 10, right: 10),
                child: PreLoadedList(),
              ),


              Consumer( builder: (context, ref, child) {
                final storeProvider = ref.watch(fetchFavouriteStoreRepositoryProvider);
                return storeProvider.when(
                        () => Container(),
                    loading: () => Center(child: CircularProgressIndicator()),
                    error: (message) => Center(child: Text(message)),
                    success: (data){
                      if (data.isEmpty) {return Center(child: Text("No stores available"));}
                      else {
                        return Padding(padding: EdgeInsets.only(left: 10, right: 10), child: MyStores(data: data),
                        );
                      }
                    },
                  empty: (message) => Text("You don't have any favourite store"),
                  redirectUser: () {return Container();},
                );
                }
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar topAppBar() {
    return AppBar(
        elevation: 5.0,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              top: 5,
            ),
            child: InkWell(
              onTap: () {
                context.push(RouteManager.settingScreen);
              },
              child: CircleAvatar(
                radius: 40,
                child: ClipOval(
                  child: Image.network('https://picsum.photos/250?image=9'),
                ),
              ),
            ),
          )
        ],
        title: SizedBox(
          width: 100,
          height: 100,
          child: Image.asset('assets/images/logo.gif'),
        ),
        centerTitle: true);
  }
}
