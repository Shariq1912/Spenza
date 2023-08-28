import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/ui/location/location_provider.dart';
import 'package:spenza/ui/location/widget/zip_code_widget.dart';
import 'package:spenza/ui/location/zipcode_provider.dart';

import '../../router/app_router.dart';

class LocationScreen extends ConsumerStatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LocationScreenState();
}

class _LocationScreenState extends ConsumerState<LocationScreen> {
  TextEditingController zipCodeController = TextEditingController();
  final poppinsFont = GoogleFonts.poppins().fontFamily;
  final zipValidator = MultiValidator([
    RequiredValidator(errorText: 'field can not be empty'),
  ]);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _loadData();
  });

  }
  Future<void> _loadData() async {
     ref.read(zipcodeProvider.notifier).fetchZipCode();
     ref.read(locationPermissionProvider.notifier).requestLocationPermission();

  }

  @override
  void dispose() {
    super.dispose();
    zipCodeController.dispose();
    ref.invalidate(locationPermissionProvider);
    ref.invalidate(zipcodeProvider);
  }

  @override
  Widget build(BuildContext context) {
    final location = ref.watch(locationPermissionProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.goNamed(RouteManager.splashScreen);
          },
          icon: Icon(Icons.chevron_left_outlined,size: 35,color: Color(0xFF0CA9E6),),
        ),

      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              location.when(
                () => Container(),
                success: (position) {
                  // todo  Will be replaced with container, no need to show text
                  // todo redirect user to favorite store screen.
                  // context.goNamed(RouteManager.favouriteScreen);
                  ref
                      .read(locationPermissionProvider.notifier)
                      .redirectUserToDestination(context: context);

                  return Container();
                },
                loading: () => Center(child: CircularProgressIndicator()),
                denied: () {
                  final zipcodes = ref.watch(zipcodeProvider);

                  return zipcodes.when(
                      data: (data){
                        return ZipCodeWidget(
                          zipCodeController: zipCodeController,
                          formKey: _formKey,
                          validator: zipValidator,
                          onPressed: () {
                            ref.read(locationPermissionProvider.notifier)
                                .processZipCodeEnteredByUser(
                              zipCodeController.text,
                            );
                            print("Data value: $data");
                          }, zipcode: data,
                        );
                      },
                      error: (error, stackTrace){
                        return ZipCodeWidget(
                          zipCodeController: zipCodeController,
                          formKey: _formKey,
                          validator: zipValidator,
                          onPressed: () {
                            ref
                                .read(locationPermissionProvider.notifier)
                                .processZipCodeEnteredByUser(
                              zipCodeController.text,
                            );
                          }, zipcode: [],
                        );
                      },
                      loading: () => CircularProgressIndicator());
                },
                error: (error) {
                  // todo this sometimes shows error when location not found with zip code then redirect to favorite store
                  // todo because zip code already stored in the database.
                  debugPrint('Error: $error');
                  ref
                      .read(locationPermissionProvider.notifier)
                      .redirectUserToDestination(context: context);
                  return Center(child: Text('Error: $error'));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
