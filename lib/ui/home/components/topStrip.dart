import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopStrip extends StatefulWidget {
  const TopStrip({Key? key}) : super(key: key);

  @override
  State<TopStrip> createState() => _TopStripState();
}

class _TopStripState extends State<TopStrip> {
  final poppinsFont = GoogleFonts.poppins().fontFamily;

  @override
  Widget build(BuildContext context) {
    return topStrip();
  }

  Widget topStrip() {
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
                    onPressed: () {},
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
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                SizedBox(
                  height: 120, // Adjust the height as needed
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Image.asset(
                      'assets/images/mylist.gif',
                      fit: BoxFit.fill,
                    ),
                  ),
                ), // Add spacing between the image and text
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
                Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      backgroundColor: Colors.greenAccent,
                      radius: 20,
                      child: ClipOval(
                        child: IconButton(
                            onPressed: () {},
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
          ),
        ],
      ),
    );
  }
}
