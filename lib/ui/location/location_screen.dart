import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spenza/ui/location/location_provider.dart';
import 'package:spenza/ui/location/widget/zip_code_widget.dart';

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

    ref.read(locationPermissionProvider.notifier).requestLocationPermission();
  }

  @override
  void dispose() {
    super.dispose();
    zipCodeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final location = ref.watch(locationPermissionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Location")),
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
                    },
                  );
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
