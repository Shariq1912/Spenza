import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:spenza/ui/location/location_provider.dart';
import 'package:spenza/ui/location/widget/location_widget.dart';
import 'package:spenza/utils/spenza_extensions.dart';

import 'lat_lng_provider.dart';

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
  void dispose() {
    zipCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final location = ref.watch(positionProvider);
    final locationLatLng = ref.watch(locationProvider(zipCodeController.text));

    return Scaffold(
      appBar: AppBar(title: const Text("Location")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                location.when(
                  data: (position) =>
                      LocationWidget.buildLocationText(position),
                  loading: () => CircularProgressIndicator(),
                  error: (error, stackTrace) {
                    if (error is Exception &&
                        error
                            .toString()
                            .contains('Location service is denied')) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/marker.png',
                              fit: BoxFit.fitWidth,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Share your location with Spenza to find stores near you',
                              style: TextStyle(
                                  fontSize: 14, fontFamily: poppinsFont),
                            ),
                            SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              child: Form(
                                key: _formKey,
                                child: TextFormField(
                                  controller: zipCodeController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF99D6EF))),
                                    hintText: 'Enter ZIP code',
                                  ),
                                  validator: zipValidator,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ref
                                      .read(locationProvider(
                                              zipCodeController.text)
                                          .future)
                                      .then((LatLng? latLng) {
                                    if (latLng != null) {
                                      zipCodeController.clear();
                                      context.showSnackBar(
                                        message:
                                            "Latitude: ${latLng.latitude} and Longitude: ${latLng.longitude}",
                                      );
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Error'),
                                            content: Text(
                                                'No location found for the given postal code.'),
                                            actions: [
                                              TextButton(
                                                child: Text('Close'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  }).catchError((error) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Error'),
                                          content: Text(
                                              'Error occurred while retrieving location: $error'),
                                          actions: [
                                            TextButton(
                                              child: Text('Close'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Please enter the zip code.')),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                // Background color
                                foregroundColor: const Color(0xFF0CA9E6),
                                // Text color
                                textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: poppinsFont),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: const BorderSide(
                                        color: Color(
                                            0xFF99D6EF))), /*fixedSize: const Size(310, 40)*/
                              ),
                              child: Text('Get Location'),
                            ),
                          ],
                        ),
                      );
                    }
                    return Text('Error: $error');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
