import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spenza/ui/settings/setting_Screen.dart';

import '../../router/app_router.dart';
import 'components/myStore.dart';
import 'components/preLoadedList.dart';
import 'components/topStrip.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                  height: 190,
                  color: Colors.blue,
                  child: const TopStrip(),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 25, left: 10, right: 10),
                child: PreLoadedList(),
              ),const Padding(
                padding: EdgeInsets.only( left: 10, right: 10),
                child: MyStores(),
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
            child:
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SettingScreen()));
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