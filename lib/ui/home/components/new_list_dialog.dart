import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/utils/spenza_extensions.dart';

class NewMyList extends StatelessWidget {
    NewMyList({Key? key}) : super(key: key);

   final poppinsFont = GoogleFonts.poppins().fontFamily;

  final fieldValidator = MultiValidator([
    RequiredValidator(errorText: 'Field is required'),
  ]);
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
  contentBox(context){
    return Container(
      height: 330,
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
          Container(
            width: 100,
            height: 100,
            child:Image.asset('upload_images.png'.assetImageUrl,
                fit: BoxFit.cover),
          ),
          Text(
            "Upload photo for your list",
            style: TextStyle(
                color: Color(0xFF7B868C),
                fontFamily: poppinsFont,
                fontWeight: FontWeight.bold,fontSize: 12),
          ),
          SizedBox(height: 15,),
          TextFormField(
              decoration: InputDecoration(
                hintText:"Name of your list",
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Color(0xFFE5E7E8),
              ),
              validator: fieldValidator),

          SizedBox(height: 15,),
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
            child: Text("Create My List"),
          ),
        ],
      ),
    );
  }
}
