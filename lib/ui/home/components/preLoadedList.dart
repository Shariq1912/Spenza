import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PreLoadedList extends StatefulWidget {
  const PreLoadedList({Key? key}) : super(key: key);

  @override
  State<PreLoadedList> createState() => _PreLoadedListState();
}

class _PreLoadedListState extends State<PreLoadedList> {
  final poppinsFont = GoogleFonts.poppins().fontFamily;
  @override
  Widget build(BuildContext context) {
    return _preloadedListWidget();
  }

  Widget _preloadedListWidget() {
    return Column(
      children: [
         Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'Preloaded list',
                style: TextStyle(
                  fontFamily: poppinsFont,
                    decoration: TextDecoration.none,
                    color: Color(0xFF0CA9E6),
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {},
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
          height: 180,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                preloadedListItem('Single'),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: preloadedListItem('Couple'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: preloadedListItem('Family'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: preloadedListItem('Couple'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: preloadedListItem('Family'),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget preloadedListItem(String text) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 100,
          height: 100,
          color: Colors.red,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            text ?? '',
            style: const TextStyle(
                decoration: TextDecoration.none,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        )
      ],
    );
  }
}