import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/ui/my_store/data/all_store.dart';
import 'package:spenza/ui/my_store/my_store_provider.dart';
import 'package:spenza/ui/my_store/widget/my_store_list_widget.dart';

class Stores extends ConsumerStatefulWidget {
  const Stores({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StoresState();
}

class _StoresState extends ConsumerState<Stores> {
  final poppinsFont = GoogleFonts.poppins().fontFamily;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAllStore();
    });
  }

  Future<void> _loadAllStore() async {
    await ref.read(allStoreProvider.notifier).fetchAllStores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Stores",
          style: TextStyle(
            fontFamily: poppinsFont,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xFF0CA9E6),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back_ios, color: Color(0xFF0CA9E6))),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              top: 5,
            ),
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
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Consumer(
          builder: (context, ref, child) {
            final storeProvider = ref.watch(allStoreProvider);
            return storeProvider.when(
              () => Container(),
              loading: () => Center(child: CircularProgressIndicator()),
              error: (message) => Center(child: Text(message)),
              success: (data) {
                print("allStoredata $data");
                return MyStoreListWidget(stores: data, onButtonClicked: (AllStores allstore) {});
              },
            );
          },
        ),
      ),
    );
  }
}
