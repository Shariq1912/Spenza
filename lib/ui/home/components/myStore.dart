import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../my_store/my_store.dart';

class MyStores extends StatefulWidget {
  const MyStores({Key? key}) : super(key: key);

  @override
  State<MyStores> createState() => _MyStoresState();
}

class _MyStoresState extends State<MyStores> {
  final poppinsFont = GoogleFonts.poppins().fontFamily;
  @override
  Widget build(BuildContext context) {
    return _myStoriesWidget();
  }


  Widget _myStoriesWidget() {
    return Column(
      children: [
         Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'My Store',
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Color(0xFF0CA9E6),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                fontFamily: poppinsFont),
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Stores()));
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFF0CA9E6),
                      size: 32,
                    )),
              ),
            )
          ],
        ),
        SizedBox(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                myStoryListItem(),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: myStoryListItem(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: myStoryListItem(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: myStoryListItem(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: myStoryListItem(),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget myStoryListItem() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 100,
          height: 100,
          color: Colors.red,
        ),

      ],
    );
  }

}