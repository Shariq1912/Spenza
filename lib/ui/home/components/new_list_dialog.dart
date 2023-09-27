import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spenza/ui/home/data/my_list_model.dart';
import 'package:spenza/ui/home/provider/image_picker_provider.dart';
import 'package:spenza/ui/home/provider/save_mylist_provider.dart';
import 'package:spenza/utils/spenza_extensions.dart';

class NewMyList extends ConsumerStatefulWidget {
    NewMyList({Key? key}) : super(key: key);

  @override
  ConsumerState<NewMyList> createState() => _NewMyListState();
}

class _NewMyListState extends ConsumerState<NewMyList> {
   final poppinsFont = GoogleFonts.poppins().fontFamily;
   final robotoFont = GoogleFonts.roboto().fontFamily;
   File? selectedImage;
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   TextEditingController nameController = TextEditingController();

  final fieldValidator = MultiValidator([
    RequiredValidator(errorText: 'Field is required'),
  ]);



   Future<void> _saveData(BuildContext context) async {
     File defaultImage = await getImageFileFromAssets('images/app_icon_spenza.png');
     MyListModel myListData = MyListModel(
       name: nameController.text.trim(),
       uid: "",
       usersRef: "",
       myListPhoto: selectedImage?.path ?? 'assets/images/app_icon_spenza.png', description: '',
     );
     if(selectedImage!= null){
       ref
           .read(saveMyListProvider.notifier)
           .saveMyListFun(myListData, selectedImage,context);
     }
     else{
       ref
           .read(saveMyListProvider.notifier)
           .saveMyListFun(myListData, defaultImage,context);
     }

   }
   @override
  void dispose() {
     ref.read(imagePickerProvider.notifier).state = null;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17),
      ),
      child: contentBox(context),
      elevation: 0,


    );
  }

  contentBox(context){
    bool isPhotoSelected = ref.watch(imagePickerProvider) != null;
    return Container(
      height: 330,
      padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    ref.read(imagePickerProvider.notifier).state = null;
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: Image.asset(
                        "x_close.png".assetImageUrl,
                      ),
                    ),
                  ),
                )),
            GestureDetector(
              onTap: () async {
                final pickedImage =
                await ImagePicker().pickImageFromGallery(context);
                if (pickedImage != null) {
                  ref.read(imagePickerProvider.notifier).state =
                      pickedImage;
                }
              },
              child: Container(
                width: 100,
                height: 100,
                child:Consumer( builder: (context, ref, child) {
                   selectedImage = ref.watch(imagePickerProvider);
                  return selectedImage !=null ? Image.file(selectedImage!,fit: BoxFit.cover):
                  Image.asset('upload_images.png'.assetImageUrl,
                      fit: BoxFit.cover);
                }
                ),

              ),
            ),
            Visibility(
              visible: !isPhotoSelected,
              child: Text(
                "Upload photo for your list",
                style: TextStyle(
                    color: Color(0xFF7B868C),
                    fontFamily: robotoFont,
                    fontWeight: FontWeight.bold,fontSize: 12),
              ),
            ),
            SizedBox(height: 15,),
            TextFormField(
                decoration: InputDecoration(
                  hintText:"Name your list",
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Color(0xFFE5E7E8),
                ),
                validator: fieldValidator,
            controller: nameController,),

            SizedBox(height: 15,),
           /* ElevatedButton(
              onPressed: () {

              },
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
            ),*/
            SizedBox(
              width: double.infinity,
              child: Consumer(
                  builder: (context, ref, child) =>
                      ref.watch(saveMyListProvider).maybeWhen(
                        loading: () => Center(
                          child: CircularProgressIndicator(),
                        ),
                        orElse: () => ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _saveData(context);

                            }

                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF0CA9E6),
                            foregroundColor: Colors.white,
                            textStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: poppinsFont,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Text("Create My List", style: TextStyle(fontFamily: robotoFont),),
                        ),
                      )),
            ),
          ],
        ),
      ),
    );
  }

   Future<File> getImageFileFromAssets(String path) async {
     final byteData = await rootBundle.load('assets/$path');

     final file = File('${(await getTemporaryDirectory()).path}/$path');
     await file.create(recursive: true);
     await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

     return file;
   }
}
