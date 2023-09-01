import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDialog extends StatelessWidget {
  CustomDialog({Key? key}) : super(key: key);
  final poppinsFont = GoogleFonts.poppins().fontFamily;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(),
      child: contentBox(context),
      elevation: 0,
    );
  }

  contentBox(context) {
    List<Map<String, dynamic>> staticData = [
      {
        'imageUrl':
            'https://firebasestorage.googleapis.com/v0/b/spenzabeta-74e04.appspot.com/o/preloaded_list%2Fshopping_list_hygenic.jpg?alt=media&token=2941b084-b4be-4fe5-aef8-32cd2b557319',
        'title': 'Item 1',
        'subtitle': 'Subtitle 1',
      },
      {
        'imageUrl':
            'https://firebasestorage.googleapis.com/v0/b/spenzabeta-74e04.appspot.com/o/preloaded_list%2Fshopping_list_hygenic.jpg?alt=media&token=2941b084-b4be-4fe5-aef8-32cd2b557319',
        'title': 'Item 2',
        'subtitle': 'Subtitle 2',
      },

      {
        'imageUrl':
            'https://firebasestorage.googleapis.com/v0/b/spenzabeta-74e04.appspot.com/o/preloaded_list%2Fshopping_list_hygenic.jpg?alt=media&token=2941b084-b4be-4fe5-aef8-32cd2b557319',
        'title': 'Item 1',
        'subtitle': 'Subtitle 1',
      },
      {
        'imageUrl':
            'https://firebasestorage.googleapis.com/v0/b/spenzabeta-74e04.appspot.com/o/preloaded_list%2Fshopping_list_hygenic.jpg?alt=media&token=2941b084-b4be-4fe5-aef8-32cd2b557319',
        'title': 'Item 2',
        'subtitle': 'Subtitle 2',
      },
      {
        'imageUrl':
            'https://firebasestorage.googleapis.com/v0/b/spenzabeta-74e04.appspot.com/o/preloaded_list%2Fshopping_list_hygenic.jpg?alt=media&token=2941b084-b4be-4fe5-aef8-32cd2b557319',
        'title': 'Item 1',
        'subtitle': 'Subtitle 1',
      },
      {
        'imageUrl':
            'https://firebasestorage.googleapis.com/v0/b/spenzabeta-74e04.appspot.com/o/preloaded_list%2Fshopping_list_hygenic.jpg?alt=media&token=2941b084-b4be-4fe5-aef8-32cd2b557319',
        'title': 'Item 2',
        'subtitle': 'Subtitle 2',
      },

      {
        'imageUrl':
            'https://firebasestorage.googleapis.com/v0/b/spenzabeta-74e04.appspot.com/o/preloaded_list%2Fshopping_list_hygenic.jpg?alt=media&token=2941b084-b4be-4fe5-aef8-32cd2b557319',
        'title': 'Item 1',
        'subtitle': 'Subtitle 1',
      },
      {
        'imageUrl':
            'https://firebasestorage.googleapis.com/v0/b/spenzabeta-74e04.appspot.com/o/preloaded_list%2Fshopping_list_hygenic.jpg?alt=media&token=2941b084-b4be-4fe5-aef8-32cd2b557319',
        'title': 'Item 2',
        'subtitle': 'Subtitle 2',
      },
    ];
    return Container(
      height: 500,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
        child: Column(
          children: [
            Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.close,
                      color: Color(0xFF7B868C),
                      size: 35,
                    ))),
            Text(
              "Choose your list where you want to add product",
              style: TextStyle(
                  color: Color(0xFF0da9ea),
                  fontFamily: poppinsFont,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: staticData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    color: Color(0xFFE5E7E8),
                    margin: EdgeInsets.only(top: 8, bottom: 8),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          width: 110,
                          height: 110,
                          child: Image.network(
                            staticData[index]['imageUrl'],
                            width: 110,
                            height: 110,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              staticData[index]['title'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            // Handle button press
                          },
                          icon: Icon(Icons.playlist_add_rounded),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text("Add the product to a new list",
                  style: TextStyle(
                      color: Color(0xFF0da9ea),
                      fontFamily: poppinsFont,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0CA9E6),
                foregroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: poppinsFont,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                fixedSize: const Size(310, 40),
              ),
              child: Text("Create my list"),
            ),
          ],
        ),
      ),
    );
  }
}
